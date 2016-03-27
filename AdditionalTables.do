*** Non Human Capital Health Outcomes, Long Differences** 
** OLS estimates** 
eststo clear

eststo: xtreg fertility survival_rate loggdpcap logpop i.year  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1985 | year == 1995| year == 2005 |year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
eststo: xtreg logpop  survival_rate loggdpcap fertility  i.year  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: xtreg loggdpcap survival_rate logpop fertility  i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: xtreg loggdp  survival_rate logpop fertility  i.year  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: xtreg fertility loglifeexpect loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: xtreg logpop  loglifeexpect loggdpcap fertility   i.year  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: xtreg loggdpcap loglifeexpect logpop fertility  i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

eststo: xtreg loggdp  loglifeexpect logpop fertility  i.year  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

esttab using OLSGrowth.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Non-Human Capital Growth Outcomes: OLS") se r2 noconstant compress nobaselevels  star(+ 0.10 * 0.05 ** 0.01 *** 0.001)

** IV **
eststo: xtivreg2 fertility loggdpcap logpop yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 &  (year == 1980 | year == 1990 | year == 2000 | year == 2010), fe robust cluster(pan_id)

eststo: xtivreg2 logpop loggdpcap fertility yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 &  (year == 1980 | year == 1990 | year == 2000 | year == 2010), fe robust cluster(pan_id)

eststo: xtivreg2 loggdpcap logpop fertility yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 &  (year == 1980 | year == 1990 | year == 2000 | year == 2010), fe robust cluster(pan_id)

eststo: xtivreg2 loggdp logpop fertility yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 &  (year == 1980 | year == 1990 | year == 2000 | year == 2010), fe robust cluster(pan_id)

eststo: xtivreg2 fertility loggdpcap logpop yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 &  (year == 1980 | year == 1990 | year == 2000 | year == 2010), fe robust cluster(pan_id)

eststo: xtivreg2 logpop loggdpcap fertility yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 &  (year == 1980 | year == 1990 | year == 2000 | year == 2010), fe robust cluster(pan_id)

eststo: xtivreg2 loggdpcap logpop fertility yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 &  (year == 1980 | year == 1990 | year == 2000 | year == 2010), fe robust cluster(pan_id)

eststo: xtivreg2 loggdp logpop fertility yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 &  (year == 1980 | year == 1990 | year == 2000 | year == 2010), fe robust cluster(pan_id)

esttab using IVGrowth.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Non-Human Capital Growth Outcomes: IV") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 


** Fertility Effects ** 

*eststo: xtreg fertility survival_rate loggdpcap logpop i.year  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1985 | year == 1995| year == 2005 |year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

ivreg fertility loggdpcap logpop yr23-yr58 pan_id1-pan_id217 (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1985 | year == 1995| year == 2005 |year == 1990 | year == 2000 | year == 2012), robust cluster(pan_id)

predict xb

eststo: quietly xtreg enrollment xb loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2010 | year == 1990 | year == 2000 | year == 2010), fe vce(bootstrap, reps(50) seed(1)) cluster(pan_id)
estadd local yrs  "Decades"

eststo: quietly xtreg enrollment xb loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2010), fe vce(bootstrap, reps(50) seed(1)) cluster(pan_id)
estadd local yrs  "5 Years"

esttab using IVGrowth.tex, replace fragment label booktabs title("Fertility") scalars("yrs Years")  se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 
