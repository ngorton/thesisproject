** OLS ESTIMATES
* Long Differences 
xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2000 | year == 2012), fe robust cluster(pan_id)

xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)

xtreg rateofoutofschoolMF survival_rate i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 2012), fe robust cluster(pan_id)

xtreg rateofoutofschoolMF l.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

xtreg rateofoutofschoolMF l2.mortality l.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

xtreg rateofoutofschoolMF l3.mortality i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

* Regular Estimates



** IV ESTIMATES

** ROBUSTNESS TESTS -- Autocorrelation

** ROBUSTNESS TESTS --  Non-Linearity 
