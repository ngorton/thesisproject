keep if (year == 1980 | year == 2010 | year == 1990 | year == 2000 | year == 1985 | year == 1995 | year == 2005  )

// OLS

eststo clear
xtset pan_id year

eststo: xtreg interpolated_school loglifeexpect i.year loggdpcap logpop fertility liberties, fe robust cluster(pan_id)
estadd local sample "Full Sample"
estadd local yrs  "Decades"

eststo: xtreg interpolated_school loglifeexpect i.year loggdpcap logpop fertility liberties if in_sample == 1 &  gavi_status_ == 1, fe robust cluster(pan_id)
estadd local sample "GAVI Sample"
estadd local yrs  "Decades"

eststo:  xtreg interpolated_school survival_rate i.year loggdpcap logpop fertility liberties, fe robust cluster(pan_id)
estadd local sample "Full Sample"
estadd local yrs  "Decades"

eststo:  xtreg interpolated_school survival_rate i.year loggdpcap logpop fertility liberties if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local sample "GAVI Sample"
estadd local yrs  "Decades"


esttab using LongDiffOLSAdult.tex, replace indicate("Year FE = *.year") label booktabs scalars("sample Sample" "yrs Years") title("OLS Estimates") se r2 noconstant compress nobaselevels 

// Primary Specfication First Stage 

eststo clear
eststo: xtreg survival_rate weighted_vaccine_avg_efficacy i.year loggdpcap logpop  if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
estadd local yrs  "Decades"
estadd local group  "Children"

eststo: xtreg survival_rate weighted_vaccine_avg_efficacy i.year loggdpcap logpop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"
estadd local group  "Children"

 eststo: xtreg loglifeexpect weighted_vaccine_avg_efficacy i.year loggdpcap logpop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"
estadd local group  "Adults"

eststo: xtreg loglifeexpect weighted_vaccine_avg_efficacy i.year loggdpcap logpop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"
estadd local group  "Adults"

esttab using LongDiffPrimaryFSAdult.tex, replace indicate("Year FE = *.year") label booktabs scalars("yrs Years") title("Primary Specification First Stage") se r2 noconstant compress nobaselevels 


// Primary Specifciation Direct Effect

eststo clear
 
eststo: xtreg interpolated_school weighted_vaccine_avg_efficacy i.year loggdpcap logpop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"

eststo: xtreg interpolated_school weighted_vaccine_avg_efficacy i.year loggdpcap logpop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"
 
eststo: xtreg logpop weighted_vaccine_avg_efficacy survival_rate i.year loggdpcap fertility liberties if in_sample == 1 &  gavi_status_ == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"

eststo: xtreg loggdpcap weighted_vaccine_avg_efficacy survival_rate i.year logpop fertility liberties if in_sample == 1 &  gavi_status_ == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"

esttab using LongDiffPrimaryDEAdult.tex, replace indicate("Year FE = *.year" ) label booktabs scalars("yrs Years") title("Primary Specification Direct Effects") se r2 noconstant compress nobaselevels 

// Primary Specification IV 


eststo: xtivreg interpolated_school i.year loggdpcap logpop liberties fertility (loglifeexpect = weighted_vaccine_avg_efficacy) if in_sample == 1 & gavi_status_00 == 1, fe 
estadd local yrs  "Decades"
estadd local group  "Adults"

eststo: xtivreg interpolated_school  i.year gdpcap (loglifeexpect  = weighted_vaccine_avg_efficacy) if in_sample == 1 & gavi_status_00 == 1, fe 
estadd local yrs  "Decades"
estadd local group  "Adults"

eststo: xtivreg interpolated_school  i.year loggdpcap logpop liberties fertility (survival_rate = weighted_vaccine_avg_efficacy) if in_sample == 1 & gavi_status_00 == 1, fe 
estadd local yrs  "Decades"
estadd local group  "Children"

eststo: xtivreg interpolated_school i.year gdpcap (survival_rate = weighted_vaccine_avg_efficacy) if in_sample == 1 & gavi_status_00 == 1, fe 
estadd local yrs  "Decades"
estadd local group  "Children"

esttab using LongDiffPrimaryIVAdult.tex, replace indicate("Year FE = *.year") label booktabs scalars("yrs Years" "group Group") title("Primary Specification IV Estimates") se r2 noconstant compress nobaselevels 

// Non Linear Vaccine Coverage

mkspline vax1 30 vax2 60 vax3 80 vax4 = weighted_vaccine_avg_efficacy

eststo clear
eststo: quietly xtreg survival_rate  vax1-vax4  i.year loggdpcap logpop liberties fertility if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"
 
eststo: quietly  xtreg loglifeexpect  vax1-vax4  i.year loggdpcap logpop liberties fertility if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"

eststo: quietly  xtreg interpolated_school vax1-vax4 i.year loggdpcap logpop liberties fertility if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"

eststo: quietly xtivreg interpolated_school loggdpcap logpop liberties fertility i.year (survival_rate = vax1-vax4 )  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe
 estadd local yrs  "Decades"
 
eststo: quietly xtivreg interpolated_school loggdpcap logpop liberties fertility i.year (survival_rate = vax1-vax4 )  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe
 estadd local yrs  "Decades"

 esttab using LongDiffSplines.tex, replace indicate("Year FE = *.year" ) label booktabs scalars("yrs Years") mtitle("FS" "FS" "DE" "IV" "IV")  title("Non-Linearity, Long Differences") se r2 noconstant compress nobaselevels 

// What Drives changes in life expectancy? 
eststo clear

eststo: quietly  xtreg loglifeexpect infantmort adultmort young_mort i.year loggdpcap logpop fertility  if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly  xtreg loglifeexpect infantmort adultmort i.year loggdpcap logpop fertility  if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)

eststo: quietly  xtreg loglifeexpect infantmort adultmort young_mort i.year loggdpcap logpop fertility, fe robust cluster(pan_id)

esttab using LifeExpect.tex, replace indicate("Year FE = *.year") title("What Drives Changes in Life Expectancy?") label booktabs mtitle("GAVI" "GAVI" "All") se r2 noconstant compress nobaselevels 

// Affect on growth outcomes 
eststo clear
eststo: quietly xtivreg loggdpcap logpop liberties fertility i.year (survival_rate = weighted_vaccine_avg_eff)  if in_sample == 1 & gavi_status_00 == 1, fe
eststo: quietly xtivreg fertility loggdpcap logpop liberties i.year (survival_rate = weighted_vaccine_avg_eff)  if in_sample == 1 & gavi_status_00 == 1, fe
eststo: xtivreg logpop loggdpcap  liberties i.year (survival_rate = weighted_vaccine_avg_eff)  if in_sample == 1 & gavi_status_00 == 1, fe
  
eststo: quietly xtivreg loggdpcap logpop liberties fertility i.year (loglifeexpect = weighted_vaccine_avg_eff)  if in_sample == 1 & gavi_status_00 == 1, fe
eststo: quietly xtivreg fertility loggdpcap logpop liberties i.year (loglifeexpect = weighted_vaccine_avg_eff)  if in_sample == 1 & gavi_status_00 == 1, fe
eststo: quietly xtivreg logpop loggdpcap  liberties i.year (loglifeexpect = weighted_vaccine_avg_eff)  if in_sample == 1 & gavi_status_00 == 1, fe
  
  
  xtreg logpop weighted_vaccine_avg_efficacy i.year loggdpcap fertility liberties if in_sample == 1 &  gavi_status_ == 1, fe robust cluster(pan_id)
  xtreg loggdpcap weighted_vaccine_avg_efficacy i.year logpop fertility liberties if in_sample == 1 &  gavi_status_ == 1, fe robust cluster(pan_id)
  
esttab using GrowthOutcomes.tex, replace indicate("Year FE = *.year") title("Non-Human Capital Growth Outcomes")  label booktabs se r2 noconstant compress nobaselevels 

// Considering heterogeneity  -- region effects, no country FE 
eststo clear

eststo: quietly ivregress 2sls interpolated_school (survival_rate  = weighted_vaccine_avg_eff) loggdpcap logpop fertility liberties i.year i.region if gavi_status_00 == 1 
 estadd local reg  "All"

eststo: quietly ivregress 2sls interpolated_school (survival_rate  = weighted_vaccine_avg_eff) loggdpcap logpop fertility liberties i.year if gavi_status_00 == 1 & (region_code == "Sub-Saharan Africa")
 estadd local reg  "Sub-Saharan Africa"

eststo: quietly ivregress 2sls interpolated_school (survival_rate  = weighted_vaccine_avg_eff) loggdpcap logpop fertility liberties i.year if gavi_status_00 == 1 & (region_code == "South Asia")
 estadd local reg  "South Asia"

eststo: quietly ivregress 2sls interpolated_school (survival_rate  = weighted_vaccine_avg_eff) loggdpcap logpop fertility liberties i.year i.region if gavi_status_00 == 1 & (region_code == "Middle East & North Africa" | region_code == "South Asia")
 estadd local reg  "South Asia + Middle East"

esttab using Heterogeneity.tex, replace indicate("Year FE = *.year") title("Region-Specific Effects")  label booktabs se r2 noconstant compress nobaselevels 


//other stuffs

xtregar f20.logschool survival_rate loggdpcap logpop fertility liberties yr1-yr58 if in_sample == 1 & gavi_status_00 == 1, fe


