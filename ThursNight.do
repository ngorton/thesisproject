* REGRESSIONS FOR JOHN ERIC MEETING -- ALL DIFFERENT IV'S *s


* OLS Estimates, different lags on mortality *
xtreg rateofoutofschoolMF l.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using ols.tex, label nocons keep(l.mortality loggdpcap logpop) replace ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("OLS Estimates")

xtreg rateofoutofschoolMF l2.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l2.mortality loggdpcap logpop) append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF l5.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l5.mortality loggdpcap logpop) append ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l7.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l7.mortality loggdpcap logpop) append ctitle("First Stage, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*** DIFFERENT INSTRUMENTS ***

* Coverage level and herd immunity dummy*
*First Stage
xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop) replace ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Coverage level X herd immunity dummy")

xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop) append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, No) title("Coverage level X herd immunity dummy")

xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop)  append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, Yes) title("Coverage level X herd immunity dummy")

xtreg mortality c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop)  append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Coverage level X herd immunity dummy")

xtreg mortality c.l.unicefmcv1#i.l.not_mcv_covered i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop)  append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, No) title("Coverage level X herd immunity dummy")

xtreg mortality c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric1.xls, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop)  append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, No, Controls, Yes) title("Coverage level X herd immunity dummy")


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


* Interaction of differences in coverage and uncovered level*

xtreg mortality c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric2.tex, label nocons keep(c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop) replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X uncovered level")

xtreg rateofoutofschoolMF c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric2.tex, label nocons keep(c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop) append ctitle("Reduced Form, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric2.tex, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Interaction of differences in coverage and covered level*

xtreg mortality c.l5.diff_mcv1coverage#c.l5.unicefmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric3.tex, label nocons keep(c.l5.diff_mcv1coverage#c.l5.unicefmcv1 loggdpcap logpop) replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X covered level")

xtreg rateofoutofschoolMF c.l5.diff_mcv1coverage#c.l5.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric3.tex, label nocons keep(c.l5.diff_mcv1coverage#c.l5.unicefmcv1 loggdpcap logpop) append ctitle("Reduced Firm, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l5.diff_mcv1coverage#c.l5.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric3.tex, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Interaction of Herd immunity, uncovered level, and differences*
xtreg mortality i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric4.tex, label nocons keep(i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop) replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X uncovered level X Herd Dummy")

xtreg rateofoutofschoolMF i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric4.tex, label nocons keep(i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1  loggdpcap logpop) append ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X uncovered level")

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = i.l5.not_mcv_covered#c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric4.tex, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Interaction of Herd immunity and differences*
xtreg mortality i.l5.not_mcv_covered#c.l5.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using johneric5.tex, label nocons keep(i.l5.not_mcv_covered#c.l5.diff_mcv1coverage loggdpcap logpop) replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Dfferences in coverage X Herd Dummy")

xtreg rateofoutofschoolMF i.l5.not_mcv_covered#c.l5.diff_mcv1coverage loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using johneric5.tex, label nocons keep(i.l5.not_mcv_covered#c.l5.diff_mcv1coverage loggdpcap logpop) append ctitle("Reduced Form, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = i.l5.not_mcv_covered#c.l5.diff_mcv1coverage) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using johneric5.tex, label nocons keep(l.mortality loggdpcap logpop) append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

* Non linearity * 

* Splines * 
mkspline mcvcoverage1 30 mcvcoverage2 60 mcvcoverage3 90 mcvcoverage4 = unicefmcv1

xtreg f.mortality mcvcoverage1-mcvcoverage4 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

xtreg f2.mortality mcvcoverage1-mcvcoverage4 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

xtreg f3.rateofoutofschoolMF mcvcoverage1-mcvcoverage4 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

xtreg f.rateofoutofschoolMF mcvcoverage1-mcvcoverage4 i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

xtivreg f.rateofoutofschoolMF i.year loggdpcap logpop (f2.mortality  = mcvcoverage1-mcvcoverage4) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 

xtivreg f.rateofoutofschoolMF i.year loggdpcap logpop (f3.mortality  = mcvcoverage1-mcvcoverage4) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 

* Spline Levels interacted with changes in coverage * 

xtreg f10.mortality c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)s

xtreg f12.mortality c.mcvcoverage1#c.diff_mcv1coverage c.mcvcoverage2#c.diff_mcv1coverage c.mcvcoverage3#c.diff_mcv1coverage c.mcvcoverage4#c.diff_mcv1coverage i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
