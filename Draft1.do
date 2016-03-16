** OLS ESTIMATES
eststo clear


* Regular Estimates
eststo clear

eststo: quietly  xtreg rateofoutofschoolMF l.survival_rate i.year loggdpcap logpop if in_sample == 1, fe robust cluster(pan_id)
//outreg2 using draft1tab.tex, label nocons keep(l.survival_rate loggdpcap logpop) replace ctitle("1-year Lag, All Countries") title("OLS Estimates")

eststo: quietly xtreg rateofoutofschoolMF l5.survival_rate i.year loggdpcap logpop if in_sample == 1, fe robust cluster(pan_id)
//outreg2 using draft1tab.tex, label nocons keep(l5.survival_rate loggdpcap logpop) append ctitle("5-year Lag, All Countries") 

eststo: quietly xtreg rateofoutofschoolMF l.survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
//outreg2 using draft1tab.tex, label nocons keep(l.survival_rate loggdpcap logpop) append ctitle("1-year Lag, GAVI-Countries") 

eststo: quietly xtreg rateofoutofschoolMF l5.survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
//outreg2 using draft1tab.tex, label nocons keep(l5.survival_rate loggdpcap logpop) append ctitle("5-year Lag, GAVI-Countries") 

eststo: quietly xtreg rateofoutofschoolMF l10.survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
//outreg2 using draft1tab.tex, label nocons keep(l10.survival_rate loggdpcap logpop) append ctitle("10-year Lag, GAVI-Countries") 
esttab using OLS.tex, replace label title("OLS Estimates") nonumbers compress mtitles("1-yr, All" "5-yr, All" "1-yr, GAVI" "5-yr, GAVI" "10-yr, GAVI")

* Long Differences     addtable                   write a new table below an existing table
eststo clear

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2000 | year == 2012), fe robust cluster(pan_id)
//outreg2 using draft2tab.tex, label nocons keep(survival_rate) replace  ctitle("NC, 1980/2000/2012") title("OLS, Long Differences")

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2000 | year == 2012), fe robust cluster(pan_id)
//outreg2 using draft2tab.tex, label nocons keep(survival_rate loggdpcap logpop) append  ctitle("C, 1980/2000/2012")

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
//outreg2 using draft2tab.tex, label nocons keep(survival_rate loggdpcap logpop) append  ctitle("C, 1980/1990/2000/2012")

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2012), fe robust cluster(pan_id)
//outreg2 using draft2tab.tex, label nocons keep(survival_rate loggdpcap logpop) append  ctitle("C, 1980/2012")

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1985 | year == 2005 | year == 1995), fe robust cluster(pan_id)
//outreg2 using draft2tab.tex, label nocons keep(survival_rate loggdpcap logpop) append  ctitle("C, 1985/1995/2005")

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1970 | year == 1990), fe robust cluster(pan_id)
//outreg2 using draft2tab.tex, label nocons keep(survival_rate loggdpcap logpop) append  ctitle("C, 1970/1990")
esttab using OLSlong.tex, replace label title("OLS Estimates, Long Differences") nonumbers compress mtitles("80/00/12 (NC)" "80/00/12" "80/90/00/12" "80/12" "85/95/05" "70/90")

*xtabond rateofoutofschoolMF survival_rate loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 

** Primary specification, IV ESTIMATES
* First Stage
xtreg mortality l.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

xtreg mortality l5.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

xtreg mortality l10.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)


* Reduced Form

* IV 

** ROBUSTNESS TESTS -- Autocorrelation

** ROBUSTNESS TESTS --  Non-Linearity 

* For countries with a high level of coverage (>50) in 1980, intervention date = 1974. Otherwise, intervention
* date = year when coverage > 50

* ROBUSTNESS/Different Specification -- intervention date
* intervention = 50% Coverage as instrument -- dummy = 1 in year of intervention and afterwards, 0 before intervention
xtreg measles_deaths_60mo intervention_year_dummy logpop loggdp i.year if gavi_status_00 == 1, fe robust cluster(pan_id)

* no signifigance with long differences * 

* First Stage 
xtreg survival_rate intervention_year_dummy logpop loggdp i.year if gavi_status_00 == 1, fe robust cluster(pan_id)

xtreg survival_rate intervention_year_dummy logpop loggdp i.year if gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

*no significgance with DTP
* Reduced Form

xtreg rateofoutofschoolMF intervention_year_dummy logpop loggdp i.year if gavi_status_00 == 1, fe robust cluster(pan_id)

xtreg rateofoutofschoolMF intervention_year_dummy logpop loggdp i.year if gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

xtreg rateofoutofschoolMF intervention_year_dummy logpop loggdp i.year if gavi_status_00 == 1 & (year == 1980  | year == 1990 | year == 2012), fe robust cluster(pan_id)

* Instrumental Variables 

xtivreg rateofoutofschoolMF (survival_rate = intervention_year_dummy) logpop loggdp i.year if gavi_status_00 == 1, fe 

xtivreg rateofoutofschoolMF (survival_rate = intervention_year_dummy) logpop loggdp i.year if gavi_status_00 == 1 & (year == 1980  | year == 1990 | year == 2012), fe




