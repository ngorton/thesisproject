
// Only keep certain years

*gen young_mort = mortality-infantmort
*gen infant_survive = (1 - infantmort/1000)*100
*gen young_survive = (1 - young_mort/1000)*100
gen adult_survive = (1 - adultmort/1000)*100
gen logschool = log(interpolated_school)

label variable logschool "Log Unenrolled Rate"
gen enrollment = 100 - interpolated_school
label variable enrollment "Primary Enrollment Rate"


gen survival_probability59 = 1 - prob_deathAGE5_9
gen survival_probability1014 = 1 - prob_deathAGE10_14
gen survival_probability1519 = 1 - prob_deathAGE15_19

gen cumulative_survival = ((survival_probability59 * survival_probability1014) * survival_probability1519)*100

label variable cumulative_survival "Probability of Survival from Age 5 to 20"

// OLS

eststo clear

eststo: xtgls enrollment survival_rate loggdpcap  i.pan_id  i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls enrollment survival_rate loggdpcap logpop i.pan_id  i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls enrollment survival_rate loggdpcap logpop fertility i.pan_id i.year if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls enrollment survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsOLS.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Ordinary Least Squares Estimates, 6-Year Lead") se r2 noconstant compress nobaselevels 

eststo: xtgls f5.enrollment survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls f6.enrollment survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls f7.enrollment survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls f8.enrollment survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls f10.enrollment survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force


eststo: xtgls f5.enrollment loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls f6.enrollment  loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls f7.enrollment  loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls f8.enrollment  loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
eststo: xtgls f10.enrollment  loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force


esttab using glsOLSLags.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Ordinary Least Squares Estimates, 6-Year Lead") se r2 noconstant compress nobaselevels 


// First Stage and Reduced Form
eststo clear

eststo: xtgls survival_rate weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loglifeexpect weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo clear

eststo: xtgls f5.enrollment weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f6.enrollment weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f7.enrollment weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f8.enrollment weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f9.enrollment weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f10.enrollment weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsDE.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") fragment label booktabs title("Primary Specification: First Stage and Direct Effects") se r2 noconstant compress nobaselevels 

// Instrumental Variables 
tsset 

eststo clear

eststo: xtivreg2 f7.enrollment loggdpcap  yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 f7.enrollment loggdpcap logpop yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 f7.enrollment loggdpcap logpop liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 f7.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 f7.enrollment loggdpcap  yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 f7.enrollment loggdpcap logpop yr23-yr58 (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1,fe  robust cluster(pan_id) 

eststo: xtivreg2 f7.enrollment loggdpcap logpop fertility yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 f7.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

esttab using glsIV.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Primary Specification: Second Stage") se r2 noconstant compress nobaselevels 

// Additional Lags
eststo: xtivreg2 f5.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 
eststo: xtivreg2 f6.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 
eststo: xtivreg2 f7.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 
eststo: xtivreg2 f8.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 
eststo: xtivreg2 f10.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: xtivreg2 f5.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
eststo: xtivreg2 f6.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
eststo: xtivreg2 f7.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
eststo: xtivreg2 f8.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
eststo: xtivreg2 f10.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

esttab using glsIVMoreLags.tex, replace fragment indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Primary Specification: Second Stage, Additional Lags") se r2 noconstant compress nobaselevels 


// Splines 

eststo clear 

mkspline vax1 20 vax2 45 vax3 70 vax4 = weighted_vaccine_avg_efficacy

eststo: xtgls survival_rate vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loglifeexpect vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

esttab using glsspliesFS.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Splines: First Stage Estimates") se r2 noconstant compress nobaselevels 


// Splines IV Stage 

eststo clear

eststo: xtivreg2 f5.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
eststo: xtivreg2 f5.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

esttab using IVSplinesBasic.tex, replace fragment indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Splines: Second Stage Estimates") se r2 noconstant compress nobaselevels 



eststo clear

eststo: xtivreg2 f6.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = vax2) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 f7.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 f8.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 f10.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 f6.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 f7.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 f8.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 f10.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = vax1-vax4) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

esttab using glssplinesIV.tex, replace fragment indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Splines: Second Stage Estimates") se r2 noconstant compress nobaselevels 

// Direct Effect
eststo clear

eststo: xtgls f5.interpolated_school vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f6.enrollment vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f7.enrollment vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f8.enrollment vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls f10.enrollment vax1-vax4 i.year loggdpcap logpop fertility liberties i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

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

eststo: xtgls enrollment survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: xtgls enrollment loglifeexpect loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

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

// Treatment Thresholds

gen treated = (weighted_vaccine_avg > 90)
gen treated2 = (weighted_vaccine_avg > 70)
gen treated3 = (unicefdtp1 > 60)
gen treated5 = (weighted_vaccine_avg > 10)

// Testing for Autocorrelation - running lags and correlating error terms
eststo: quietly xtgls enrollment survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

eststo: quietly xtgls l.enrollment l.survival_rate loggdpcap logpop fertility liberties i.pan_id  i.year  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

// Lags and Leads - IV Stage
eststo clear

eststo: quietly xtivreg2 f2.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f5.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f10.enrollment loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f2.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f5.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

eststo: quietly xtivreg2 f10.enrollment loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

esttab using Leads.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Non-Human Capital Growth Outcomes: IV") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 


// Over 5 Mortality 

eststo clear

** First Stage ** 
eststo: xtgls cumulative_survival weighted_vaccine_avg_eff i.year loggdpcap logpop fertility liberties  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

** Reduced Form ** 
eststo: xtgls enrollment cumulative_survival i.year loggdpcap logpop fertility liberties  i.pan_id if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force

** IV **
eststo: quietly xtivreg2 f5.enrollment loggdpcap logpop fertility liberties yr23-yr58  (cumulative_survival = weighted_vaccine_avg_eff) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id) 

esttab using Older.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Non-Human Capital Growth Outcomes: IV") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 

// Summary Statistics 

estpost tabstat interpolated_school survival_rate young_survive vaxspending unicefmcv1 unicefmcv2 unicefdtp1 unicefdtp3 unicefpol3 lifeexpect pop gdpcap, by(gavi_status_00) statistics(mean sd max min) columns(statistics) listwise not 
estpost tabstat prob_deathAGE100PLUS prob_deathAGE10_14 prob_deathAGE15_19 prob_deathAGE1_4 prob_deathAGE20_24 prob_deathAGE25_29 prob_deathAGE30_34 prob_deathAGE35_39 prob_deathAGE40_44 prob_deathAGE45_49 prob_deathAGE50_54 prob_deathAGE55_59 prob_deathAGE5_9 prob_deathAGE60_64 prob_deathAGE65_69 prob_deathAGE70_74 prob_deathAGE75_79 prob_deathAGE80_84 prob_deathAGE85_89 prob_deathAGE90_94 prob_deathAGE95_99 prob_deathAGELT1, statistics(mean sd max min) columns(statistics) listwise not 
