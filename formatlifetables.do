insheet using PlotLifeTables.csv, comma names

keep if sex == "MLE"

drop sex

replace agegroup = "AGE0" if agegroup == "AGELT1"

replace agegroup = "AGEZ100" if agegroup == "AGE100PLUS"

encode agegrou, gen(age)

gen survival_rate = (1-displayvalue)*100


graph twoway scatter survival_rate age if (country == "SLE") & agegroup < "AGE50-54", by(country) xlabel(1 "<1" 2 "1-4" 3 "5-9" 4 "10-14" 5 "15-19" 6 "20-24" 7 "25-29" 8 "30-34" 9 "35-39" 10 "40-44" 11 "45-49" 12 "50-54", alternate) 


graph twoway scatter survival_rate age if (country == "SLE") & year == 2000 & agegroup < "AGE50-54", xline(3) xlabel(1 "<1" 2 "1-4" 3 "5-9" 4 "10-14" 5 "15-19" 6 "20-24" 7 "25-29" 8 "30-34" 9 "35-39" 10 "40-44" 11 "45-49" 12 "50-54", alternate) xtitle("") ytitle("Age Specific Survival Rate")
