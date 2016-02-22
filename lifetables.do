clear

insheet using lifetablesM.csv, comma names 
save lifetables, replace

rename agegroup lifetablesage
 
merge m:1 code year using finaldata

X

estpost tabstat survival_prob_lifetables if gavi_status_00, by(lifetablesage) statistics(max min mean sd) listwise
esttab using lifetables.tex, replace main(mean) aux(sd) nostar unstack noobs nomtitle nonumber booktabs addnote("note")  eqlabels(`e(labels)') cells("mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))")  




keep if sex == "MLE"

drop if missing(country)

keep if agegroup == "AGE5-9"

rename displayvalue fivetoninemort

drop agegroup sex 

save fivetoninemort, replace

use lifetables, clear

keep if sex == "MLE"

drop if missing(country)

keep if agegroup == "AGELT1"

rename displayvalue underonemort

drop agegroup sex 

save underonemort, replace

use lifetables, clear

keep if sex == "MLE"

drop if missing(country)

keep if agegroup == "AGE10-14"

rename displayvalue tentofourteenmort

drop agegroup sex 

save tentofourteenmort, replace

use lifetables, clear

keep if sex == "MLE"

drop if missing(country)

keep if agegroup == "AGE1-4"

rename displayvalue onetofourmort

drop agegroup sex 

save onetofourmort, replace

merge m:1 country year using tentofourteenmort
drop _merge
merge m:m country year using underonemort
drop _merge
merge m:m country year using fivetoninemort
drop _merge

rename country code

order underonemort, first
order tentofourteenmort, last
order fivetoninemort, before (tentofourteenmort)

save lifetables_merged, replace

X

merge 1:1 code year using finaldata
drop _merge

label variable underonemort "Probability of Death Under 1 year"
 
label variable tentofourteenmort "Probability of Death 10-14yrs"
label variable fivetoninemort "Probability of Death 5-9yrs"
label variable onetofourmort "Probability of Death 1-4yrs"

keep if gavi_status_00 == 1
		
estpost tabstat underonemort onetofourmort fivetoninemort tentofourteenmort, statistics(mean sd max min) columns(statistics)

esttab using tables.tex, replace main(mean) aux(sd) nostar unstack noobs nomtitle nonumber addnote("note")  eqlabels(`e(labels)') cells("mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))")  


* Complete Life Tables Data

clear

insheet using formatted_lifetables.csv, comma names

rename value probability_death
drop v1
drop variable

bysort country year: egen youngmort = sum(probability_death) if ageid == 2 | ageid == 3
rename country code
keep if ageid == 2
drop if missing(youngmort)
drop agegroup ageid probability_death

quietly by code year:  gen dup = cond(_N==1,0,_n)

drop if dup == 2
drop dup 

replace code = "TMP" if code == "TLS"
replace code = "ADO" if code == "AND"

save youngmort_WHO, replace 
