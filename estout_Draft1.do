// First Draft Tables!!!!

* Zeroth Stage Estimates
xtreg measles_cases not_mcv_covered loggdp logpop i.year, fe robust cluster(pan_id)

eststo: quietly nbreg measles_cases unicefmcv1 c.unicefmcv1#i.SIA unicefmcv2 loggdp logpop if gavi_status_00 == 1

eststo: quietly nbreg measles_cases unicefmcv1 unicefmcv2 loggdp logpop if gavi_status_00 == 1

eststo: quietly nbreg dtp_cases unicefdtp1 unicefdtp3 loggdp logpop if gavi_status_00 == 1

esttab using Cases.tex, replace label title("Zeroth Stage Estimates") nonumbers compress mtitles("Measles" "DTP")


*OLS 
eststo clear

eststo: quietly xtreg rateofoutofschoolMF l.survival_rate i.year loggdpcap logpop, fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l5.survival_rate i.year loggdpcap logpop if in_sample == 1, fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l.survival_rate i.year loggdpcap logpop if gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l5.survival_rate i.year if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l10.survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)



esttab using OLS.tex, replace indicate("Year FE = *.year" "Controls = logpop") label booktabs title("OLS Estimates") se r2 noconstant nonumbers compress mtitles("All Countries" "All Countries, Base Sample" "GAVI-Countries" "GAVI-Countries, Base Sample" "GAVI-Countries, Base Sample")

*Long differences, OLS

eststo clear

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF survival_rate loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1970 | year == 1980 | year == 1990 | year == 2000 | year == 2012),fe robust 

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2012), fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1985 | year == 2005 | year == 1995), fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF survival_rate i.year if gavi_status_00 == 1 & (year == 1970 | year == 1990), fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l5.survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l10.survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)


esttab using OLSlong.tex, replace label title("OLS Estimates, Long Differences") se r2 indicate("Year FE = *.year" "Controls = logpop")  noconstant nonumbers compress mtitles("80/00/12" "80/00/12" "80/90/00/12" "Just 1980 and 2012" "85/95/05" "Just 1970 and 2012") booktabs


* First Stage, rate of coverage 
eststo clear

eststo: quietly xtreg survival_rate unicefmcv1 logpop loggdpcap if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly xtreg survival_rate unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly xtreg survival_rate l.unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly xtreg survival_rate l10.unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly xtreg survival_rate unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980| year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: quietly xtreg survival_rate unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1970| year == 2000), fe robust cluster(pan_id)

esttab using OLS.tex, replace indicate("Year FE = *.year" "Controls = logpop") label title("OLS Estimates") se r2 noconstant nonumbers compress mtitles("GAVI Countries" "GAVI Countries" "GAVI Countries") booktabs


// ZEROTH SPECIFICATION -- INTERVENTION DUMMY
* First Stage
xtreg survival_rate intervention_year_dummy i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

* Reduced Form
xtreg rateofoutofschoolMF intervention_year_dummy logpop loggdp i.year if gavi_status_00 == 1 & (year == 1980  | year == 1990 | year == 2012), fe robust cluster(pan_id)

* IV

// FIRST SPECIFICATION -- LEVEL OF COVERAGE AND SIA
eststo clear

* First Stage
eststo: quietly xtreg survival_rate unicefmcv1 l.unicefmcv1  i.year gavi_status_00 loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtreg survival_rate l.unicefmcv1 l2.unicefmcv1  i.year gavi_status_00 loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

* Reduced Form 
eststo: quietly xtreg rateofoutofschoolMF l.unicefmcv1 i.year gavi_status_00 loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l2.unicefmcv1 i.year gavi_status_00 loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

* IV 
eststo: quietly xtivreg rateofoutofschoolMF i.year gavi_status_00 loggdpcap logpop (l.survival_rate = l2.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe 

eststo: quietly xtivreg rateofoutofschoolMF i.year gavi_status_00 loggdpcap logpop (l2.survival_rate = l4.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe 

esttab using firstIV.tex, replace indicate("Year FE = *.year" "Controls = logpop") label title("Primary Specification") se r2 noconstant nonumbers compress mtitles("FS" "FS" "RF" "RF" "IV" "IV") booktabs nobaselevels star(*** 0.01 ** 0.05 * 0.1)

// SECOND SPECIFICATION -- LEVEL OF COVERAGE AND DUMMY
eststo clear

* First Stage
eststo: quietly xtreg survival_rate c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtreg survival_rate c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

* Reduced Form 

eststo: quietly xtreg rateofoutofschoolMF c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

* IV 

eststo: quietly xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.survival_rate  = c.l2.unicefmcv1#i.l2.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 

eststo: quietly xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.survival_rate  = c.l3.unicefmcv1#i.l3.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 

esttab using secondIV.tex, replace indicate("Year FE = *.year" "Controls = logpop") label title("Secondary Specification") se r2 noconstant nonumbers compress mtitles("FS" "FS" "RF" "RF" "IV" "IV") booktabs nobaselevels star(*** 0.01 ** 0.05 * 0.1)


// ROBUSTNESS CHECKS!! 

// Tests and Specifications with Serial Correlation
eststo clear 

* Wooldridge Tests for Autocorrelation - p-values of 0
xtserial survival_rate unicefmcv1 loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1

xtserial rateofoutofschoolMF survival_rate loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1

* Cochrane Orcutt Method 
prais survival_rate unicefmcv1 loggdp logpop if gavi_status_00 == 1, corc

prais rateofoutofschoolMF survival_rate loggdp logpop if gavi_status_00 == 1, corc

* Cochrane Orcutt Method -- panel data estimators 

eststo clear

eststo: quietly xtregar rateofoutofschoolMF survival_rate loggdp logpop if gavi_status_00 == 1, fe

eststo: quietly xtregar rateofoutofschoolMF unicefmcv1 loggdp logpop if gavi_status_00 == 1, fe

eststo: quietly xtregar survival_rate unicefmcv1 loggdp logpop if gavi_status_00 == 1, fe

esttab using coco.tex, replace  label title("Autocorrelation") se r2 noconstant nonumbers compress mtitles("OLS" "RF" "FS") booktabs nobaselevels star(* 0.1 ** 0.05  *** 0.01 )

// Falsification Exercises 

// Nonlinearity of Vaccine Coverage: Splines





