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
gen p = rnormal(0.5, 0.5) + 0.5
drop if p < 0 
drop if p > 1 
gen school_val = -f*(1-p)*a + (T-a)*high_wage
replace school_val = 0 if p = 0
gen noschool_val = a*low_wage*(1-p) + T*low_wage
replace noschool_val = 0 if p = 0


graph twoway (scatter school_val p)(scatter noschool_val p)

gen y = 0
replace y = 1 if school_val > noschool_val

*graph twoway (scatter y T)

label variable high_wage "Expected High Wage"
label variable low_wage "Low Wage"
label variable T "Life Expectancy"
label variable a "Duration of Childhood"
label variable f "Annual cost of schooling"
label variable school_val  "Lifetime Wages with Schooling"
label variable noschool_val "Lifetime Wages without schooling"
label variable p "Probability of Childhood Death"


twoway mspline school_val p, bands(5) 
twoway mspline school_val p, bands(5) 

