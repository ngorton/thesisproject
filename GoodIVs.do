* Instrument 4 - Measles
*Interaction of coverage level and herd immune dummy*

*First Stage
xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables5.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered) noobs replace ctitle("Coverage Level X Herd Dummy, FS, 2-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l2.unicefmcv1#i.l2.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables5.xls, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered) noobs append title("Coverage Level X Herd Dummy, RF, 2-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l3.unicefmcv1#i.l3.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables5.xls, label nocons keep(l.mortality) noobs append ctitle("Coverage Level X Herd Dummy,IV, 2-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

* Interaction of differences in coverage and uncovered level*

*First Stage
xtreg mortality c.l6.diff_mcv1coverage#i.l5.not_mcv_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables5.xls, label nocons keep(c.l5.diff_mcv1coverage#i.l5.not_mcv_covered) noobs append ctitle("Diff Coverage X Uncovered Level, FS, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*Reduced Form
xtreg rateofoutofschoolMF c.l5.diff_mcv1coverage#i.l5.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables5.xls, label nocons keep(c.l5.diff_mcv1coverage#i.l5.not_mcv_covered) noobs append ctitle("Diff Coverage X Uncovered Level, RF, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

*IV 
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l6.diff_mcv1coverage#i.l6.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables5.xls, label nocons keep(l.mortality) noobs append ctitle("Diff Coverage X Uncovered Level, IV, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 


* Interaction of differences in coverage and covered level*

xtreg mortality c.l7.diff_mcv1coverage#c.l7.unicefmcv1#i.l7.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables5.xls, label nocons keep(c.l7.diff_mcv1coverage#c.l7.unicefmcv1#i.l7.not_mcv_covered) noobs append ctitle("Diff Coverage X covered X Herd dummy, FS, 7-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l6.diff_mcv1coverage#c.l6.unicefmcv1#i.l6.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables5.xls, label nocons keep(c.l6.diff_mcv1coverage#c.l6.unicefmcv1#i.l6.not_mcv_covered) noobs append ctitle("Diff Coverage X covered X Herd dummy, FS, 6-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg mortality c.l5.diff_mcv1coverage#c.l5.unicefmcv1#i.l5.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables5.xls, label nocons keep(c.l5.diff_mcv1coverage#c.l5.unicefmcv1#i.l5.not_mcv_covered) noobs append ctitle("Diff Coverage X covered X Herd dummy, FS, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF c.l5.diff_mcv1coverage#c.l5.unicefmcv1#i.l5.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables5.xls, label nocons keep(c.l5.diff_mcv1coverage#c.l5.unicefmcv1#i.l5.not_mcv_covered) noobs append ctitle("Diff Coverage X covered X Herd dummy, RF, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = c.l5.diff_mcv1coverage#c.l5.unicefmcv1#i.l5.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables5.xls, label nocons keep(l.mortality) noobs append ctitle("Diff Coverage X covered X Herd dummy,IV, 5-yr Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 
