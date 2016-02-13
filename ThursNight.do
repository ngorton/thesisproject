* REGRESSIONS FOR JOHN ERIC MEETING -- ALL DIFFERENT IV'S *s


* OLS Estimates, different lags on mortality *
xtreg rateofoutofschoolMF l.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using ols.xls, label nocons keep(l.mortality loggdpcap logpop) replace ctitle("1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("OLS Estimates")

xtreg rateofoutofschoolMF l2.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l2.mortality loggdpcap logpop) append ctitle("2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF l5.mortality if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l5.mortality loggdpcap logpop) append ctitle("5-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, No) 

xtreg rateofoutofschoolMF l5.mortality loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , re robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l5.mortality loggdpcap logpop) append ctitle("5-year Lag") addtext(Country FE, No, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l5.mortality loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l5.mortality loggdpcap logpop) append ctitle("5-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, Yes) 

xtreg rateofoutofschoolMF l5.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l5.mortality loggdpcap logpop) append ctitle("5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l7.mortality if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l7.mortality loggdpcap logpop) append ctitle("7-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, No) 

xtreg rateofoutofschoolMF l7.mortality loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , re robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l7.mortality loggdpcap logpop) append ctitle("7-year Lag") addtext(Country FE, No, Year FE, No, Controls, Yes) 

xtreg rateofoutofschoolMF l7.mortality loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l7.mortality loggdpcap logpop) append ctitle("7-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, Yes) 

xtreg rateofoutofschoolMF l7.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.xls, label nocons keep(l7.mortality loggdpcap logpop) append ctitle("7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*** DIFFERENT INSTRUMENTS ***

* Coverage level X Herd Immunity Dummy*
*First Stage
xtreg mortality c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop)  append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l.unicefmcv1#i.l.not_mcv_covered i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop)  append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, No)

xtreg mortality c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop)  append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, Yes) 

xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop) replace ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Coverage level X herd immunity dummy")

xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop) append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, No) 

xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop)  append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, Yes)


*Reduced Form
xtreg rateofoutofschoolMF c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop) append ctitle("Reduced Form, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF c.l2.unicefmcv1#i.l2.not_mcv_covered i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop) append ctitle("Reduced Form, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, No)

xtreg rateofoutofschoolMF c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop) append ctitle("Reduced Form, 2-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, Yes)

*IV 
xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l2.unicefmcv1#i.l2.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric1.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l2.mortality  = c.l3.unicefmcv1#i.l3.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric1.xls, label nocons keep(l2.mortality loggdpcap logpop) append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)


* Interaction of differences in coverage and uncovered level*
* First Stage
xtreg mortality c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric2.xls, label nocons keep(c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop) replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X uncovered level")

xtreg mortality c.l6.diff_mcv1coverage#c.l6.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric2.xls, label nocons keep(c.l6.diff_mcv1coverage#c.l6.uncoveredmcv1 loggdpcap logpop) append ctitle("First Stage, 6-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric2.xls, label nocons keep(c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1 loggdpcap logpop) append ctitle("First Stage, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg mortality c.l10.diff_mcv1coverage#c.l10.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric2.xls, label nocons keep(c.l10.diff_mcv1coverage#c.l10.uncoveredmcv1 loggdpcap logpop) append ctitle("First Stage, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

*Reduced Form
xtreg rateofoutofschoolMF c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric2.xls, label nocons keep(c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop) append ctitle("Reduced Form, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric2.xls, label nocons keep(c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1 loggdpcap logpop) append ctitle("Reduced Form, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF c.l10.diff_mcv1coverage#c.l10.uncoveredmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric2.xls, label nocons keep(c.l10.diff_mcv1coverage#c.l10.uncoveredmcv1 loggdpcap logpop) append ctitle("Reduced Form, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

*IV
xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric2.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l7.diff_mcv1coverage#c.l5.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric2.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l10.diff_mcv1coverage#c.l5.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric2.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Interaction of differences in coverage and covered level*
*First Stage
xtreg mortality c.l5.diff_mcv1coverage#c.l5.unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric3.xls, label nocons keep(c.l5.diff_mcv1coverage#c.l5.unicefmcv1 loggdpcap logpop) replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X covered level")

xtreg mortality c.l7.diff_mcv1coverage#c.l5.unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric3.xls, label nocons keep(c.l7.diff_mcv1coverage#c.l7.unicefmcv1 loggdpcap logpop) append ctitle("First Stage, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l10.diff_mcv1coverage#c.l10.unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric3.xls, label nocons keep(c.l10.diff_mcv1coverage#c.l10.unicefmcv1 loggdpcap logpop) append ctitle("First Stage, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l5.diff_mcv1coverage#c.l5.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric3.xls, label nocons keep(c.l5.diff_mcv1coverage#c.l5.unicefmcv1 loggdpcap logpop) append ctitle("Reduced Firm, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF c.l7.diff_mcv1coverage#c.l7.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric3.xls, label nocons keep(c.l7.diff_mcv1coverage#c.l7.unicefmcv1 loggdpcap logpop) append ctitle("Reduced Firm, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF c.l10.diff_mcv1coverage#c.l10.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric3.xls, label nocons keep(c.l10.diff_mcv1coverage#c.l10.unicefmcv1 loggdpcap logpop) append ctitle("Reduced Firm, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

*IV
xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l5.diff_mcv1coverage#c.l5.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric3.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l7.diff_mcv1coverage#c.l5.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric3.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l10.diff_mcv1coverage#c.l5.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric3.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Interaction of Herd immunity, uncovered level, and differences*
*First Stage
xtreg mortality i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric4.xls, label nocons keep(i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop) replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X uncovered level X Herd Dummy")

xtreg mortality i.l7.not_mcv_covered#c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric4.xls, label nocons keep(i.l7.not_mcv_covered#c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1 loggdpcap logpop) append ctitle("First Stage, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality i.l10.not_mcv_covered#c.l10.diff_mcv1coverage#c.l10.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric4.xls, label nocons keep(i.l10.not_mcv_covered#c.l10.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop) append ctitle("First Stage, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric4.xls, label nocons keep(i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1  loggdpcap logpop) append ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF i.l7.not_mcv_covered#c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric4.xls, label nocons keep(i.l7.not_mcv_covered#c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1  loggdpcap logpop) append ctitle("First Stage, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF i.l10.not_mcv_covered#c.l10.diff_mcv1coverage#c.l10.uncoveredmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric4.xls, label nocons keep(i.l10.not_mcv_covered#c.l10.diff_mcv1coverage#c.l10.uncoveredmcv1  loggdpcap logpop) append ctitle("First Stage, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV
xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric4.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = i.l7.not_mcv_covered#c.l7.diff_mcv1coverage#c.l7.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric4.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = i.l10.not_mcv_covered#c.l10.diff_mcv1coverage#c.l10.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric4.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Interaction of Herd immunity and differences*
*First Stage
xtreg mortality i.l5.not_mcv_covered#c.l5.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric5.xls, label nocons keep(i.l5.not_mcv_covered#c.l5.diff_mcv1coverage loggdpcap logpop) replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X Herd Dummy")

*Reduced Form
xtreg rateofoutofschoolMF i.l5.not_mcv_covered#c.l5.diff_mcv1coverage loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric5.xls, label nocons keep(i.l5.not_mcv_covered#c.l5.diff_mcv1coverage loggdpcap logpop) append ctitle("Reduced Form, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

*IV
xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = i.l5.not_mcv_covered#c.l5.diff_mcv1coverage) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric5.xls, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Non linearity * 

* Splines * 
mkspline mcvcoverage1 30 mcvcoverage2 60 mcvcoverage3 90 mcvcoverage4 = unicefmcv1
*First Stage
xtreg f.mortality mcvcoverage1-mcvcoverage4 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline1.xls, label nocons keep(mcvcoverage1 mcvcoverage2 mcvcoverage3 mcvcoverage4 loggdpcap logpop) replace ctitle("First Stage, 1 Year Forward, 4-Spline") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("4-Bucket Splines of Coverage (Testing Non-Linearity")

xtreg f2.mortality mcvcoverage1-mcvcoverage4 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline1.xls, label nocons keep(mcvcoverage1 mcvcoverage2 mcvcoverage3 mcvcoverage4 loggdpcap logpop) append ctitle("First Stage, 2 Year Forward, 4-Spline") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

*Reduced Form
xtreg f5.rateofoutofschoolMF mcvcoverage1-mcvcoverage4 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline1.xls, label nocons keep(mcvcoverage1 mcvcoverage2 mcvcoverage3 mcvcoverage4 loggdpcap logpop) append ctitle("Reduced Form, 5 Year Forward, 4-Spline") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg f10.rateofoutofschoolMF mcvcoverage1-mcvcoverage4 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline1.xls, label nocons keep(mcvcoverage1 mcvcoverage2 mcvcoverage3 mcvcoverage4 loggdpcap logpop) append ctitle("Reduced Form, 10 Year Forward, 4-Spline") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

*IV 
xtivreg f5.rateofoutofschoolMF i.year loggdpcap logpop (f.mortality  = mcvcoverage1-mcvcoverage4) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using spline1.xls, label nocons keep(f.mortality loggdpcap logpop) append ctitle("IV, 5 Year Forward, 4-Spline") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg f10.rateofoutofschoolMF i.year loggdpcap logpop (f.mortality  = mcvcoverage1-mcvcoverage4) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using spline1.xls, label nocons keep(f.mortality loggdpcap logpop) append ctitle("IV, 10 Year Forward, 4-Spline") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Spline Levels interacted with changes in coverage * 

*Fist Stage 
xtreg f5.mortality c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline2.xls, label nocons keep(c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage loggdpcap logpop) replace ctitle("First Stage, 5 Year Forward, 4-Spline X Diff Coverage") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("4-Bucket Splines of Coverage (Testing Non-Linearity")

xtreg f10.mortality c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline2.xls, label nocons keep(c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage loggdpcap logpop) append ctitle("First Stage, 10 Year Forward, 4-Spline X Diff Coverage") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg f12.mortality c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline2.xls, label nocons keep(c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage loggdpcap logpop) append ctitle("First Stage, 12 Year Forward, 4-Spline X Diff Coverage") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg f5.rateofoutofschoolMF c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline2.xls, label nocons keep(c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage loggdpcap logpop) append ctitle("Reduced Form, 5 Year Forward, 4-Spline X Diff Coverage") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg f10.rateofoutofschoolMF c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline2.xls, label nocons keep(c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage loggdpcap logpop) append ctitle("Reduced Form, 10 Year Forward, 4-Spline X Diff Coverage") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg f12.rateofoutofschoolMF c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using spline2.xls, label nocons keep(c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage loggdpcap logpop) append ctitle("Reduced Form, 12 Year Forward, 4-Spline X Diff Coverage") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg f5.rateofoutofschoolMF i.year loggdpcap logpop (f.mortality  = c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage ) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using spline2.xls, label nocons keep(f.mortality  c.mcvcoverage4#c.diff_mcv1coverage loggdpcap logpop) append ctitle("IV, 5 Year Forward, 4-Spline X Diff Coverage") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("4-Bucket Splines of Coverage (Testing Non-Linearity")

xtivreg f10.rateofoutofschoolMF i.year loggdpcap logpop (f.mortality  = c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage ) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using spline2.xls, label nocons keep(f.mortality loggdpcap logpop) append ctitle("IV, 10 Year Forward, 4-Spline X Diff Coverage") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("4-Bucket Splines of Coverage (Testing Non-Linearity")


* Testing excludability * 
xtreg vaxspending loggdpcap logpop if gavi_status_00 == 1, fe robust cluster(pan_id)
 xtreg unicefmcv1 vaxspending loggdp logpop if gavi_status_00 == 1, fe robust cluster(pan_id)
  xtreg unicefdtp1 vaxspending loggdp logpop if gavi_status_00 == 1, fe robust cluster(pan_id)
