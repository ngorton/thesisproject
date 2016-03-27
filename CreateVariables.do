*** Begin the cleaning and calculating! ***
use completedata, clear

*to determine if country is missing all vaccine data*

*does the country have sufficient data? 1 if yes*
drop if missing(country) 

*generate factor variables for fixed effects*
*drop if missing(lp)
tabulate code, gen(pan_id) 
tabulate year, gen(yr)     

*set up panel*
encode code, gen(pan_id)
drop if pan_id==.

sort pan_id year
xtset pan_id year

gen in_sample = 1

gen interpolated_school = rateofoutofschoolmf
gen fiveyearlaggedlu = l10.lu
replace interpolated_school = fiveyearlaggedlu if missing(rateofoutofschoolmf)
gen enrollment = 100 - interpolated_school

replace in_sample = 0 if missing(unicefmcv1) | missing(interpolated_school)

*average GNI*
replace in_sample = 0 if missing(gni)

bys code: egen ave_gni = mean(gni)

*do some simple calculations*
bys code year: gen youngpop = (under14pop/100) * pop

* Make average vaccine score * 
gen vaccine_average = (unicefmcv1+unicefdtp1+unicefdtp3)/3
replace vaccine_average = (unicefmcv1+unicefdtp1)/2 if missing(unicefdtp3)
replace vaccine_average = (unicefmcv1+unicefdtp3)/2 if missing(unicefdtp3)
replace vaccine_average = unicefmcv1 if ( missing(unicefdtp3) & missing(unicefdtp1)) 


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

gen diptheria_deaths = diptheria*.20
gen dtp_deaths = pertussis_deaths + tetanus_deaths + diptheria_deaths

gen preventable_deaths = measles_deaths + dtp_deaths

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

replace dtp_treated = 1 if unicefdtp1 > 80

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

destring vaxspending, replace ignore("%")
 replace natlbudget = "Yes" if natlbudget == "YES"
tabulate natlbudget, gen(natl_spending)
 
generate budget_dummy = 0 if natl_spending1 == 1
replace budget_dummy = 1 if natl_spending2 == 1 

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

rename rateofoutofschoolmf rateofoutofschoolMF
rename rateofoutofschoolm rateofoutofschoolM

gen child_mort_WB = mortality - infantmort

gen interpolated_mort = mortality if missing(mean_mort)
replace interpolated_mort = meanmort if !missing(mean_mort)

* THE MAMA ASSUMPTION * 

* Create a variable based on whether or not a country will ever reach herd immunity*
bysort code: egen max_mcv1_coverage = max(unicefmcv1)
by code: gen dummy_ever_covered_mcv1 = 1 if max_mcv1_coverage > 89
by code: replace dummy_ever_covered_mcv1 = 0 if max_mcv1_coverage <= 89

* Create a variable based on whether a country has reached herd immunity in a given year*
sort code year
by code year: gen covered_mcv1_t = (unicefmcv1 > 89)
by code year: replace covered_mcv1_t = 0 if missing(unicefmcv1)

sort code year
by code year: gen presence_mcv1_t = (unicefmcv1 > 50)
by code year: replace presence_mcv1_t = 0 if missing(unicefmcv1)

bysort code year: gen presence_mcv1_t0 = (unicefmcv1 > 5)
bysort code year: replace presence_mcv1_t0 = 0 if (unicefmcv1 <= 5)

by code year: gen presence_mcv1_herd = (unicefmcv1 > 90)
by code year: replace presence_mcv1_herd = 0 if missing(unicefmcv1)

bysort code year: gen intervention_year = year if (unicefmcv1 > 50) & year > 1980
bysort code year: replace intervention_year = 1974 if (unicefmcv1 > 50) & year == 1980

bysort code year: gen intervention_year_dummy = 1 if !missing(intervention_year)
bysort code year: replace intervention_year_dummy = 0 if missing(intervention_year) & !missing(unicefmcv1)

bysort code year: gen intervention_year_DTP = year if (unicefdtp1 > 50) & year > 1980
bysort code year: replace intervention_year_DTP = 1974 if (unicefdtp1 > 50) & year == 1980

bysort code year: gen intervention_year_dummy_DTP = 1 if !missing(intervention_year_DTP)
bysort code year: replace intervention_year_dummy_DTP = 0 if missing(intervention_year_DTP) & !missing(unicefdtp1)


label variable loggdpcap "Log GDP Per Cap."
* Calculate Survival Rate * 
gen mortality_perc = mortality/1000 * 100 
gen survival_rate = 100 - mortality_perc

* Calculate young child rate
gen young_mort = mortality-infantmort
gen young_survive = (1 - young_mort/1000)*100

// Supported? 
//gen supported = (mean_vaxspending < 40)


// Labeling all variables 
label variable not_mcv_covered "Dummy for Not Measles Herd Immune"
label variable not_dtp_covered "Dummy for Not DTP Herd Immune"

label variable measles_prcnt_under5 "Percentage of Measles Cases in under 5 Population"                          
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
label variable survival_rate "Chilldhood Survival Rate"
label variable interpolated_school "Schooling"
label variable fertility "Fertility Rate"
label variable gdpcap "GDP per Capita"
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
label variable unicefmcv1 "MCV1 Coverage"
label variable unicefmcv2 "MCV2 Coverage"
label variable unicefpol3 "Unicef-Reported Polio Coverage"
label variable pop "Population"
label variable logmortality "Log Childhood Mortality"
label variable logpop "Log Population"
label variable gni "GNI per Capita"
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

// Add some more things and check for duplicates
quietly bysort country year:  gen dup = cond(_N==1,0,_n)

drop if dup == 2

drop dup 

// Add in liberties data 
merge 1:1 code year using liberties_merged
label variable liberties "Civil Liberties"


// Drop unmerged from using
drop if _merge == 2
drop _merge 

drop if missing(code)
rename code iso_code 

// Adult Morality Data

merge 1:1 iso_code year using adultmort
drop _merge

// Mean Years of Schooling 

merge 1:1 iso_code year using meanyears_long
drop _merge

merge 1:1 iso_code year using primary_age
drop _merge


// Delete dups
quietly bysort pan_id year:  gen dup = cond(_N==1,0,_n)
drop if dup >1 
drop dup

// Region codes
merge m:1 iso_code using regioncodes
drop _merge

drop v59-v69 v16
drop region
encode region_code, gen(region)

drop if missing(year)

rename iso_code code 

merge 1:1 code year using lifetables_merge
drop if _merge == 2
drop _merge 

rename code  iso_code
merge 1:1 iso_code year using preprimary
drop if _merge == 2
drop _merge 

 merge 1:1 iso_code year using wbprimary
 drop if _merge == 2
drop _merge
 
// Set up panel data!
xtset

// Save data file
save finaldata, replace
