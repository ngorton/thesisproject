xtreg rateofoutofschoolMF l.mortality i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using ols.tex, label nocons keep(l.mortality loggni logpop) replace ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("OLS Estimates")

xtreg rateofoutofschoolMF l2.mortality i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l2.mortality loggni logpop) append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF l5.mortality i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l5.mortality loggni logpop) append ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l7.mortality i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l7.mortality loggni logpop) append ctitle("First Stage, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 
