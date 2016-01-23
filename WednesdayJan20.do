ls
do simulation
do simulation
do simulation
clear
do simulation
do simulation
do simulation
do simulation
sum p
do simulation
do simulation
do simulation
mkspline pslit 5 = p
twoway mspline school_val p, bands(5)
do simulation
do simulation
do simulation
graph twoway (scatter school_val p)(scatter noschool_val p)
gen p = (rnormal() + 1)/2
gen school_val = -f*(1-p)*a + (T-a)*high_wage
replace school_val = 0 if p == 1
gen noschool_val = a*low_wage*(1-p) + T*low_wage
replace noschool_val = 0 if p ==1
graph twoway (scatter school_val p)(scatter noschool_val p)
clear
gen p = (rnormal() + 1)/2
gen school_val = -f*(1-p)*a + (T-a)*high_wage
replace school_val = 0 if p == 1
gen noschool_val = a*low_wage*(1-p) + T*low_wage
replace noschool_val = 0 if p ==1
graph twoway (scatter school_val p)(scatter noschool_val p)
*1: set observations to 1000 for simulation*
clear
set obs 1000
*2: generate x1*
gen high_wage = rnormal(5, 1)
gen low_wage = 3.5
gen T = 70
gen a = 15
gen f = 1
*probability of death*
gen p = (rnormal() + 1)/2
gen school_val = -f*(1-p)*a + (T-a)*high_wage
replace school_val = 0 if p == 1
gen noschool_val = a*low_wage*(1-p) + T*low_wage
replace noschool_val = 0 if p ==1
graph twoway (scatter school_val p)(scatter noschool_val p)
*1: set observations to 1000 for simulation*
clear
set obs 1000
*2: generate x1*
gen high_wage = rnormal(5, 1)
gen low_wage = 3.5
gen T = 70
gen a = 15
gen f = 1
*probability of death*
gen p = (rnormal() + 2)/2
gen school_val = -f*(1-p)*a + (T-a)*high_wage
replace school_val = 0 if p == 1
gen noschool_val = a*low_wage*(1-p) + T*low_wage
replace noschool_val = 0 if p ==1
graph twoway (scatter school_val p)(scatter noschool_val p)
gen y = 0
replace y = 1 if school_val > noschool_val
do simulation
clear
do simulation
clear
do simulation
do simulation
graph twoway (scatter school_val p)(scatter noschool_val p)
*1: set observations to 1000 for simulation*
clear
set obs 1000
*2: generate x1*
gen high_wage = rnormal(5, 1)
gen low_wage = 3.5
gen T = 70
gen a = 15
gen f = 1
*probability of death*
gen p = (rnormal() + 2)/2
drop if p < 0 
drop if p > 1 
gen school_val = -f*(1-p)*a + (T-a)*high_wage
replace school_val = 0 if p = 0
gen noschool_val = a*low_wage*(1-p) + T*low_wage
replace noschool_val = 0 if p = 0
graph twoway (scatter school_val p)(scatter noschool_val p)
hist p
replace p = rnormal()
hist p
replace p = rnormal()/2 + 1
hist p
hist p
clear
ls
cd
ls
cd Desktop/data
ls
ls
cd
cd Desktop/data/theory
gen p = rnormal(0.5, 0.5) + 0.5
hist p
clear
cd
cd
cd Desktop/data
use finaldata
sum measlesdeaths
sum age_vaccines
sum agemeasles
clear
do DeathStats
do DeathStats_WHO
clear
do CreateVariables
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
label variable dtpcases "DTP Cases"
label variable measlescases "Measles Cases"
label variable poliocases "Polio Cases"
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
merge 1:1 code year using death
drop _merge
merge 1:1 code year using cases
latabstat DTP_data, by(category) statistics(mean max min sd) format(%8.0gc)
latabstat measles_data, by(category) statistics(mean max min sd) format(%8.0gc)
merge 1:1 code year using deaths
merge 1:1 iso_code year using deaths
clear
do DeathStats
clear 
do CreateVariables
merge 1:1 code year using deaths
drop _merge
merge 1:1 code year using deaths
clear
use deaths
drop _merge
save deaths
save deaths, replace
graph twoway (line cat_yearly_measles_mean year if category == "low" & year > 1979)(line cat_yearly_measles_mean year if category == "high" & year > 1979), ytitle("Measles Deaths per 100,000 Children") xtitle("Year") legend(label(2 "High Income") label(1 "Low Income"))
clear
use cases
clear
do CreateVariables
list country if _merge == 1
list country if _merge == 2
clear
do DeathStats_WHO
do CreateVariables
clear
use cases
drop region
save cases, replace
clear
use finaldata
merge 1:1 code year using cases
sum if _merge == 1
clear
use DeathStats_WHO
use DeathStats_HO
use cases
rename code iso_code
clear
do formatting
clear
use cases
rename code iso_code
save cases, replace
clear
do formatting
clear
do formatting
clear
do formatting
clear
do formatting
clear
do formatting
clear
do formatting
tabulate code, gen(pan_id) 
tabulate year, gen(yr) 
set obs 23
set obs 100
gen grades = rnorm(92, 8.8) 
gen grades = rnormal(92, 8.8) 
hist grades
drop grades
generate order = _n
by country (order), sort: generate y = _n == 1
sort country order
 by country: gen y = _n == 1 
sum y
sum order
sort order
replace y = sum(y)
sum y
drop order
by code, sort: generate nvals = _n == 1
count if nvals ==1 
clear
do formatting
ssc install dropmiss
scc install dropmiss
drop if (missing(countryreportedDTP3) & missing(countryreportedDTP1) & missing(countryreportedMCV1) & missing(countryreportedMCV2))
drop if (missing(countrydtp3) & missing(countrydtp1) & missing(countrymcv1) & missing(countrymcv2))
clear
do formatting
merge 1:m iso_code using measles_details
*create dummy for gavi status*
tabulate gavi_mcv2, gen(gavi_status)
drop _merge
drop gavi_status1
rename iso_code code
drop if (missing(countrydtp3) & missing(countrydtp1) & missing(countrymcv1) & missing(countrymcv2)& missing(unciefdtp3) & missing(unciefdtp1) & missing(unciefmcv1) & missing(unciefmcv2))
save completedata, replace
merge m:1 iso_code using measles_details
merge m:1 code using measles_details
clear
do formatting
drop if (missing(countrydtp3) & missing(countrydtp1) & missing(countrymcv1) & missing(countrymcv2)& missing(unicefdtp3) & missing(unicefdtp1) & missing(unicefmcv1) & missing(unicefmcv2))
tabulate code, gen(pan_id) 
clear
do formatting
gen sum_vaccines = countrydtp3 + countrydtp1 + countrymcv1 + countrymcv2 + uniceftp3 + unicefdtp1 + unicefmcv1 + unicefmcv2
gen sum_vaccines = countrydtp3 + countrydtp1 + countrymcv1 + countrymcv2 + unicefdtp3 + unicefdtp1 + unicefmcv1 + unicefmcv2
tabulate code, gen(num) 
tabulate year, gen(yr) 
by num (year), sort: drop if _n == sum(mi(sum_vaccines))
by code (year), sort: drop if _n == sum(mi(sum_vaccines))
clear
do formatting
save completedata, replace
do CreateVariables
clear
do formatting
clear
do formatting
clear
do formatting
clear
do formatting
clear
do formatting
_n == sum(mi(sum_vaccines_DTP))
by code (year), sort: drop if _n == sum(!mi(sum_vaccines_DTP)) == 0
gen sum_vaccines_DTP = countrydtp3 + countrydtp1 + unicefdtp3 + unicefdtp1
gen sum_vaccines_measles = countrymcv1 + countrymcv2 + unicefmcv1 + unicefmcv1
clear
do formatting
egen sum_dtpvacc=rowtotal(countrydtp3, countrydtp1, unicefdtp3, unicefdtp1)
egen sum_dtpvacc=rowtotal(countrydtp3 countrydtp1 unicefdtp3 unicefdtp1)
egen sum_measlesvacc=rowtotal(countrymcv2 countrymcv1 unicefmcv2 unicefmcv1)
egen sum_dtpvacc=rowtotal(countrydtp3 countrydtp1 unicefdtp3 unicefdtp1)
drop if sum_dtpvacc == 0 and sum_measlesvacc == 0
drop if sum_dtpvacc == 0 & sum_measlesvacc == 0
sort country year
do CreateVariables
clear
use completedata
egen sum_measlesvacc=rowtotal(countrymcv2 countrymcv1 unicefmcv2 unicefmcv1)
egen sum_dtpvacc=rowtotal(countrydtp3 countrydtp1 unicefdtp3 unicefdtp1)
drop if sum_dtpvacc == 0 & sum_measlesvacc == 0
sort country year
save completedata, replace
clear
do CreateVariables
graphy twoway (line year measles_cases if low == 1)(line year measles_cases if high== 1)
graph twoway (line year measles_cases if low == 1)(line year measles_cases if high== 1)
by year category: egen average_measles_cases = mean(measles_cases)
sort category year
by year category: egen average_measles_cases = mean(measles_cases)
sort year category
by year category: egen average_measles_cases = mean(measles_cases)
graph twoway (line year measles_cases if low == 1)(line year measles_cases if high== 1)
graph twoway (line measles_cases year if low == 1)(line measles_cases year if high== 1)
graph twoway (scatter measles_cases year if low == 1)(scatter measles_cases year if high== 1)
drop average_measles_cases
by category year: egen average_measles_cases = mean(measles_cases)
sort category year
by category year: egen average_measles_cases = mean(measles_cases)
graph twoway (scatter measles_cases year if low == 1)(scatter measles_cases year if high== 1)
graph twoway (scatter measles_cases year if low == 1)(scatter measles_cases year if high== 1)
graph twoway (lfit measles_cases year if low == 1)(lfit measles_cases year if high== 1)
tabstat dtp_cases measles_cases, by(category) statistics(max min mean sd n)
by country (year): egen measles_cases_pop = measles_cases/pop
sort country year
by country (year): egen measles_cases_pop = measles_cases/pop
by country (year): gen measles_cases_pop = measles_cases/pop
tabstat measles_cases_pop, by(category) statistics(max min mean sd n)
gen dtp_youngpop = dtp_cases/youngpop
gen measles_youngpop = measles_cases/youngpop
sum measles_youngpop
*generate averages for plotting purposes*
sort category year 
by category year: egen mean_measles = mean(measles_cases)
by category year: egen dtp_measles = mean(dtp_cases)
twoway line measles_cases year, by(category)
twoway scatter measles_cases year, by(category)
twoway scatter measles_cases year if low == 1
twoway scatter measles_cases year if low == 1 | lowmid == 1
twoway scatter measles_cases year if low == 1 | lowmid == 1, mlabel(code)
twoway scatter measles_cases year if low == 1, mlabel(code)
twoway scatter mean_measles year if low == 1, mlabel(code)
twoway scatter mean_measles year, by(category)
graph twoway (line mean_measles year if low == 1)(line mean_measles year if high == 1)
*GAVI Eligible in 2000?*
gen gavi_status = 0
replace gavi_status = 1 if ave_gni < 1580
graph twoway (line mean_measles year if gavi_status == 1)(line mean_measles year if gavi_status == 1)
graph twoway (line mean_measles year if gavi_status == 1)(line mean_measles year if gavi_status == 0)
graph twoway (scatter mean_measles year if gavi_status == 1)(scatter mean_measles year if gavi_status == 0)
by gavi_status year: egen mean_measles_gavi = mean(measles_cases)
sort gavi_status year
by gavi_status year: egen mean_measles_gavi = mean(measles_cases)
by gavi_status year: egen mean_dtp_gavi = mean(dtp_cases)
graph twoway (line mean_measles year if gavi_status == 1)(line mean_measles year if gavi_status == 0)
graph twoway (line mean_measles_gavi year if gavi_status == 1)(line mean_measles_gavi year if gavi_status == 0)
graph twoway (line mean_measles_gavi year if gavi_status == 1)(line mean_measles year if high == 1)
clear
do DeathStats
graph twoway (line cat_yearly_measles_mean year if category == "low" & year > 1979)(line cat_yearly_measles_mean year if category == "high" & year > 1979), ytitle("Measles Deaths per 100,000 Children") xtitle("Year") legend(label(1 "High Income") label(2 "Low Income"))
keep year code pertussis_deaths tetanus_deaths measles_deaths_60mo
save deaths_clean
rename code iso_code
save deaths_clean, replace
clear
do formatting
do CreateVariables
xtreg f.unicefmcv1 unicefmcv1 healthcare i.year, fe
sort
sort country year
xtreg f.unicefmcv1 unicefmcv1 healthcare i.year, fe
tsset pan_id year
xtreg f.unicefmcv1 unicefmcv1 healthcare i.year, fe
xtreg f.unicefmcv1 unicefmcv1 gni i.year, fe
xtreg f10.some_primary mortality gni i.year, fe
plot residuals
rvfplot, yline(0)
xtreg f10.some_primary mortality gni i.year, fe
rvfplot, yline(0)
predict res, e
plot e
plot res
xtreg f.measles_deaths_60mo unicefmcv1 i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1 gni i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1 unicefdtp2 gni i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1 unicefdtp3 gni i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1 i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1 gni i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1 healthcare i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1 i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1 i.year low, fe
xtreg f.measles_deaths_60mo unicefmcv1^2 i.year, fe
xtreg f.measles_deaths_60mo unicefmcv1*i.low i.year, fe
xtreg f.measles_deaths_60mo i.low*unicefmcv1 i.year, fe
xtreg f.measles_cases unicefmcv1 i.year, fe
xtreg f2.measles_cases unicefmcv1 i.year, fe
xtreg f2.measles_cases i.low#unicefmcv1 i.year, fe
xtreg f2.measles_cases i.low#c.unicefmcv1 loghealthcare i.year, fe cluster(pan_id)
xtreg f2.measles_cases i.low#c.unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg f2.measles_cases i.gavi_status#c.unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg f1.measles_cases i.gavi_status#c.unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg f3.measles_cases i.gavi_status#c.unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg f1.measles_cases i.gavi_status#c.unicefmcv1 unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg f2.measles_cases i.low#c.unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg f1.measles_cases i.gavi_status#c.unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg f3.measles_cases i.gavi_status#c.unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg f2.mortality i.low#c.unicefmcv1 loghealthcare i.year, fe cluster(pan_id)
xtreg f2.mortality i.low#c.unicefmcv1 healthcare i.year, fe cluster(pan_id)
xtreg measles_cases mortality, fe
xtreg measles_cases mortality i.year, fe
xtreg mortality  measles_cases i.year, fe
gen in_sample=1 if e(sample)==1
sum if in_sample == 1
sum if in_sample == 0
correlate measles_cases measles_deaths
correlate measles_cases measles_deaths healthcare unicefmcv1
correlate measles_cases measles_deaths healthcare unicefmcv1 if low == 1
correlate measles_cases measles_deaths healthcare unicefmcv1 if low == 0
correlate measles_cases measles_deaths healthcare unicefmcv1 gni if low == 0
correlate measles_cases measles_deaths healthcare unicefmcv1 gni if low == 1
correlate dtp_cases dtp_deaths healthcare unicefmcv1 gni 
correlate dtp_cases healthcare unicefmcv1 gni 
correlate dtp_cases healthcare unicefmcv1 gni mortality
use "/Users/nicolegorton/Desktop/data/GDP.dta", clear
use "/Users/nicolegorton/Desktop/data/gdpcap.dta"
clear
cd 
cd Desktop/data
use gdpcap
replace code iso_code
rename code iso_code
save gdpcap
save gdpcap, replace
c;ear
clear
use measles_cases
graph twoway scatter measles year
sort country year
sort region year
by region year: egen average_coverage = mean(measles)
graph twoway scatter average_coverage year
graph twoway scatter average_coverage year, by(region)
graph twoway scatter average_coverage year, by(region) xline(2000)
clear
use finaldata
sort gavi_status year
by gavi_status year: egen average_coverage = mean(measles)
by gavi_status year: egen average_coverage = mean(measles_cases)
graph twoway scatter average_coverage year, by(region) xline(2000)
graph twoway scatter average_coverage year, by(gavi_status) xline(2000)
tabstat measles_cases
clear
use measles_cases
tabstat measles
clear
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
merge 1:1 iso_code year using population
keep if _merge == 3
drop _merge
merge 1:1 iso_code year using under14pop
drop _merge
merge 1:1 iso_code year using healthcarepercapita
drop _merge
merge 1:1 iso_code year using cases
drop _merge
X
use measles_cases
tabstat measles
tabstat measles_cases
merge 1:1 iso_code year using cases
drop _merge
merge 1:1 iso_code year using deaths_clean
drop _merge
merge 1:1 iso_code year using gdpcap
keep if _merge == 3
drop _merge
save master, replace
tabstat measles
tabstat measles_cases
clear
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
merge 1:1 iso_code year using population
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
save master, replace
clear
use master
tabstat measles_cases
egen sum_measlesvacc=rowtotal(countrymcv2 countrymcv1 unicefmcv2 unicefmcv1)
egen sum_dtpvacc=rowtotal(countrydtp3 countrydtp1 unicefdtp3 unicefdtp1)
drop if sum_dtpvacc == 0 & sum_measlesvacc == 0
tabstat measles_cases
clear
do formatting
tabstat measles_cases
sort gavi_status year 
by gavi_status: egen mean_measles = mean(measles_cases)
by gavi_status: egen dtp_measles = mean(dtp_cases)
graph twoway scatter mean_measles year, by(region) xline(2000)
graph twoway scatter mean_measles year, by(gavi_status) xline(2000)
tabstat measles_cases
drop gavi_mcv2
gen gavi_status = 0
replace gavi_status = 1 if ave_gni < 1580
do CreateVariables
tabstat measles_cases
clear
do CreateVariables
tabstat measles_cases
sort gavi_status year 
by gavi_status: egen mean_measles = mean(measles_cases)
by gavi_status: egen dtp_measles = mean(dtp_cases)
graph twoway scatter mean_measles year, by(gavi_status) xline(2000)
clear
do CreateVariables
graph twoway scatter mean_measles year, by(gavi_status) xline(2000)
list country if year < 2015
list country if year > 2015
list country if year < 1960
sort year country
graph twoway (scatter mean_measles year if year < 2015 & year > 1979), by(gavi_status) xline(2000)
gen measles_percent_pop = measles_cases/youngpop
graph twoway (scatter measles_percent_pop year if year < 2015 & year > 1979), by(gavi_status) xline(2000)
gen measles_percent_pop = measles_cases/youngpop
gen dtp_percent_pop = dtp_cases/youngpop
by gavi_status year: egen mean_measles_pop = mean(measles_percent_pop)
by gavi_status year: egen dtp_measles_pop = mean(dtp_percent_pop)
gen measles_percent_pop = measles_cases/youngpop
gen dtp_percent_pop = dtp_cases/youngpop
sort gavi_status year 
by gavi_status year: egen mean_measles_pop = mean(measles_percent_pop)
by gavi_status year: egen dtp_measles_pop = mean(dtp_percent_pop)
graph twoway (scatter mean_measles_pop year if year < 2015 & year > 1979), by(gavi_status) xline(2000)
graph twoway (scatter dtp_measles_pop year if year < 2015 & year > 1979), by(gavi_status) xline(2000)
replace mean_measles_pop = 100*mean_measles_pop 
graph twoway (scatter mean_measles_pop year if year < 2015 & year > 1979), by(gavi_status) xline(2000)
use "/Users/nicolegorton/Downloads/Data/aggenglish.dta", clear
use "/Users/nicolegorton/Downloads/Data/aggwage.dta"
clear
cd Desktop/data
cd Desktop\data
cd
cd Desktop/data
use completedata
clear
use finaldta
use finaldata
xtreg f.measles_cases unicefmcv1, fe cluster(pan_id)
sort country year
xtreg f.measles_cases unicefmcv1, fe cluster(pan_id)
xtreg f.measles_cases unicefmcv1, fe 
xtreg f.measles_cases unicefmcv1 if in_sample == 1, fe cluster(pan_id)
sort for time
sort country year
xtreg measles_cases unicefmcv1 if in_sample == 1, fe cluster(pan_id)
xtreg f.measles_cases unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg measles_cases unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg f1.measles_cases unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
drop if year < 1980
xtreg f1.measles_cases unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
clear
do FirstStageTake2
xtset
xtreg f1.measles_cases unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg f2.measles_cases unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg f3.measles_cases unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg f4.measles_cases unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg f.measles_deaths unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg f1.measles_deaths unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg f.mortality unicefmcv1 unicefmcv2 if in_sample == 1, fe cluster(pan_id)
xtreg f.mortality unicefmcv1 if in_sample == 1, fe cluster(pan_id)
xtreg f.mortality unicefmcv1 gdpcap if in_sample == 1, fe cluster(pan_id)
xtreg f.mortality unicefmcv1 loghealthcare if in_sample == 1, fe cluster(pan_id)
xtreg f.mortality unicefmcv1 loghealthcare i.year if in_sample == 1, fe cluster(pan_id)
xtreg f.mortality unicefmcv1 gdpcap i.year if in_sample == 1, fe cluster(pan_id)
graph twoway (line some_primary year if low == 1)(line measles_cases year if low == 1)
graph twoway (line some_primary year if low == 1 & year > 1980)(line measles_cases year if low == 1 & year > 1980)
graph twoway (scatter some_primary year if low == 1 & year > 1980)(scatter measles_cases year if low == 1 & year > 1980)
graph twoway (scatter some_primary measles_cases if low == 1 & year > 1980)
graph twoway (scatter measles_cases some_primary if low == 1 & year > 1980)
xtreg f2.mortality unicefmcv1 gdpcap i.year if in_sample == 1, fe cluster(pan_id)
xtreg f2.mortality unicefmcv1 gdpcap low i.year if in_sample == 1, fe cluster(pan_id)
xtreg f1.measles_deaths unicefmcv1 gdpcap low i.year if in_sample == 1, fe cluster(pan_id)
xtreg f2.mortality ilow#unicefmcv1 gdpcap low i.year if in_sample == 1, fe cluster(pan_id)
xtreg f2.mortality i.low#unicefmcv1 gdpcap low i.year if in_sample == 1, fe cluster(pan_id)
sum low
gen measles_covered = 0 
replace measles_covered = 1 if unicefmcv1 > 90
xtreg f1.measles_deaths measles_covered gdpcap i.year if in_sample == 1, fe cluster(pan_id)
xtreg f1.measles_deaths measles_covered#unicefmcv1 gdpcap i.year if in_sample == 1, fe cluster(pan_id)
xtreg f1.measles_deaths i.measles_covered#c.unicefmcv1 gdpcap i.year if in_sample == 1, fe cluster(pan_id)
gen dtp_covered = 0 
replace dtp_covered = 1 if unicefdtp1 > 90
xtreg f.mortality i.measles_covered#i.dtp_covered  gdpcap i.year if in_sample == 1, fe cluster(pan_id)
ivreg some_primary (mortality = unicefmcv1) gdppercap i.year, fe
ivreg some_primary (mortality = unicefmcv1) gdpcap i.year, fe
ivreg some_primary (mortality = unicefmcv1) gdpcap , fe
ivreg some_primary (mortality = unicefmcv1) gdpcap i.year, fext
xtivreg some_primary (mortality = unicefmcv1) gdpcap i.year, fe
if gavi_status == 1xtivreg some_primary (mortality = unicefmcv1) healthcare i.year, fe
if gavi_status == 1 xtivreg some_primary (mortality = unicefmcv1) healthcare i.year, fe
xtivreg some_primary healthcare i.year (mortality = unicefmcv1) if gavi_status == 1 , fe
xtivreg some_primary i.year (mortality = unicefmcv1) if gavi_status == 1 , fe
xtivreg some_primary i.year (measles_deaths = unicefmcv1) if gavi_status == 1 , fe
xtivreg some_primary i.year (mortality = unicefmcv1) if gavi_status == 0 , fe
xtivreg f5.some_primary i.year (mortality = unicefmcv1) if gavi_status == 1 , fe
xtivreg f10.some_primary i.year (mortality = unicefmcv1) if gavi_status == 1 , fe
xtivreg some_primary yr28 yr48 (mortality = unicefmcv1) if gavi_status == 1 &(year == 1985 | year == 2005) , fe
xtivreg some_primary yr28 yr48 (mortality = unicefdtp1) if gavi_status == 1 &(year == 1985 | year == 2005) , fe
xtivreg some_primary yr23 yr48 (mortality = unicefdtp1) if gavi_status == 1 &(year == 1980 | year == 2005) , fe
xtivreg some_primary yr23 yr53 (mortality = unicefdtp1) if gavi_status == 1 &(year == 1980 | year == 2010) , fe
xtivreg some_primary yr23 yr53 (mortality = unicefdtp1) if gavi_status == 0 &(year == 1980 | year == 2010) , fe
xtivreg lp yr23 yr53 (mortality = unicefdtp1) if gavi_status == 0 &(year == 1980 | year == 2010) , fe
xtivreg lp yr23 yr53 (mortality = unicefdtp1) if gavi_status == 1 &(year == 1980 | year == 2010) , fe
xtivreg some_primary (mortality = unicefdtp1) if gavi_status == 1 & (year == 1980 | year == 2010) , fe
xtivreg some_primary (mortality = unicefdtp1) if gavi_status == 1 & (year == 1980 | year == 2010) , fe cluster(pan_id)
xtivreg some_primary (mortality = unicefdtp1) if gavi_status == 1 & (year == 1980 | year == 2010) , fe vcecluster(pan_id)
xtivreg f.some_primary (mortality = unicefdtp1) if gavi_status == 1 & (year == 1980 | year == 2010) , fe
xtivreg f.some_primary (mortality = unicefdtp1) if gavi_status == 1, fe
