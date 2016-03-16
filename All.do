clear

use complete_data_with_state

*** Recoding: race, education *** 
** Recoding english speaking *** 
gen speakeng_well = (speakeng >= 3 & speakeng <= 5) 
gen speakeng_notwell = (speakeng == 1 | speakeng == 6) 
label variable speakeng_well "Speaks English Well"


** Recoding education ** 
*generate byte edcode=1*(educd<=50) + 2*(educd>=60 & educd<=64) + 3*(educd>=65 & educd<=90) + 4*(educd==100 | educd==101) + 5*(educd>=110)
** EducD < 50 means less than high school
** EducD between 60, 64 means some high school
** EducD between 65, 90 is some college
** EducD between 100, 101 is finished college
** EducD greater than 110 is more than college

** Recoding race ** 
gen white =(race == 1)
gen black =(race == 2)
gen asian =(race >=3 & race <= 6)
gen other =(race >6) 

** Recode variables **
gen sex_discrete = sex - 1
gen labforce_discrete = labforce - 1

label variable coh40 "<1950"
label variable coh50 "1950-1960"
label variable coh60 "1960-1964"
label variable coh65 "1965-1969"
label variable coh70 "1970-1974"
label variable coh75 "1975-1979"
label variable coh80 "1980-1984"
label variable coh85 "1985-1989"
label variable coh90 "1990-1994"
label variable coh95 "1995-1999"
label variable coh00 "2000-2004"
label variable coh05 "2005-2011"

** Recode marital status ** 
*gen married = (marst == 1 | marst == 2)
*gen unmarried = (marst > 2)


** Adding Controls for Skill Groups ** 
** First, create skill groups based on age and education categories (40 total - 8 age, 5 education) 
* From Borjas 2015: eight age brackets are given by 25–29, 30–34, 35–39, 40–44, 45–49, 50–54, 55–59, and 60–64
gen byte agecode = 1*(age >= 25 & age <= 29 ) + 2*(age >= 30 & age <= 34 ) + 3*(age >= 35 & age <= 39 ) + 4*(age >= 40 & age <= 44) + 5*(age >= 45 & age <= 49) + 6*(age >= 50 & age <= 54 ) + 7*(age >= 55 & age <= 59)+ 8*(age >= 60 & age <= 64)

** Generate group dummies 

gen skill1 = (agecode == 1 & edcode == 1)
gen skill2 = (agecode == 2 & edcode == 1)
gen skill3 = (agecode == 3 & edcode == 1)
gen skill4 = (agecode == 4 & edcode == 1)
gen skill5 = (agecode == 5 & edcode == 1)
gen skill6 = (agecode == 6 & edcode == 1)
gen skill7 = (agecode == 7 & edcode == 1)
gen skill8 = (agecode == 8 & edcode == 1)
gen skill9 = (agecode == 1 & edcode == 2)
gen skill10 = (agecode == 2 & edcode == 2)
gen skill11 = (agecode == 3 & edcode == 2)
gen skill12 = (agecode == 4 & edcode == 2)
gen skill13 = (agecode == 5 & edcode == 2)
gen skill14 = (agecode == 6 & edcode == 2)
gen skill15 = (agecode == 7 & edcode == 2)
gen skill16 = (agecode == 8 & edcode == 2)
gen skill17 = (agecode == 1 & edcode == 3)
gen skill18 = (agecode == 2 & edcode == 3)
gen skill19 = (agecode == 3 & edcode == 3)
gen skill20 = (agecode == 4 & edcode == 3)
gen skill21 = (agecode == 5 & edcode == 3)
gen skill22 = (agecode == 6 & edcode == 3)
gen skill23 = (agecode == 7 & edcode == 3)
gen skill24 = (agecode == 8 & edcode == 3)
gen skill25 = (agecode == 1 & edcode == 4)
gen skill26 = (agecode == 2 & edcode == 4)
gen skill27 = (agecode == 3 & edcode == 4)
gen skill28 = (agecode == 4 & edcode == 4)
gen skill29 = (agecode == 5 & edcode == 4)
gen skill30 = (agecode == 6 & edcode == 4)
gen skill31 = (agecode == 7 & edcode == 4)
gen skill32 = (agecode == 8 & edcode == 4)
gen skill33 = (agecode == 1 & edcode == 5)
gen skill34 = (agecode == 2 & edcode == 5)
gen skill35 = (agecode == 3 & edcode == 5)
gen skill36 = (agecode == 4 & edcode == 5)
gen skill37 = (agecode == 5 & edcode == 5)
gen skill38 = (agecode == 6 & edcode == 5)
gen skill39 = (agecode == 7 & edcode == 5)
gen skill40 = (agecode == 8 & edcode == 5)

** Adding Countrols for State of Residence
* Drop CT as baseline

tabulate stateicp, gen(state)  
label variable state1 "Connecticut"
label variable state2	"Maine"
label variable state3	"Massachusetts"
label variable state4	"New Hampshire"
label variable state5	"Rhode Island"
label variable state6	"Vermont"

label variable state7	"Delaware"
label variable state8	"New Jersey"
label variable state9	"New York"
label variable state10	"Pennsylvania"
label variable state11	"Illinois"
label variable state12	"Indiana"
label variable state13	"Michigan"
label variable state14	"Ohio"
label variable state15	"Wisconsin"
label variable state16	"Iowa"
label variable state17	"Kansas"
label variable state18	"Minnesota"
label variable state19	"Missouri"
label variable state20	"Nebraska"
label variable state21	"North Dakota"
label variable state22	"South Dakota"
label variable state23	"Virginia"
label variable state24	"Alabama"
label variable state25	"Arkansas"
label variable state26	"Florida"
label variable state27	"Georgia"
label variable state28	"Louisiana"
label variable state29	"Mississippi"
label variable state30	"North Carolina"
label variable state31	"South Carolina"
label variable state32	"Texas"
label variable state33	"Kentucky"
label variable state34	"Maryland"
label variable state35	"Oklahoma"
label variable state36	"Tennessee"
label variable state37	"West Virginia"
label variable state38	"Arizona"
label variable state39	"Colorado"
label variable state40	"Idaho"
label variable state41	"Montana"
label variable state42	"Nevada"
label variable state43	"New Mexico"
label variable state44	"Utah"
label variable state45	"Wyoming"
label variable state46	"California"
label variable state47	"Oregon"
label variable state48	"Washington"
label variable state49	"Alaska"
label variable state50	"Hawaii"
label variable state51	"District of Columbia"
label variable state52	"State not identified"


** Adding all controls

eststo clear 
eststo: reg lweekly age age2 age3 coh40-coh05 skill1-skill40 [aw=perwt] if sex == 2 & survey == 1970, cluster(cohort)

eststo: reg lweekly age age2 age3 coh40-coh05 black white asian skill1-skill40 speakeng_well  state2-state52  [aw=perwt] if sex == 2 & survey == 1980,  robust cluster(cohort)
eststo: reg lweekly age age2 age3 coh40-coh05  black white asian skill1-skill40 speakeng_well  state2-state52 [aw=perwt] if sex == 2 & survey == 1990,  robust cluster(cohort)
eststo: reg lweekly age age2 age3 coh40-coh05  black white asian skill1-skill40 speakeng_well  state2-state52  [aw=perwt] if sex == 2 & survey == 2000,  robust cluster(cohort)
eststo: reg lweekly age age2 age3 coh40-coh05  black white asian skill1-skill40 speakeng_well  state2-state52 [aw=perwt] if sex == 2 & survey == 2010,  robust cluster(cohort)

esttab using Table1F_all.tex, replace label booktabs title("Women, ") se r2 noconstant compress nobaselevels 



