*Manipulates Barro/Lee School Data*
*Date: January 2016*
*Author: Nicole Gorton*

use total_schooling

*schooling variables*
gen some_primary = 100 - lu
gen primary_completed = (lp * lpc)/100
gen secondary_completed = (ls * lsc)/100
gen tertiary_completed = (lh * lhc)/100

gen agegroup = 0

*group cohorts with constant values: cohort by year, which changes as people age out*
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

drop if agegroup > 11

*use average years of schooling by age group to figure out approximately what year schooling began*
*for x percentage that only completed primary schooling, would have begun school at age - average years of primary school*
*compute means*
egen avg_years_total = mean(yr_sch), by(agegroup country)
egen avg_years_primary = mean(yr_sch_pri), by(agegroup country)

*compute standard deviations*
egen sd_years_total = sd(yr_sch), by(agegroup country)
egen sd_years_primary = sd(yr_sch_pri), by(agegroup country)

*create a random variable based on average distribution of school years in data*
bys agegroup country: gen age_total = rnormal(avg_years_total, sd_years_total)
bys country year agegroup: gen average_age = (agefrom + ageto)/2 - age_total

*calculate year they began schooling*
*restrict to youngest cohort*
keep if agegroup == 1

drop if missing(lu)

save schooling_formatted, replace
