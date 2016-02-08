*** TESTING DIFFERENT IVS ***
*** 1 YEAR LAG ***

* OLS Estimates, different lags on mortality *
xtreg rateofoutofschoolMF l.mortality i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using ols.tex, label nocons keep(l.mortality loggni logpop) replace ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("OLS Estimates")

xtreg rateofoutofschoolMF l2.mortality i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l2.mortality loggni logpop) append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF l5.mortality i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l5.mortality loggni logpop) append ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF l7.mortality i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using  ols.tex, label nocons keep(l7.mortality loggni logpop) append ctitle("First Stage, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 


* Instrument 1 - Measles
*Interaction of differences in coverage and uncovered level*

*First Stage
xtreg mortality c.l.diff_mcv1coverage#c.l.uncoveredmcv1 loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l.diff_mcv1coverage#c.l.uncoveredmcv1) noobs replace ctitle("Inst. 1 FS, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l.diff_mcv1coverage#c.l.uncoveredmcv1 i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l.diff_mcv1coverage#c.l.uncoveredmcv1) noobs append ctitle("Inst. 1 RF, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l2.diff_mcv1coverage#c.l2.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("Inst. 1 IV, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

* Instrument 2 - Measles
*Interaction of differences in coverage and herd immune dummy*

*First Stage
xtreg mortality c.l.diff_mcv1coverage#i.l.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l.diff_mcv1coverage#i.l.not_mcv_covered) noobs append ctitle("Inst. 2 FS, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l.diff_mcv1coverage#i.l.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l.diff_mcv1coverage#i.l.not_mcv_covered) noobs append ctitle("Inst. 2 RF, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l2.diff_mcv1coverage#i.l2.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("Inst. 2 IV, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 


* Instrument 3 - Measles
* Interaction of differences in coverage, herd immune dummy, and uncovered level*

*First Stage
xtreg mortality c.l.uncoveredmcv1#c.l.diff_mcv1coverage#i.l.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l.uncoveredmcv1#c.l.diff_mcv1coverage#i.l.not_mcv_covered ) noobs append ctitle("Inst. 3 FS, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l.uncoveredmcv1#c.l.diff_mcv1coverage#i.l.not_mcv_covered  i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l.uncoveredmcv1#c.l.diff_mcv1coverage#i.l.not_mcv_covered ) noobs append ctitle("Inst. 3 RF, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l.uncoveredmcv1#c.l.diff_mcv1coverage#i.l.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("Inst. 3 IV, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*** SAME REGRESSIONS, NOW WITH A FIVE YEAR LAG ***

* Instrument 1 - Measles
*Interaction of differences in coverage and uncovered level*

*First Stage
xtreg mortality c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1) noobs append ctitle("Inst. 1 FS, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1 i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l5.diff_mcv1coverage#c.l5.uncoveredmcv1) noobs append ctitle("Inst. 1 RF, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l6.diff_mcv1coverage#c.l6.uncoveredmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("Inst. 1 IV, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

* Instrument 2 - Measles
*Interaction of differences in coverage and herd immune dummy*

*First Stage
xtreg mortality c.l5.diff_mcv1coverage#i.l5.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l5.diff_mcv1coverage#i.l5.not_mcv_covered) noobs append ctitle("Inst. 2 FS, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l5.diff_mcv1coverage#i.l5.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l5.diff_mcv1coverage#i.l5.not_mcv_covered) noobs append ctitle("Inst. 2 RF, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l6.diff_mcv1coverage#i.l6.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("Inst. 2 IV, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

* Instrument 4 - Measles
*Interaction of differences in coverage and herd immune dummy*

*First Stage
xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)outreg2 using tables.xls, label nocons keep(c.l5.diff_mcv1coverage#i.l5.not_mcv_covered) noobs append ctitle("Inst. 2 FS, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 
outreg2 using tables.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered) noobs append ctitle("Inst. 4 FS, 2-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l2.unicefmcv1#i.l2.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered) noobs append ctitle("Inst. 4 RF, 2-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l3.unicefmcv1#i.l3.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("Inst. 2 IV, 2-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 


* Instrument 3 - Measles
* Interaction of differences in coverage, herd immune dummy, and uncovered level*

*First Stage
xtreg mortality c.l5.uncoveredmcv1#c.l5.diff_mcv1coverage#i.l5.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l5.uncoveredmcv1#c.l5.diff_mcv1coverage#i.l5.not_mcv_covered ) noobs append ctitle("Inst. 3 FS, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l5.uncoveredmcv1#c.l5.diff_mcv1coverage#i.l5.not_mcv_covered  i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables.xls, label nocons keep(c.l5.uncoveredmcv1#c.l5.diff_mcv1coverage#i.l5.not_mcv_covered ) noobs append ctitle("Inst. 3 RF, 1-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l6.uncoveredmcv1#c.l6.diff_mcv1coverage#i.l5.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables.xls, label nocons keep(l.mortality) noobs append ctitle("Inst. 3 IV, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

