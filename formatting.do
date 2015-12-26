*Saving all data into formatting*
*Country Reported Data*

insheet using countryreported_coverage_DTP1.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr countrydtp1
drop vaccine
save countryreportedDTP1, replace

clear

insheet using countryreported_coverage_DTP3.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr countrydtp3
drop vaccine
save countryreportedDTP3, replace

clear

insheet using countryreported_coverage_MCV1.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr countrymcv1
drop vaccine
save countryreportedMCV1, replace

clear

insheet using countryreported_coverage_MCV2.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr countrymcv2
drop vaccine
save countryreportedMCV2, replace

clear

insheet using countryreported_coverage_Pol3.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr countrypol3
drop vaccine
save countryreportedPol3, replace

clear

*UNICEF estimated data*

insheet using UNICEFcoverage_estimates_DTP1.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr unicefdtp1
drop vaccine
save unicefestimatedDTP1, replace

clear

insheet using UNICEFcoverage_estimates_DTP3.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr unicefdtp3
drop vaccine
save unicefestimatedDTP3, replace

clear

insheet using UNICEFcoverage_estimates_MCV1.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr unicefmcv1
drop vaccine
save unicefestimatedMCV1, replace

clear

insheet using UNICEFcoverage_estimates_MCV2.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr unicefmcv2
drop vaccine
save unicefestimatedMCV2, replace

clear

insheet using UNICEFcoverage_estimates_Pol3.csv, comma names
reshape long yr, i(iso_code) j(year)
rename yr unicefpol3
drop vaccine
save unicefestimatedPol3, replace

clear

*age for getting measles vaccines by country*

insheet using age_vaccines.csv, comma names
save agemeasles, replace
clear

*Loading number of cases by year and country*
insheet using dtp_cases.csv, comma names
reshape long dtpcases, i(iso_code) j(year)
drop disease
save dtpcases, replace

clear

insheet using measlescases.csv, comma names
reshape long measlescases, i(iso_code) j(year)
save measlescases, replace

clear

insheet using polio_cases.csv, comma names
reshape long poliocases, i(iso_code) j(year)
drop disease
save poliocases, replace

clear

*Loading some world bank data*
insheet using population.csv, comma names
reshape long pop, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save population, replace
clear

insheet using population_under14percenttotal.csv, comma names
reshape long under14pop, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save under14pop, replace
clear

*Measeles vaccine introduction*
insheet using MCV2_year_introduction.csv, comma names
save measles_details, replace

*Now we merge all of this stuff together using ISO codes as the common thread*

use countryreportedDTP1

merge 1:1 iso_code year using countryreportedDTP3
drop _merge

merge 1:1 iso_code year using countryreportedMCV1
drop _merge

merge 1:1 iso_code year using countryreportedMCV2
drop _merge

merge 1:1 iso_code year using countryreportedPol3
drop _merge

merge 1:1 iso_code year using unicefestimatedDTP3
drop _merge

merge 1:1 iso_code year using unicefestimatedDTP1
drop _merge

merge 1:1 iso_code year using unicefestimatedMCV1
drop _merge

merge 1:1 iso_code year using unicefestimatedMCV2
drop _merge

merge 1:1 iso_code year using unicefestimatedPol3
drop _merge

merge 1:1 iso_code year using dtpcases
drop _merge

merge 1:1 iso_code year using measlescases
drop _merge

merge 1:1 iso_code year using poliocases
drop _merge

merge 1:1 iso_code year using population
drop _merge

merge 1:1 iso_code year using under14pop
drop _merge


save master, replace


clear

use total_schooling
gen agegroup = 0

replace agegroup = 1 if (agefrom == 15 & ageto == 19) 
replace agegroup = 2 if (agefrom == 20 & ageto == 24) 
replace agegroup = 3 if (agefrom == 25 & ageto == 29) 
replace agegroup = 4 if (agefrom == 30 & ageto == 34) 
replace agegroup = 5 if (agefrom == 35 & ageto == 39) 
replace agegroup = 6 if (agefrom == 40 & ageto == 44) 
replace agegroup = 7 if (agefrom == 45 & ageto == 49) 
replace agegroup = 8 if (agefrom == 50 & ageto == 54) 
replace agegroup = 9 if (agefrom == 55 & ageto == 59) 
replace agegroup = 10 if (agefrom == 60 & ageto == 64) 
replace agegroup = 11 if (agefrom == 65 & ageto == 69) 
replace agegroup = 12 if (agefrom == 75 & ageto == 999) 
replace agegroup = 13 if (agefrom == 25 & ageto == 999) 
replace agegroup = 14 if (agefrom == 15 & ageto == 999) 

drop ageto
drop agefrom

*choose one age group to look at*
keep if (agegroup == 14)

merge 1:1 iso_code year using master

keep if (_merge == 3)

drop _merge

save totaldata, replace

*Now, add in all those world bank development indicators*

use under5mortality, clear
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")

merge 1:1 iso_code year using totaldata

drop _merge

save totalmortality, replace

use lifeexpect, clear
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")

merge 1:1 iso_code year using totalmortality

drop _merge

*GNI per capita, constant 2005 USD*
merge 1:1 iso_code year using gnipercap

drop _merge

merge m:1 iso_code using measles_details

*create dummy for gavi status*
tabulate gavi_mcv2, gen(gavi_status)

rename iso_code code
drop _merge
drop gavi_mcv2
drop gavi_status1

save completedata, replace

*** Begin the cleaning and calculating! ***

*Drop if outside date range*
drop if year < 1980
*Drop if missing schooling data*
by code year, sort: drop if missing(lp)
*Drop if missing measles data*
by code (year), sort: drop if _n == sum(mi(countrymcv1))

*average GNI*
bys code: egen ave_gni = mean(gni)

*this causes some weird things, not sure what to do*
*Why is this missing in places? should be readily available* 
replace gni = ave_gni if missing(gni) 

*do some simple calculations*
bys code year: gen youngpop = (under14pop/100) * pop

*poor countries*
bys year code: gen poor = 0
replace poor = 1 if gni <= 1045

*medium countries*
bys year code: gen medium = 0
replace medium = 1 if(gni > 1045 & gni <= 12736)

*rich countries*
bys code year: gen rich = 0
replace rich = 1 if gni > 12736

*generate country income classifications based on WB guidelines*
*general categories by year*
bys code year: gen category = ""
replace category = "poor" if poor == 1
replace category = "medium" if medium == 1
replace category = "rich" if rich == 1

*create log levels of variables*
gen loglifeexpect = log(lifeexpect)

*set up panel*
encode code, gen(pan_id)
tsset pan_id year

*generate factor variables for fixed effects*
tabulate pan_id, gen(cntry)
tabulate year, gen(yr)

*logs*
gen logmortality = log(mortality)
gen loglifeexpect = log(lifeexpect)

*percentage enrolled in primary school*
*is primary school a prerequisite for secondary school*
gen primary = lp + ls + lh

*people who went to primary school but didnt finish*
