*Disease CASES*

clear

insheet using measles_cases.csv, comma names
reshape long measles, i(code) j(year)
save measles_cases, replace

clear

insheet using mumps_cases.csv, comma names
reshape long mumps, i(code) j(year)
save mumps_cases, replace

clear

insheet using rubella_cases.csv, comma names
reshape long rubella, i(code) j(year)
save rubella_cases, replace

clear

insheet using diptheria_cases.csv, comma names
reshape long diptheria, i(code) j(year)
save diptheria_cases, replace

clear

insheet using tetanus_cases.csv, comma names
reshape long tetanus, i(code) j(year)
save tetanus_cases, replace

clear

insheet using pertussis_cases.csv, comma names
reshape long pertussis, i(code) j(year)
save pertussis_cases, replace

merge 1:1 code year using tetanus_cases
drop _merge

merge 1:1 code year using diptheria_cases
drop _merge

merge 1:1 code year using rubella_cases
drop _merge

merge 1:1 code year using mumps_cases
drop _merge

merge 1:1 code year using measles_cases
drop _merge



*Make variables*

rename measles measles_cases

gen dtp_cases = diptheria + tetanus + pertussis


if missing(tetanus) & missing(pertussis) replace DTP_data = diptheria
if missing(tetanus) & missing(diptheria) replace DTP_data = pertussis
if missing(diptheria) & missing(pertussis) replace DTP_data = tetanus

drop country
*save file*
save cases, replace
