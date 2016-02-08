
*Measles*
*UNESCO Schooling Data*

clear

do CreateVariables

 eststo clear

gen not_mcv_covered = 0 
replace not_mcv_covered = 1 if unicefmcv1 < 90

eststo: quietly xtreg rateofoutofschoolMF l.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l2.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l.unicefmcv1 c.l.diff_mcv1coverage#i.l.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly xtreg rateofoutofschoolMF l2.unicefmcv1 c.l2.diff_mcv1coverage#i.l2.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly xtreg mortality l.unicefmcv1 c.l.diff_mcv1coverage#i.l.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtreg mortality l2.unicefmcv1 c.l2.diff_mcv1coverage#i.l2.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

eststo: quietly xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l2.unicefmcv1 c.l2.diff_mcv1coverage#i.l2.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)

eststo: quietly xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l3.unicefmcv1 c.l3.diff_mcv1coverage#i.l3.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 

estadd local hascontrols "Yes"
estadd local CountryFE "Yes"

esttab using firststage5.tex, replace se drop(loggni logpop) indicate(rep dummies = *.year*) scalars("hascontrols has controls" "CountryFE has Country FE") rename(l2.mortality l.mortality) compress mtitles("OLS, one year lag" "OLS, two year lag" "Reduced-Form, one year lag" "Reduced-Form, two year lag" "First Stage, one-year lag" "First Stage, two-year lag" "IV, one-year lag" "IV, two-year lag")

