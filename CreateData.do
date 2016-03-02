*Saving all data into formatting*
*Country Reported Data*
*FIRST - run schooling.do to format Barro/Lee schooling data*

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

insheet using line_item_vaccines.csv, comma names
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
reshape long natlbudget, i(iso_code) j(year)
save line_item, replace

clear

insheet using adult_mort.csv, comma names
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
reshape long adultmort, i(iso_code) j(year)
save adultmort, replace

clear


insheet using percent_total_expenditure_on_vacc_gov_funded.csv, comma names
reshape long vaxspending, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save percent_total_expenditure_on_vacc_gov_funded, replace


clear

insheet using countryreported_coverage_MCV2.csv, comma names
reshape long yr, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
rename yr countrymcv2
drop vaccine
save countryreportedMCV2, replace

clear


insheet using countryreported_coverage_MCV2.csv, comma names
reshape long yr, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
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


*Loading some world bank data*
insheet using population.csv, comma names
reshape long pop, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save population, replace
clear

insheet using deathrate.csv, comma names
reshape long death, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save death, replace
clear

insheet using infantmort.csv, comma names
reshape long infantmort, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save infantmort, replace
clear

insheet using population_under14percenttotal.csv, comma names
reshape long under14pop, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save under14pop, replace
clear

insheet using unesco.csv, comma names
save unesco, replace
clear

insheet using unescoM.csv, comma names
drop if missing(rateofoutofschoolm)
save unescoM, replace

clear

insheet using mortality_full.csv, comma names
reshape long mortality, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save oldmort, replace
clear


insheet using healthcare_percapita.csv, comma names
reshape long healthcare, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save healthcarepercapita, replace

clear

insheet using under5pop.csv, comma names
reshape long under5pop, i(iso_code) j(year)
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
save under5pop, replace

clear

insheet using WHOchild_mort.csv, comma names
replace iso_code = "ROU" if (iso_code == "ROM")
replace iso_code = "COD" if (iso_code == "ZAR")
drop if missing(iso_code)
save WHOchild_mort, replace

*NEED TO REDOWNLOAD MORTALITY DATA* 
*insheet using under5mortality_complete.csv, comma names
*rename code isocode
*save completeunder5, replace

clear

*Measeles vaccine introduction*
insheet using MCV2_year_introduction.csv, comma names
save measles_details, replace

*Now we merge all of this stuff together using ISO codes as the common thread*

use countryreportedDTP1

merge 1:1 iso_code year using countryreportedDTP3
drop _merge

merge 1:1 iso_code year using WHOchild_mort
drop _merge

merge 1:1 iso_code year using under5pop
drop _merge

merge 1:1 iso_code year using percent_total_expenditure_on_vacc_gov_funded
drop _merge

merge 1:1 iso_code year using line_item 
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

merge 1:1 iso_code year using fertility
drop _merge

merge 1:1 iso_code year using population
keep if _merge == 3
drop _merge

merge 1:1 iso_code year using death
keep if _merge == 3
drop _merge

merge 1:1 iso_code year using under14pop
drop _merge

merge 1:1 iso_code year using healthcarepercapita
drop _merge

merge 1:1 iso_code year using cases
drop _merge

merge 1:1 iso_code year using deaths_clean
drop _merge

merge 1:1 iso_code year using gdpcap
drop _merge

merge 1:1 iso_code year using oldmort
drop _merge

merge 1:1 iso_code year using unesco
drop _merge

merge 1:1 iso_code year using unescoM
drop _merge

merge 1:1 iso_code year using adultmort
drop _merge

merge 1:1 iso_code year using infantmort
drop _merge

merge 1:1 iso_code year using schooling_formatted
drop _merge

save master, replace

clear

use schooling_formatted

merge 1:1 iso_code year using master
drop _merge

save totaldata, replace

*Now, add in all those world bank development indicators*

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

drop _merge

drop gavi_status1

rename iso_code code

drop gavi_mcv2
drop gavi_status2

merge 1:1 code year using SIA
drop _merge

replace SIA = 0 if missing(SIA)

drop if country == "Romania"

replace country = "Yemen" if country == "Yemen, Rep."

save completedata, replace


// insheet using freedomhouseindex.csv, comma names
// drop status
//drop liberties1972
//reshape long liberties, i(country) j(year)
//merge 1:m country year using finaldata
