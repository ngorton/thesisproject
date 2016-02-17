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

* Presence of campaign * 
* First Stage
xtreg mortality i.l10.presence_mcv1_t0 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using presence.tex, label nocons keep(i.l10.presence_mcv1_t0 loggdpcap logpop) replace ctitle("First Stage, 10-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Non-Zero Coverage")

xtreg mortality i.l15.presence_mcv1_t0 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using presence.tex, label nocons keep(i.l15.presence_mcv1_t0 loggdpcap logpop) append ctitle("First Stage, 15-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Reduced Form

xtreg rateofoutofschoolMF i.l10.presence_mcv1_t0 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using presence.tex, label nocons keep(i.l15.presence_mcv1_t0 loggdpcap logpop) append ctitle("Reduced Form, 10-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF i.l15.presence_mcv1_t0 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using presence.tex, label nocons keep(i.l15.presence_mcv1_t0 loggdpcap logpop) append ctitle("Reduced Form, 15-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* IV
xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = i.l10.presence_mcv1_t0) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using presence.tex, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 10-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = i.l15.presence_mcv1_t0) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using presence.tex, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 15-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)


* Testing excludability * 
xtreg vaxspending loggdpcap logpop if gavi_status_00 == 1, fe robust cluster(pan_id)
xtreg unicefmcv1 vaxspending loggdp logpop if gavi_status_00 == 1, fe robust cluster(pan_id)
xtreg unicefdtp1 vaxspending loggdp logpop if gavi_status_00 == 1, fe robust cluster(pan_id)


