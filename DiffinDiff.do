xtivreg2 logschool loggdpcap logpop fertility liberties yr23-yr58  (survival_rate = covered) if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)  




change after threshold reached for measles, t+1 to t+6 


bysort iso_code year: gen treated = (unicefmcv1 > 89)
bysort iso_code: gen year_covered = year if (mcv1_covered[_n-1] == 0 & mcv1_covered[_n] == 1) 
replace year_covered = year_covered[_n-1] if missing(year_covered)


gen test_year = f6.year_covered if !missing(year_covered)
gen 

gen change_school = final_school - initial_school

gen initial_school_not = interpolated_school  if missing(year_covered)

bysort iso_code: gen treatedyear = (year_covered >= year & year_covered != 0)

reg logschool treatedyear treated

gen changeschool = f6.logschool - logschool

gen linear_changeschool = f10.interpolated_school - interpolated_school
