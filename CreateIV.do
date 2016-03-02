
// Create instrument
*Basic fatality rates by disease
gen pol_fatality = .05
gen measles_fatality = .15
gen diptheria_fatality = .20
gen pertussis_fatality = .04
gen tetanus_fatality = .13
gen dtp_fatality = diptheria_fatality + pertussis_fatality + tetanus_fatality
gen total_fatality = dtp_fatality + measles_fatality  + pol_fatality 

*weighed by danger of diseases 

gen pol_weight = pol_fatality/total_fatality
gen measles_weight = measles_fatality/total_fatality
gen dtp_weight = dtp_fatality/total_fatality

*Create Fatality-weighted vaccine average 
* DTP is effective with one dose 68 percent of the time, close to 100% of the time with 3 doses 

gen weighted_vaccine_avg = unicefmcv1*measles_weight+ unicefpol3*pol_weight+ dtp_weight*(unicefdtp1*.68 + unicefdtp3*.32)

