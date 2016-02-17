xtreg mortality c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using shimer.tex, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered )  replace ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Coverage level X Herd Immunity Indicator")

xtreg mortality c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using shimer.tex, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered) append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF c.l.unicefmcv1#i.l.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using shimer.tex, label nocons keep(c.l.unicefmcv1#i.l.not_mcv_covered )  append ctitle("Reduced Form, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF c.l2.unicefmcv1#i.l2.not_mcv_covered loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using shimer.tex, label nocons keep(c.l2.unicefmcv1#i.l2.not_mcv_covered ) append ctitle("Reduced Form, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l2.unicefmcv1#i.l2.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using shimer.tex, label nocons keep(l.mortality) append ctitle("IV, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l3.unicefmcv1#i.l3.not_mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using shimer.tex, label nocons keep(l2.mortality) append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

**** Primary Specification

xtreg mortality c.l.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using shimer2.tex, label nocons keep(c.l.unicefmcv1 )  replace ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) title("Coverage level")

xtreg mortality c.l2.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using shimer2.tex, label nocons keep(c.l2.unicefmcv1 ) append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) 

xtreg rateofoutofschoolMF c.l.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using shimer2.tex, label nocons keep(c.l.unicefmcv1 )  append ctitle("Reduced Form, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF c.l2.unicefmcv1 loggdpcap logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using shimer2.tex, label nocons keep(c.l2.unicefmcv1 ) append ctitle("Reduced Form, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l.mortality  = c.l2.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using shimer2.tex, label nocons keep(l.mortality) append ctitle("IV, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggdpcap logpop (l2.mortality  = c.l3.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using shimer2.tex, label nocons keep(l2.mortality) append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)



