keep if (year == 1980 | year == 1990 | year == 2000 | year == 2010 )


eststo clear

** OLS **
eststo: xtgls fertility survival_rate loggdpcap logpop liberties i.year  i.pan_id if  gavi_status_00 == 1  & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logpop survival_rate loggdpcap fertility liberties i.year  i.pan_id if  gavi_status_00 == 1  &(year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdpcap survival_rate logpop fertility liberties i.year  i.pan_id if  gavi_status_00 == 1  & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdp survival_rate logpop fertility liberties i.year  i.pan_id if  gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

esttab using OLSGrowth2.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Non-Human Capital Growth Outcomes: OLS") se r2 noconstant compress nobaselevels  star(+ 0.10 * 0.05 ** 0.01 *** 0.001)

** IV **
eststo clear
eststo: xtivreg2 fertility loggdpcap logpop liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if  gavi_status_00 == 1  , fe robust cluster(pan_id)

eststo: xtivreg2 logpop loggdpcap fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if   gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if   gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: xtivreg2 loggdp logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if   gavi_status_00 == 1 , fe robust cluster(pan_id)

esttab using IVGrowth2.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Non-Human Capital Growth Outcomes: IV") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 

XXX

eststo clear

** OLS **
eststo: xtgls fertility survival_rate loggdpcap logpop liberties i.year  i.pan_id if  gavi_status_00 == 1 & in_sample == 1  & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logpop survival_rate loggdpcap fertility liberties i.year  i.pan_id if  gavi_status_00 == 1 & in_sample == 1  &(year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdpcap survival_rate logpop fertility liberties i.year  i.pan_id if  gavi_status_00 == 1 & in_sample == 1  & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdp survival_rate logpop fertility liberties i.year  i.pan_id if  gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

esttab using OLSGrowth2.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Non-Human Capital Growth Outcomes: OLS") se r2 noconstant compress nobaselevels  star(+ 0.10 * 0.05 ** 0.01 *** 0.001)

** IV **
eststo clear
eststo: xtivreg2 fertility loggdpcap logpop liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1  &  gavi_status_00 == 1  , fe robust cluster(pan_id)

eststo: xtivreg2 logpop loggdpcap fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if  in_sample == 1  & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if in_sample == 1  &  gavi_status_00 == 1 , fe robust cluster(pan_id)

esttab using IVGrowth2.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Non-Human Capital Growth Outcomes: IV") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 

XXX
eststo clear

** OLS **
eststo: xtgls fertility survival_rate loggdpcap logpop liberties i.year  i.pan_id if  gavi_status_00 == 1 & !missing(weighted_vaccine_avg_eff) & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logpop survival_rate loggdpcap fertility liberties i.year  i.pan_id if  gavi_status_00 == 1 &!missing(weighted_vaccine_avg_eff) &(year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdpcap survival_rate logpop fertility liberties i.year  i.pan_id if  gavi_status_00 == 1 & !missing(weighted_vaccine_avg_eff) &(year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls fertility loglifeexpect loggdpcap logpop liberties i.year  i.pan_id if  gavi_status_00 == 1 & !missing(weighted_vaccine_avg_eff) &(year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls logpop loglifeexpect loggdpcap fertility liberties i.year  i.pan_id if  gavi_status_00 == 1 & !missing(weighted_vaccine_avg_eff) & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

eststo: xtgls loggdpcap loglifeexpect logpop fertility liberties i.year  i.pan_id if  gavi_status_00 == 1 & !missing(weighted_vaccine_avg_eff) & (year == 1980 | year == 1990 | year == 2000 | year == 2010), corr(ar1) panels(heteroskedastic)  force

esttab using OLSGrowth.tex, replace indicate("Year FE = *.year" "Country FE = *.pan_id") label booktabs title("Non-Human Capital Growth Outcomes: OLS") se r2 noconstant compress nobaselevels  star(+ 0.10 * 0.05 ** 0.01 *** 0.001)

** IV **
eststo clear
keep if (year == 1980 | year == 1990 | year == 2000 | year == 2010 )
eststo: xtivreg2 fertility loggdpcap logpop liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if  gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: xtivreg2 logpop loggdpcap fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if  gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = weighted_vaccine_avg_eff) if  gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: xtivreg2 fertility loggdpcap logpop liberties yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if  gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 logpop loggdpcap fertility liberties yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if  gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: xtivreg2 loggdpcap logpop fertility liberties yr23-yr58  (loglifeexpect= weighted_vaccine_avg_eff) if  gavi_status_00 == 1, fe robust cluster(pan_id)

esttab using IVGrowth2.tex, replace indicate("Year FE = yr23 yr24 yr25 yr26 yr27 yr28 yr29 yr30 yr31 yr32 yr33 yr34 yr35 yr36 yr37 yr38 yr39 yr40 yr41 yr42 yr43 yr44 yr45 yr46 yr47 yr48 yr49 yr50 yr51 yr52 yr53 yr54 yr55 yr56 yr57 yr58") label booktabs title("Non-Human Capital Growth Outcomes: IV") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 
