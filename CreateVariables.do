*** Begin the cleaning and calculating! ***
use completedata, clear

*to determine if country is missing all vaccine data*
egen sum_measlesvacc=rowtotal(countrymcv2 countrymcv1 unicefmcv2 unicefmcv1)
egen sum_dtpvacc=rowtotal(countrydtp3 countrydtp1 unicefdtp3 unicefdtp1)

*does the country have sufficient data? 1 if yes*
gen in_sample = 1
replace in_sample = 0 if(sum_dtpvacc == 0 & sum_measlesvacc == 0)

*generate factor variables for fixed effects*
*drop if missing(lp)
tabulate code, gen(pan_id) 
tabulate year, gen(yr) 

*set up panel*
encode code, gen(pan_id)
tsset pan_id year
xtset
*average GNI*
replace in_sample = 0 if missing(gni)

bys code: egen ave_gni = mean(gni)

*do some simple calculations*
bys code year: gen youngpop = (under14pop/100) * pop

*poor countries*
bys code: gen low = 0
replace low = 1 if ave_gni <= 1035

*lower-mid countries*
bys code: gen lowmid = 0
replace lowmid = 1 if(ave_gni > 1035 & ave_gni <= 4085)
*lower-mid countries*
bys code: gen upmid = 0
replace upmid = 1 if(ave_gni > 4085 & ave_gni <= 12615)

*rich countries*
bys code: gen high = 0
replace high = 1 if ave_gni > 12615

*general categories by year*
bys code: gen category = ""
replace category = "low" if low == 1
replace category = "lowmiddle" if lowmid == 1
replace category = "uppermiddle" if upmid == 1
replace category = "high" if high == 1

*GAVI Eligible in 2000?*
gen gavi_status = 0
replace gavi_status = 1 if ave_gni < 1580


*create log levels of variables*
gen loglifeexpect = log(lifeexpect)
gen logmortality = log(mortality)
gen logpop = log(pop)

*construct country average, average of all vaccine coverage - country reported*
egen vaccine_score_country = rmean(countrydtp1  countrydtp3 countrymcv1 countrymcv2 countrypol3)
egen vaccine_score_unicef = rmean(unicefdtp1 unicefdtp3 unicefmcv1 unicefmcv2 unicefpol3)
egen vaccine_score = rmean(vaccine_score_country vaccine_score_unicef)

*generate averages by disease*
egen measles_average = rmean(countrymcv1 countrymcv2 unicefmcv1 unicefmcv2)
egen dtp_average = rmean(countrydtp1 countrydtp3 unicefdtp1 unicefdtp3 )
egen polio_average = rmean(countrypol3 unicefpol3)

*do stuff with number of cases*
gen measles_youngpop = measles_cases/youngpop
gen dtp_youngpop = dtp_cases/youngpop

*generate averages for plotting purposes*
sort gavi_status year 
by gavi_status year: egen mean_measles = mean(measles_cases)
by gavi_status year: egen mean_dtp = mean(dtp_cases)

*measles cases as percentage of young population (under14)*
gen measles_percent_pop = measles_cases/youngpop
gen dtp_percent_pop = dtp_cases/youngpop

*combine diseases for a hopefully larger affect*
gen preventable_cases = measles_cases + dtp_cases

*percentage of vaccinated population*

*estimate measles deaths - 114 900  deaths in 2014*
gen est_measles_fatality_rate = measles_deaths_60mo/measles_cases 
gen est_pertussis_fatality_rate = pertussis_deaths/pertussis
gen est_tetanus_fatality_rate = tetanus_deaths/tetanus

gen diptheria_deaths = diptheria*.20
gen dtp_deaths = pertussis_deaths + tetanus_deaths + diptheria_deaths
gen dtp_fatality_rate = 0.2 + est_pertussis_fatality_rate + est_tetanus_fatality_rate 

gen preventable_deaths = measles_deaths + dtp_deaths

egen mean_measles_rate = mean(measles_fatality_rate)
gen estimated_measles_deaths = mean_measles_rate*measles_cases

egen mean_dtp_rate = mean(dtp_fatality_rate)
gen estimated_dtp_deaths = mean_dtp_rate*dtp_cases

gen estimated_preventable_deaths = estimated_measles_deaths + estimated_dtp_deaths


*scale death numbers based on size of young population*
gen measles_deaths_under5pop = measles_deaths_60mo/under5pop
gen dtp_deaths_under5pop = dtp_deaths/under5pop

gen measles_deaths_under14pop = measles_deaths_60mo/youngpop
gen dtp_deaths_under14pop = dtp_deaths/youngpop

*herd immunity dummy variables*
sort code year
by code year: gen measles_treated = 0 if !missing(unicefmcv1)
replace measles_treated = 1 if unicefmcv1 > 89

by code year: gen dtp_treated = 0 if !missing(unicefmcv1)
replace dtp_treated = 1 if unicefdtp1 > 84


*label all variables*
label variable measles_average "Average Reported Coverage of MCV1, MCV2"
label variable polio_average "Average Reported Coverage of Polio Vaccine"
label variable dtp_average "Average Reported Coverage of DTP1, DTP2"
label variable some_primary "Primary Enrollment"
label variable primary_completed "Population with Complete Primary Education"
label variable secondary_completed "Population with Complete Secondary Education"
label variable tertiary_completed "Population with Complete Higher Education"
label variable code "ISO Country Code"
label variable year "Year"
label variable country "Country"
label variable lifeexpect "Life Expectancy at Birth'
label variable mortality "Childhood (0-5) Mortality per 1000 Births"
label variable agegroup "Barro-Lee Age Group"
label variable avg_years_total "Average Years of Schooling, by country"
label variable avg_years_primary "Average Years of Primary Schooling, by country"
label variable year_primary "Official Primary School Entry Age"
label variable loglifeexpect "Log Life Expectancy at Birth"
label variable countrydtp1 "Country-Reported DTP1 Coverage"
label variable countrydtp3 "Country-Reported DTP3 Coverage"
label variable countrymcv1 "Country-Reported MCV1 Coverage"
label variable countrymcv2 "Country-Reported MCV2 Coverage"
label variable countrypol3 "Country-Reported Polio Coverage"
label variable unicefdtp1 "Unicef-Reported DTP1 Coverage"
label variable unicefdtp3 "Unicef-Reported DTP3 Coverage"
label variable unicefmcv1 "Unicef-Reported MCV1 Coverage"
label variable unicefmcv2 "Unicef-Reported MCV2 Coverage"
label variable unicefpol3 "Unicef-Reported Polio Coverage"
label variable pop "Population"
label variable logmortality "Log Childhood Mortality"
label variable logpop "Log Population"
label variable gni "GNI per Capita"
label variable gavi_status2 "Eligible for GAVI support"
label variable youngpop "Population under 14"
label variable sd_years_total "Standard Deviation of Years of Schooling, by country"
label variable sd_years_primary "Standard Deviation of Primary Schooling, by country"
label variable low "Low Income Countries, as defined by 2014 World Bank Guidelines"
label variable lowmid "Low-Middle Income Countries, as defined by 2014 World Bank Guidelines"
label variable upmid "Upper-Middle Income Countries, as defined by 2014 World Bank Guidelines"
label variable high "High Income Countries, as defined by 2014 World Bank Guidelines"
label variable category "Income Group"
label variable ave_gni "Average GNI per Capita by country (over time series)"
label variable under14pop "Percentage of Population under 14"
label variable mortality "Under 5 Mortality"

*people who went to primary school but didnt finish*
save finaldata, replace


*latabstat DTP_data, by(category) statistics(mean max min sd) format(%8.0gc)
*latabstat measles_data, by(category) statistics(mean max min sd) format(%8.0gc)
