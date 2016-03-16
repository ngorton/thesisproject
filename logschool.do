
// Only keep certain years

*gen young_mort = mortality-infantmort
*gen infant_survive = (1 - infantmort/1000)*100
*gen young_survive = (1 - young_mort/1000)*100
gen adult_survive = (1 - adultmort/1000)*100
gen logschool = log(interpolated_school)

label variable logschool "Log Unenrolled Rate"

// OLS

eststo clear

eststo: xtgls logschool survival_rate loggdpcap  i.pan_id  i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool survival_rate loggdpcap logpop i.pan_id  i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool survival_rate loggdpcap logpop fertility i.pan_id i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool loglifeexpect loggdpcap  i.pan_id  i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool loglifeexpect loggdpcap logpop i.pan_id  i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool loglifeexpect loggdpcap logpop fertility i.pan_id i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsOLS.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Ordinary Least Squares Estimates") se r2 noconstant compress nobaselevels 

// First Stage and Direct Effects 
eststo clear

eststo: xtgls survival_rate weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loglifeexpect weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool weighted_vaccine_avg_eff i.year loggdpcap logpop fertility  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsDE.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Primary Specification: First Stage and Direct Effects") se r2 noconstant compress nobaselevels 

// Instrumental Variables 
tsset 

eststo clear

eststo: xtivreg2 logschool loggdpcap  yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 logschool loggdpcap logpop yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 logschool loggdpcap logpop fertility yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 logschool loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 logschool loggdpcap  yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 logschool loggdpcap logpop yr23-yr58 (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1,fe  robust cluster(pan_id) 

eststo: xtivreg2 logschool loggdpcap logpop fertility yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 logschool loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

esttab using glsIV.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Primary Specification: Second Stage") se r2 noconstant compress nobaselevels 

// Splines 

eststo clear 

mkspline vax1 20 vax2 45 vax3 70 vax4 = weighted_vaccine_avg_efficacy

eststo: xtgls survival_rate vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loglifeexpect vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsspliesFS.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Splines: First Stage Estimates") se r2 noconstant compress nobaselevels 


// Splines IV Stage 

eststo clear

eststo: xtivreg2 logschool loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = vax2) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 logschool loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = vax2 vax3) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

esttab using glssplinesIV.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Splines: Second Stage Estimates") se r2 noconstant compress nobaselevels 

// Direct Effect
eststo clear

eststo: xtgls logschool weighted_vaccine_avg_eff i.year loggdpcap  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool weighted_vaccine_avg_eff i.year loggdpcap logpop  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool weighted_vaccine_avg_eff i.year loggdpcap logpop fertility  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsspliesDE.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Splines: First Stage Estimates") se r2 noconstant compress nobaselevels 

// Other Growth Outcomes
eststo clear

eststo: xtgls fertility survival_rate loggdpcap logpop i.year  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls logpop  survival_rate loggdpcap fertility  i.pan_id i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdpcap survival_rate logpop fertility  i.pan_id i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdp  survival_rate logpop fertility  i.pan_id i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls fertility loglifeexpect loggdpcap logpop i.year  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logpop  loglifeexpect loggdpcap fertility  i.pan_id i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdpcap loglifeexpect logpop fertility  i.pan_id i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdp  loglifeexpect logpop fertility  i.pan_id i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using OLSGrowth.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Non-Human Capital Growth Outcomes: OLS") se r2 noconstant compress nobaselevels  star(+ 0.10 * 0.05 ** 0.01 *** 0.001)


eststo clear

eststo: xtivreg2 fertility loggdpcap logpop yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 logpop loggdpcap fertility yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 loggdpcap logpop fertility yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 loggdp logpop fertility yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 fertility loggdpcap logpop yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 logpop loggdpcap fertility yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 loggdpcap logpop fertility yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 loggdp logpop fertility yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

esttab using IVGrowth.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Non-Human Capital Growth Outcomes: IV") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 

//Formatting Abbreviated Results


eststo clear

eststo: xtgls logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsOLSsmall.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Ordinary Least Squares Estimates") se r2 noconstant compress nobaselevels 

eststo: xtgls survival_rate weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loglifeexpect weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsFSsmall.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Ordinary Least Squares Estimates") se r2 noconstant compress nobaselevels 

// Differences over many years 

gen tenyearlag =log(f10.interpolated_school - interpolated_school)
gen fiveyearlag =log(f5.interpolated_school - interpolated_school)
gen oneyearlag =log(f.interpolated_school - interpolated_school)

gen tenyearlag_nonlog =f10.interpolated_school - interpolated_school

gen fiveyearlag_nonlog =f5.interpolated_school - interpolated_school
gen oneyearlag_nonlog =f.interpolated_school - interpolated_school


gen treated = (weighted_vaccine_avg > 90)
gen treated2 = (weighted_vaccine_avg > 70)
gen treated3 = (unicefdtp1 > 60)
gen treated5 = (weighted_vaccine_avg > 10)


// Lags and leads 
eststo: quietly xtgls logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f2.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f3.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f4.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f5.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f6.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f7.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f8.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f9.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f10.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f11.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f12.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f13.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f14.logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using coefficients.xls, replacelabel booktabs keep(survival_rate) se r2 noconstant compress nobaselevels 

eststo: quietly xtgls logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f2.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f3.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f4.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f5.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f6.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f7.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f8.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f9.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f10.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f11.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f12.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f13.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls f14.logschool loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using coefficientsLE.xls, replace label booktabs keep(survival_rate) se r2 noconstant compress nobaselevels 

// Testing for Autocorrelation
eststo: quietly xtgls logschool survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: quietly xtgls l.logschool l.survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

// Lags and Leads 
eststo clear

eststo: quietly xtivreg2 f2.logschool loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f5.logschool loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f10.logschool loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f2.logschool loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f5.logschool loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f10.logschool loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

esttab using Leads.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Non-Human Capital Growth Outcomes: IV") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 
