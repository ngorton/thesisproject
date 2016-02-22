// Same Regressions, but this time EVERYTHING IS IN LONG DIFFERENCES! 

// OLS

eststo clear

xtset

eststo: xtreg interpolated_school survival_rate i.year gdpcap pop if in_sample == 1 & (year == 1980 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "1980, 2012"
 estadd local sample "Full Sample"
 
  
 eststo:  xtreg interpolated_school survival_rate i.year gdpcap pop if in_sample == 1 &  (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local yrs  "5 years"
 estadd local sample "Full Sample"
 
 
eststo: xtreg interpolated_school survival_rate i.year gdpcap pop if gavi_status_00 == 0 & in_sample == 1 & (year == 1980 | year == 2012), fe robust cluster(pan_id)
estadd local yrs "1980, 2012"
estadd local sample "All Non-GC"

eststo: xtreg interpolated_school l10.survival_rate i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"
 estadd local sample "In-Sample GC"
 
eststo: xtreg interpolated_school l5.survival_rate i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local yrs  "Decades"
 estadd local sample "In-Sample GC"
 
 eststo:  xtreg interpolated_school survival_rate i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local yrs  "5 years"
 estadd local sample "In-Sample GC"

esttab using LongDiffOLS.tex, replace indicate("Year FE = *.year" "Controls = pop gdpcap") label booktabs scalars("sample Sample" "yrs Years") title("OLS Long Differences") se r2 noconstant compress nobaselevels 

// Primary Specification  -- now, only using base sample GC
eststo clear
eststo: xtreg survival_rate l1.unicefmcv1 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"

eststo: xtreg survival_rate l2.unicefmcv1 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"

eststo: xtreg interpolated_school l1.unicefmcv1 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"
 
 eststo: xtreg interpolated_school l1.unicefmcv1 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "5-years"
 
eststo:  xtreg interpolated_school l2.unicefmcv1 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"

eststo: xtivreg interpolated_school gdpcap pop i.year (survival_rate = l1.unicefmcv1)  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe
   
estadd local yrs  "Decades"

eststo: xtivreg interpolated_school i.year gdpcap pop (l5.survival_rate = l1.unicefmcv1) if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe 
estadd local yrs  "5-yrs"


esttab using LongDiffPrimary.tex, replace indicate("Year FE = *.year" "Controls = pop gdpcap") label mtitle("FS" "FS" "RF" "RF" "RF" "IV" "IV") booktabs scalars("yrs Years") title("Primary Specification Long Differences") se r2 noconstant compress nobaselevels 

// Secondary Specification 
eststo clear
eststo: xtreg survival_rate  c.l1.unicefmcv1 c.l1.unicefmcv1#i.l.not_mcv_covered  i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "5-years"

eststo: xtreg survival_rate  c.l1.unicefmcv1 c.l1.unicefmcv1#i.l.not_mcv_covered  i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"
 
 eststo: xtreg survival_rate  c.l2.unicefmcv1 c.l2.unicefmcv1#i.l2.not_mcv_covered  i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "5-years"

eststo: xtreg survival_rate  c.l2.unicefmcv1 c.l2.unicefmcv1#i.l2.not_mcv_covered i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"

eststo: xtreg interpolated_school c.l1.unicefmcv1  c.l1.unicefmcv1#i.l.not_mcv_covered i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"
 
 eststo: xtreg interpolated_school c.l1.unicefmcv1  c.l1.unicefmcv1#i.l.not_mcv_covered  i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "5-years"

eststo: xtivreg interpolated_school gdpcap pop i.year (survival_rate = c.l1.unicefmcv1 c.l1.unicefmcv1#i.l.not_mcv_covered)  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe
 estadd local yrs  "Decades"
 
 eststo: xtivreg interpolated_school gdpcap pop i.year (l10.survival_rate = c.l.unicefmcv1 c.l.unicefmcv1#i.l.not_mcv_covered)  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe
 estadd local yrs  "5-years"
 
esttab using LongDiffSecondary.tex, replace indicate("Year FE = *.year" ) label booktabs scalars("yrs Years") mtitle("FS" "FS" "FS" "FS" "RF" "RF" "RF" "IV" "IV")  title("Secondary Specification Long Differences") se r2 noconstant compress nobaselevels 

// Non-linearity of vaccine coverage
mkspline mcv1 30 mcv2 60 mcv3 90 mcv4 = unicefmcv1
eststo clear
eststo: xtreg f.survival_rate  mcv1-mcv4  i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "5-years"
 
 eststo: xtreg f2.survival_rate  mcv1-mcv4  i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "5-years"

eststo: xtreg f4.interpolated_school mcv1-mcv4 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "Decades"
 
 eststo: xtreg f5.interpolated_school mcv1-mcv4  i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
 estadd local yrs  "5-years"

 eststo: xtivreg interpolated_school gdpcap pop i.year (f.survival_rate = mcv1-mcv4 )  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe
 estadd local yrs  "Decades"
 
 eststo: xtivreg interpolated_school gdpcap pop i.year (f2.survival_rate = mcv1-mcv4 )  if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1995 | year == 1985 | year == 2005| year == 2010 | year == 1990 | year == 2000 | year == 2012), fe
 estadd local yrs  "5-years"

 esttab using LongDiffSplines.tex, replace indicate("Year FE = *.year" ) label booktabs scalars("yrs Years") mtitle("FS" "FS" "RF" "RF" "IV" "IV")  title("Non-Linearity, Long Differences") se r2 noconstant compress nobaselevels 

 
 X

// Countries covering less than 90 % of their own immunization costs 
eststo clear
egen meanvaxspending = mean(vaxspending)
gen supported = (meanvaxspending < 90)

