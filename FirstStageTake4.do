
xtreg estimated_measles_deaths l.unicefmcv1 gni youngpop, fe robust cluster(pan_id)
xtreg estimated_measles_deaths l.unicefmcv1 youngpop, fe robust cluster(pan_id)
xtreg estimated_measles_deaths l.unicefmcv1, fe robust cluster(pan_id)


xtreg estimated_dtp_deaths l.unicefdtp1 gni youngpop, fe robust cluster(pan_id)
xtreg estimated_dtp_deaths l.unicefdtp1 youngpop, fe robust cluster(pan_id)
xtreg estimated_dtp_deaths l.unicefdtp1, fe robust cluster(pan_id)
