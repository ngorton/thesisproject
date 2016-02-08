
xtreg estimated_measles_deaths l.unicefmcv1 gni youngpop, fe robust cluster(pan_id)
xtreg estimated_measles_deaths l.unicefmcv1 youngpop, fe robust cluster(pan_id)
xtreg estimated_measles_deaths l.unicefmcv1, fe robust cluster(pan_id)

<<<<<<< HEAD

xtreg estimated_dtp_deaths l.unicefdtp1 gni youngpop, fe robust cluster(pan_id)
xtreg estimated_dtp_deaths l.unicefdtp1 youngpop, fe robust cluster(pan_id)
xtreg estimated_dtp_deaths l.unicefdtp1, fe robust cluster(pan_id)
=======
xtreg rateofoutofschoolMF l5.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using firststage2.tex, label nocons keep(l5.mortality) noobs replace ctitle("OLS, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF l7.mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using firststage2.tex, label nocons keep(l10.mortality) noobs append ctitle("OLS, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg mortality l5.diff_mcv1coverage loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using firststage2.tex, label nocons keep(l5.diff_mcv1coverage) noobs append ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg diff_schooling l2.diff_mcv1coverage i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
xtreg diff_schooling l5.diff_mortality  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
* also, l7* 

xtreg mortality l7.diff_mcv1coverage loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using firststage2.tex, label nocons keep(l10.diff_mcv1coverage) noobs append ctitle("First Stage, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF l5.diff_mcv1coverage i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using firststage2.tex, label nocons keep(l5.diff_mcv1coverage) noobs append ctitle("Reduced Form, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF l10.diff_mcv1coverage i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using firststage2.tex, label nocons keep(l10.diff_mcv1coverage) noobs append ctitle("Reduced Form, 7-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l.unicefmcv1 c.l.diff_mcv1coverage#i.l.mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
outreg2 using firststage2.tex, label nocons keep(l.mortality) noobs append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggni logpop (l5.mortality = l5.diff_mcv1coverage) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
outreg2 using firststage2.tex, label nocons keep(l5.mortality) noobs append ctitle("IV, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)


*DTP*
*UNESCO Schooling Data*

xtreg mortality l5.diff_dtp1coverage loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using firststage3.tex, label nocons keep(l5.diff_dtp1coverage) noobs replace ctitle("First Stage, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg mortality l10.diff_dtp1coverage loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

outreg2 using firststage3.tex, label nocons keep(l10.diff_dtp1coverage) noobs append ctitle("First Stage, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l.unicefmcv1 c.l.diff_mcv1coverage#i.l.mcv_covered) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
xtreg rateofoutofschoolMF l5.diff_dtp1coverage i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using firststage3.tex, label nocons keep(l5.diff_dtp1coverage) noobs append ctitle("Reduced Form, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg rateofoutofschoolMF l10.diff_dtp1coverage i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
outreg2 using firststage3.tex, label nocons keep(l10.diff_dtp1coverage) noobs append ctitle("Reduced Form, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality  = l5.diff_mcv1coverage) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
outreg2 using firststage3.tex, label nocons keep(l.mortality) noobs append ctitle("IV, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtivreg rateofoutofschoolMF i.year loggni logpop (l5.mortality = l20.diff_mcv1coverage) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
outreg2 using firststage3.tex, label nocons keep(l5.mortality) noobs append ctitle("IV, 10-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

*Long Differences*
xtreg rateofoutofschoolMF mortality yr21 yr41  loggni logpop i.year if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2000), fe robust cluster(pan_id)


* Levels * 
xtreg rateofoutofschoolMF l.unicefmcv1 i.mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
xtreg rateofoutofschoolMF l2.unicefmcv1 i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
xtivreg rateofoutofschoolMF i.year loggni logpop (l2.mortality = l3.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)
xtivreg rateofoutofschoolMF i.year loggni logpop (l.mortality = l2.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1, fe vce(cluster pan_id)

gen not_mcv_covered = 0 
replace not_mcv_covered = 1 if unicefmcv1 < 90

xtreg rateofoutofschoolMF l.unicefmcv1 c.l.diff_mcv1coverage#i.l.not_mcv_covered i.year loggni logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

 
>>>>>>> ec43410... first commit in a while. usually make this message informative
