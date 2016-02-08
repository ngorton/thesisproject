*** Begin the cleaning and calculating! ***
use completedata, clear

*to determine if country is missing all vaccine data*
egen sum_measlesvacc=rowtotal(countrymcv2 countrymcv1 unicefmcv2 unicefmcv1)
egen sum_dtpvacc=rowtotal(countrydtp3 countrydtp1 unicefdtp3 unicefdtp1)
<<<<<<< HEAD
=======
egen sum_schooling=rowtotal(rateofoutofschoolF rateofoutofschoolM rateofoutofschoolMF)
>>>>>>> ec43410... first commit in a while. usually make this message informative

*does the country have sufficient data? 1 if yes*
drop if missing(country)
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

<<<<<<< HEAD
*GAVI Eligible in 2000?*
gen gavi_status = 0
replace gavi_status = 1 if ave_gni < 1580
=======
*GAVI Eligible in 2015?*
xtset 

gen gni_val_2000 = gni if year == 2000
gen gavi_status_00 = 0
replace gavi_status_00 = 1 if gni_val_2000 < 1000 | ave_gni < 1000
bysort code: replace gavi_status_00 = 1 if sum(gavi_status_00) == 1
replace gavi_status_00 = 1 if country == "Myanmar"
replace gavi_status_00 = 1 if country == "Sri Lanka"
replace gavi_status_00 = 0 if code == "GNQ"
replace gavi_status_00 = 1 if country == "Sao Tome and Principe"
replace gavi_status_00 = 1 if country == "Solomon Islands"
replace gavi_status_00 = 1 if country == "Albania"
replace gavi_status_00 = 1 if country == "Timor-Leste"
replace gavi_status_00 = 0 if code == "SYR"
replace gavi_status_00 = 0 if code == "SYR"
replace gavi_status_00 = 0 if code == "PHL"
>>>>>>> ec43410... first commit in a while. usually make this message informative


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
<<<<<<< HEAD
replace dtp_treated = 1 if unicefdtp1 > 84
=======
replace dtp_treated = 1 if unicefdtp1 > 80

sort category year
by category year: egen est_sum_cases = sum(estimated_measles_deaths)
by category year: egen est_avg_coverage = mean(unicefmcv1)


*Variables for regressions*

xtset pan_id year, yearly

gen diff_mcv1coverage = D.unicefmcv1
gen diff_dtp1coverage = D.unicefdtp1

gen diff_mortality = D.mortality
gen diff_cases = D.measles_cases

gen loggni = ln(gni)
gen logyoungpop = ln(youngpop)
gen loggdpcap = ln(gdpcap)

gen mcv_covered = 0 
replace mcv_covered = 1 if unicefmcv1 > 90

gen dtp_covered = 0 
replace dtp_covered = 1 if unicefdtp1 > 83

gen mortality_10000 = mortality*10

gen inter_rateofoutofschoolM = rateofoutofschoolM
if missing(rateofoutofschoolM) replace inter_rateofoutofschoolM = l10.lu

destring vaxspending, replace ignore("%")
tabulate natlbudget, gen(natl_spending)
 
drop natl_spending1 
generate budget_dummy = 0
replace budget_dummy = 1 if natl_spending3 == 1 | natl_spending4 == 1

gen diff_spending = D.vaxspending

egen mean_difference_spending = mean(diff_spending)

gen not_mcv_covered = 0 
replace not_mcv_covered = 1 if unicefmcv1 < 90

gen not_dtp_covered = 0 
replace not_dtp_covered = 1 if unicefdtp1 < 83

gen under5pop_total = under5pop*pop

*do stuff with number of cases*
gen measles_prcnt_under5 = measles_cases/under5pop_total * 100 
gen dtp_prcnt_under5 = dtp_cases/under5pop_total * 100 

gen mcv1_cov_squared = unicefmcv1*unicefmcv1

gen uncoveredmcv1 = 100 - unicefmcv1
gen uncovereddtp1 = 100 - unicefdtp1

bysort code: egen mean_country_mcv1 = mean(unicefmcv1)
bysort code: gen perm_herd_status = 1 if mean_country_mcv1 > 84
bysort code: replace perm_herd_status = 0 if mean_country_mcv1 <= 84
bysort year gavi_status_00 perm_herd_status: egen meanmort = mean(mortality)

egen mean1960 = mean(mortality) if yr1 == 1 
egen mean2000 = mean(mortality) if yr41 == 1

gen long_change = mean2000 - mean1960

>>>>>>> ec43410... first commit in a while. usually make this message informative


*label all variables*
label variable not_mcv_covered "Dummy for Not Measles Herd Immune"
label variable not_dtp_covered "Dummy for Not DTP Herd Immune"

label variable measles_prcnt_under5 "Percentage of Measles Cases in under 5 Population"                          yr41
label variable dtp_prcnt_under5 "Percentage of DTP Cases in under 5 Population"

label variable under5pop_total "Number of Children under 5"
label variable diff_spending "Differences in Vaccine Spending between years"

label variable budget_dummy "Dummy for Budget line for Vaccine Spending"

label variable diff_mcv1coverage "Differences in MCV1 Coverage between years"
label variable diff_dtp1coverage "Differences in DTP1 Coverage between years"

label variable rateofoutofschoolMF "Percentage of Children of Primary Age Out of School, Boys and GIrls"

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
label variable lifeexpect "Life Expectancy at Birth"
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

*drop if missing(unicefmcv1)


save finaldata, replace


*latabstat DTP_data, by(category) statistics(mean max min sd) format(%8.0gc)
*latabstat measles_data, by(category) statistics(mean max min sd) format(%8.0gc)
