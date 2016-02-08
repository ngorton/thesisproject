gen not_dtp_covered = 0
replace not_dtp_covered = 0 if unicefdtp1 < 83


xtreg rateofoutofschoolMF l.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables2.xls, label nocons keep(l.mortality) noobs replace ctitle("OLS, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) tex(pretty)

xtreg rateofoutofschoolMF l2.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables2.xls, label nocons keep(l2.mortality) noobs append ctitle("OLS, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) tex(pretty)

xtreg rateofoutofschoolMF l.unicefdtp1 c.l.diff_dtp1coverage#i.l.not_dtp_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables2.xls, label nocons keep(l.unicefdtp1 c.l.diff_dtp1coverage#i.l.not_dtp_covered) noobs append ctitle("Reduced-Form, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) tex(pretty)

xtreg rateofoutofschoolMF l2.unicefdtp1 c.l2.diff_dtp1coverage#i.l2.not_dtp_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using tables2.xls, label nocons keep(l2.unicefdtp1 c.l2.diff_dtp1coverage#i.l2.not_dtp_covered) noobs append ctitle("Reduced-Form, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) tex(pretty)

xtreg mortality l.unicefdtp1 c.l.diff_dtp1coverage#i.l.not_dtp_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables2.xls, label nocons keep(l.unicefdtp1 c.l.diff_dtp1coverage#i.l.not_dtp_covered) noobs append ctitle("First Stage, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) tex(pretty)

xtreg mortality l2.unicefdtp1 c.l2.diff_dtp1coverage#i.l2.not_dtp_covered loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using tables2.xls, label nocons keep(l2.unicefdtp1 c.l2.diff_dtp1coverage#i.l2.not_dtp_covered) noobs append ctitle("First Stage, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) tex(pretty)

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l2.unicefdtp1 c.l2.diff_dtp1coverage#i.l2.not_dtp_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id) 
outreg2 using tables2.xls, label nocons keep(l.mortality) noobs append ctitle("IV, 1-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) tex(pretty)

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l3.unicefdtp1 c.l3.diff_dtp1coverage#i.l3.not_dtp_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
outreg2 using tables2.xls, label nocons keep(l.mortality) noobs append ctitle("IV, 2-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes) tex(pretty)
