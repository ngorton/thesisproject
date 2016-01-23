clear

use finaldata

local countryfe
local countrycount
local timefe

by low, sort: gen low_nvals = _n == 1
count if low_nvals

*Instrument Tests*
*Measles Estimates*

eststo clear

eststo: quietly xtreg mortality unicefmcv1 yr5-yr9, fe cluster(pan_id)

eststo: quietly xtreg mortality unicefmcv1 yr5-yr9 if(low == 1), fe cluster(pan_id)

eststo: quietly xtreg mortality unicefmcv1 yr5-yr9 if(high == 1), fe cluster(pan_id)

esttab using test3.tex, replace se ar2 label star booktabs keep(unicefmcv1) wrap compress title(First Stage Estimates: MCV1 Coverage and Child Mortality) nogaps mtitles("Entire Sample" "Low Income" "High Income")

*DTP Estimates*

eststo clear

eststo: quietly xtreg mortality unicefdtp1 yr5-yr9, fe cluster(pan_id)

eststo: quietly xtreg mortality unicefdtp1 yr5-yr9 if(low == 1), fe cluster(pan_id)

eststo: quietly xtreg mortality unicefdtp1 yr5-yr9 if(high == 1), fe cluster(pan_id)

esttab using test3.tex, append se ar2 label star booktabs keep(unicefdtp1) wrap compress title(First Stage Estimates: DTP1 Coverage and Child Mortality) nogaps mtitles("Entire Sample" "Low Income" "High Income")

*Polio Estimates*

eststo clear

eststo: quietly xtreg mortality unicefpol3 yr5-yr9, fe cluster(pan_id)

eststo: quietly xtreg mortality unicefpol3 yr5-yr9 if(low == 1), fe cluster(pan_id)

eststo: quietly xtreg mortality unicefpol3 yr5-yr9 if(high == 1), fe cluster(pan_id)

esttab using test3.tex, append se ar2 label star booktabs keep(unicefpol3) wrap compress title(First Stage Estimates: Polio Coverage and Child Mortality) nogaps mtitles("Entire Sample" "Low Income" "High Income")


*OLS Estimates*

gen mortality_lag = mortality[_n-1]
gen mortality_lead = mortality[_n+1]
gen logyoungpop = log(youngpop)

label variable mortality_lag "Mortality, Lagged by 5 years"
label variable logyoungpop "Log of Population Under 14"

eststo clear

eststo: quietly xtreg some_primary mortality yr5-yr9, fe robust

eststo: quietly xtreg some_primary mortality yr5-yr9 if(low == 1), fe robust

eststo: quietly xtreg some_primary mortality yr5-yr9 if(high == 1), fe robust

estadd local e(N_clust) = count pan_id

esttab using test3.tex, append se ar2 label star booktabs keep(mortality) wrap compress title(OLS Estimates: Child Mortality and Primary School Enrollment) nogaps mtitles("Entire Sample"  "Low Income" "High Income")



