*** Autocorrelation Robustness *** 
// First Stage

eststo clear

eststo: quietly xtabond survival_rate  weighted_vaccine_avg_eff loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtgls survival_rate  weighted_vaccine_avg_eff loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
estadd local est  "AR(1)"

eststo: quietly xtreg survival_rate weighted_vaccine_avg_eff i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local est  "Long Diff."

*esttab using Autocorr1.tex, replace keep(weighted_vaccine_avg_efficacy) label booktabs scalars("est Estimator") title("Further Autocorrelation Tests") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 


*eststo clear


eststo: quietly xtabond survival_rate vax1-vax4 loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtgls survival_rate vax1-vax4 loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
estadd local est  "AR(1)"

eststo: quietly xtreg survival_rate vax1-vax4 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local est  "Long Diff."


eststo: quietly xtabond loglifeexpect weighted_vaccine_avg_eff loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtgls loglifeexpect  weighted_vaccine_avg_eff loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
estadd local est  "AR(1)"

eststo: quietly xtreg loglifeexpect weighted_vaccine_avg_eff i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local est  "Long Diff."


eststo: quietly xtabond loglifeexpect vax1-vax4 loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtgls loglifeexpect  vax1-vax4 loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1, corr(ar1) panels(heteroskedastic)  force
estadd local est  "AR(1)"

eststo: quietly xtreg loglifeexpect vax1-vax4 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local est  "Long Diff."

esttab using Autocorro2.tex, replace keep( weighted_vaccine_avg_efficacy  vax1 vax2 vax3 vax4) label booktabs scalars("est Estimator") title("Further Autocorrelation Tests") se r2 noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 


X
*** Reduced Form *** 

eststo clear

gen f5enrollment = f5.enrollment
gen f6enrollment = f6.enrollment
gen f7enrollment = f7.enrollment
gen f10enrollment = f10.enrollment



eststo: quietly xtabond f5enrollment  weighted_vaccine_avg_eff loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtabond f6enrollment  weighted_vaccine_avg_eff loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtabond f7enrollment  weighted_vaccine_avg_eff loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtabond f10enrollment  weighted_vaccine_avg_eff loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtreg enrollment weighted_vaccine_avg_eff i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local est  "Long Diff."

eststo: quietly xtabond f5enrollment vax1-vax4 loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"


eststo: quietly xtabond f6enrollment vax1-vax4 loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"


eststo: quietly xtabond f7enrollment vax1-vax4 loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"


eststo: quietly xtabond f10enrollment vax1-vax4 loggdpcap logpop fertility liberties yr23-yr58 pan_id1-pan_id217  if in_sample == 1 & gavi_status_00 == 1
estadd local est  "A+B"

eststo: quietly xtreg enrollment vax1-vax4 i.year gdpcap pop if in_sample == 1 & gavi_status_00 == 1 & (year == 1980 | year == 1990 | year == 2000 | year == 2012), fe robust cluster(pan_id)
estadd local est  "Long Diff."

esttab using Autocorrcomplete.tex, replace fragment keep(weighted_vaccine_avg_efficacy vax1 vax2 vax3 vax4) label booktabs scalars("est Estimator") title("Further Autocorrelation Tests") se noconstant compress nobaselevels star(+ 0.10 * 0.05 ** 0.01 *** 0.001) 
