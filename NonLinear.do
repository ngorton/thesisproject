
*Measles*
*UNESCO Schooling Data*

clear

do CreateVariables

gen not_mcv_covered = 0 
replace not_mcv_covered = 1 if unicefmcv1 < 90

xtreg rateofoutofschoolMF l.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(l.mortality) noobs replace ctitle("OLS, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l2.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(l2.mortality) noobs append ctitle("OLS, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l.unicefmcv1 c.l.diff_mcv1coverage#i.l.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(l.unicefmcv1 c.l.diff_mcv1coverage#i.l.not_mcv_covered) noobs append ctitle("Reduced-Form, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l2.unicefmcv1 c.l2.diff_mcv1coverage#i.l2.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(l2.unicefmcv1 c.l2.diff_mcv1coverage#i.l2.not_mcv_covered) noobs append ctitle("Reduced-Form, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality l.unicefmcv1 c.l.diff_mcv1coverage#i.l.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(l.unicefmcv1 c.l.diff_mcv1coverage#i.l.not_mcv_covered) noobs append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality l2.unicefmcv1 c.l2.diff_mcv1coverage#i.l2.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(l2.unicefmcv1 c.l2.diff_mcv1coverage#i.l2.not_mcv_covered) noobs append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l2.unicefmcv1 c.l2.diff_mcv1coverage#i.l2.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("IV, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l3.unicefmcv1#c.l3.diff_mcv1coverage#i.l3.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

X

xtreg mortality c.l5.diff_mcv1coverage#c.l5.unicefmcv1 i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
xtreg mortality c.l7.diff_mcv1coverage#c.l7.unicefmcv1 i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

xtreg mortality i.l7.not_mcv_covered#c.l7.diff_mcv1coverage#c.l7.unicefmcv1 i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
xtreg mortality i.l7.not_mcv_covered#c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1 i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)


xtreg rateofoutofschoolMF c.l.diff_mcv1coverage#i.l.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)


X


xtreg rateofoutofschoolMF l.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(l.mortality) noobs replace ctitle("OLS, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l2.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(l2.mortality) noobs append ctitle("OLS, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF c.l.unicefmcv1#i.l.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered) noobs append ctitle("Reduced-Form, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF c.l2.unicefmcv1#i.l2.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered) noobs append ctitle("Reduced-Form, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF c.l.diff_mcv1coverage#i.l.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(l.unicefmcv1 c.l.diff_mcv1coverage#i.l.not_mcv_covered) noobs append ctitle("Reduced-Form, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l.unicefmcv1#i.l.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered) noobs append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l2.diff_mcv1coverage#i.l2.not_mcv_covered  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered) noobs append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l.diff_mcv1coverage#i.l.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(c.l.diff_mcv1coverage#i.l.not_mcv_covered) noobs append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l2.diff_mcv1coverage#i.l2.not_mcv_covered  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables4.xls, label nocons keep(c.l2.diff_mcv1coverage#i.l2.not_mcv_covered) noobs append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l2.unicefmcv1#i.l2.not_mcv_covered ) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables4.xls, label nocons keep(l.mortality) noobs append ctitle("IV, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l3.unicefmcv1#i.l3.not_mcv_covered ) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
outreg2 using tables4.xls, label nocons keep(l.mortality) noobs append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l2.diff_mcv1coverage#i.l2.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables4.xls, label nocons keep(l.mortality) noobs append ctitle("IV, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l3.diff_mcv1coverage#i.l3.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
outreg2 using tables4.xls, label nocons keep(l.mortality) noobs append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

 
