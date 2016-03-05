
// Only keep certain years

keep if (year == 1980 | year == 2010 | year == 1990 | year == 2000 | year == 2010)

gen young_mort = mortality-infantmort
gen young_survive = (1 - young_mort/1000)*100
gen adult_survive = (1 - adultmort/1000)*100



// OLS

eststo clear
xtset

eststo: xtreg interpolated_school survival_rate i.year gdpcap pop fertility liberties if in_sample == 1, fe robust cluster(pan_id)
estadd local sample "Full Sample"
estadd local yrs  "Decades"

eststo:  xtreg interpolated_school survival_rate i.year gdpcap pop fertility liberties if gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local sample "GAVI, All"
estadd local yrs  "Decades"

eststo:  xtreg interpolated_school survival_rate i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local sample "GAVI, Base Sample"
estadd local yrs  "Decades"

eststo:  xtreg interpolated_school survival_rate i.year gdpcap pop fertility liberties if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local sample "GAVI, Base Sample"
estadd local yrs  "Decades"

eststo:  xtreg interpolated_school survival_rate i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local sample "GAVI, Base Sample"
estadd local yrs  "Decades"

esttab using LongDiffOLS.tex, replace indicate("Year FE = *.year" "Controls = pop gdpcap") label booktabs scalars("sample Sample" "yrs Years") title("OLS Long Differences") se r2 noconstant compress nobaselevels 

// Primary Specification - First Stage 
eststo clear
eststo: xtreg survival_rate unicefmcv1 i.year gdpcap pop liberties fertility if in_sample == 1 & gavi_status_00 == 1 , fe robust cluster(pan_id)
estadd local yrs  "Decades"
 
eststo: xtreg survival_rate unicefdtp1 i.year gdpcap pop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"
 
eststo: xtreg young_survive unicefmcv1 i.year gdpcap pop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"
 
eststo: xtreg young_survive unicefdtp1 i.year gdpcap pop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"
esttab using LongDiffPrimaryFS.tex, replace indicate("Year FE = *.year" "Controls = pop gdpcap") label booktabs scalars("yrs Years") title("Primary Specification Reduced Form") se r2 noconstant compress nobaselevels 


// Primary Specification -- Direct Effect/Reduced Form
eststo clear
eststo: xtreg interpolated_school unicefmcv1 i.year gdpcap pop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"

eststo: xtreg interpolated_school unicefdtp1 i.year gdpcap pop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "Decades"

clear
use finaldata
keep if (year == 1980 | year == 2010 | year == 1990 | year == 2000 | year == 2010 | year == 1985 | year == 1995 | year == 2005)

eststo: xtreg interpolated_school unicefmcv1 i.year gdpcap pop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "5-years"

eststo: xtreg interpolated_school unicefdtp1 i.year gdpcap pop liberties fertility if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
estadd local yrs  "5-years"

* Maybe I should use Cochrane Orcutt to estimate the direct affects -- should be much faster than 10 years
esttab using LongDiffPrimaryDE.tex, replace indicate("Year FE = *.year" "Controls = pop gdpcap") label booktabs scalars("yrs Years") title("Primary Specification Direct Effect") se r2 noconstant compress nobaselevels 


// Primary Specification -- IV 

eststo clear

eststo: xtivreg interpolated_school gdpcap pop liberties fertility i.year (survival_rate = unicefmcv1)  if in_sample == 1 & gavi_status_00 == 1  & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2010), fe
estadd local yrs  "5-years"

eststo: xtivreg interpolated_school gdpcap pop liberties fertility i.year (survival_rate = unicefdtp1)  if in_sample == 1 & gavi_status_00 == 1  & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2010), fe
estadd local yrs  "5-years"

clear
use finaldata
keep if (year == 1980 | year == 2010 | year == 1990 | year == 2000 | year == 2010)

eststo: xtivreg interpolated_school gdpcap pop liberties fertility i.year (survival_rate = unicefmcv1)  if in_sample == 1 & gavi_status_00 == 1  & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2010), fe
estadd local yrs  "Decades"

eststo: xtivreg interpolated_school gdpcap pop liberties fertility i.year (survival_rate = unicefdtp1)  if in_sample == 1 & gavi_status_00 == 1  & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2010), fe
estadd local yrs  "Decades"



esttab using LongDiffPrimaryIV.tex, replace indicate("Year FE = *.year" "Controls = pop gdpcap") label mtitle("FS" "FS" "FS" "DE" "DE" "DE" "IV" "IV" "IV" "IV") booktabs scalars("yrs Years" "fert Fertility?") title("Primary Specification Long Differences") se r2 noconstant compress nobaselevels 

