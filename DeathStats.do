*DISEASE DEATHS*

clear

insheet using measles_deaths_60mo.csv, comma names
drop gho gbdchildcauses publishstate high low comments numeric mghereg sex agegroup region
rename displayvalue measles_deaths_60mo
rename country code
drop if missing(code)
save measles_deaths_60months, replace

clear

insheet using tetanus_deaths_1month.csv, comma names
drop agegroup numeric low high comments region
rename displayvalue tetanus_deaths_1mo
drop if missing(code)

save tetanus_deaths_1month, replace

clear

insheet using tetanus_deaths_60months.csv, comma names
drop gho gbdchildcauses publishstate high low comments numeric mghereg sex agegroup region
rename displayvalue tetanus_deaths_60mo
drop if missing(code)

save tetanus_deaths_60months, replace

clear

insheet using pertussis_deaths_1month.csv, comma names
drop agegroup region agegroup sex numeric
rename displayvalue pertussis_deaths_1mo
drop if missing(code)

save pertussis_deaths_1month, replace

clear

insheet using pertussis_deaths_60months.csv, comma names
drop region agegroup sex numeric
rename displayvalue pertussis_deaths_60mo
drop if missing(code)

save pertussis_deaths_60months, replace

merge 1:1 code year using pertussis_deaths_1month

drop _merge

merge 1:1 code year using tetanus_deaths_1month

drop _merge

merge 1:1 code year using tetanus_deaths_60months

drop _merge

merge 1:1 code year using measles_deaths_60months

drop _merge

rename code iso_code

merge 1:1 iso_code year using under5mortality

keep if(_merge == 3)
drop _merge

merge 1:1 iso_code year using gnipercap

drop if missing(gni)

bys iso_code: egen ave_gni = mean(gni)

*poor countries*
bys iso_code: gen low = 0
replace low = 1 if ave_gni <= 1035

*lower-mid countries*
bys iso_code: gen lowmid = 0
replace lowmid = 1 if(ave_gni > 1035 & ave_gni <= 4085)
*lower-mid countries*
bys iso_code: gen upmid = 0
replace upmid = 1 if(ave_gni > 4085 & ave_gni <= 12615)

bys iso_code: gen high = 0
replace high = 1 if ave_gni > 12615

*general categories by year*
bys iso_code: gen category = ""
replace category = "low" if low == 1
replace category = "lowmiddle" if lowmid == 1
replace category = "uppermiddle" if upmid == 1
replace category = "high" if high == 1

*Create entire childhood death variables*
gen pertussis_deaths = pertussis_deaths_60mo + pertussis_deaths_1mo
gen tetanus_deaths = tetanus_deaths_60mo + tetanus_deaths_1mo
gen dtp_deaths = tetanus_deaths + pertussis_deaths

*Deaths numbers*
gen number_measles_deaths = mortality*(measles_deaths/100)
gen number_dtp_deaths = mortality*(dtp_deaths/100)
gen number_vaccine_deaths = number_measles_deaths +  number_dtp_deaths

*convert from per 1000 to per 100000*
gen scaled_measles_deaths = number_measles_deaths * 100
gen scaled_dtp_deaths = number_dtp_deaths * 100
gen scaled_vaccine_deaths = number_vaccine_deaths * 100

sort category year
by category year: egen cat_yearly_measles_mean = mean(scaled_measles_deaths)
by category year: egen cat_yearly_dtp_mean = mean(scaled_dtp_deaths)

rename iso_code code
drop _merge
save deaths, replace

graph twoway (line cat_yearly_measles_mean year if category == "low" & year > 1979)(line cat_yearly_measles_mean year if category == "high" & year > 1979), ytitle("Measles Deaths per 100,000 Children") xtitle("Year") legend(label(1 "High Income") label(2 "Low Income"))
*graph twoway (line cat_yearly_dtp_mean year if category == "low" & year > 1979)(line cat_yearly_dtp_mean year if category == "high" & year > 1979), ytitle("Diptheria, Tetanus, Pertussis Deaths per 100,000 Children") xtitle("Year") legend(label(1 "High Income") label(2 "Low Income"))

keep year code pertussis_deaths tetanus_deaths measles_deaths_60mo
