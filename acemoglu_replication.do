]use finaldata, clear

*Table 2: OLS estimates*

*Panel A log population*

*whole sample
xtreg  logpop loglifeexpect yr1 yr9 if (year==1960 | year==2000), fe vce(cluster country)
outreg2 using myreg.tex, replace ctitle(All Countries) label nocons bracket  addstat(Number of Countries, e(N_clust)) 

*poor countries
xtreg  logpop loglifeexpect yr1 yr9 if (year==1960 | year==2000 & low == 1), fe vce(cluster country)
outreg2 using myreg.tex, append ctitle(Low income Countries) label nocons bracket addstat(Number of Countries, e(N_clust))
*medium countries*
xtreg  logpop loglifeexpect yr1 yr9 if (year==1960 | year==2000 & lowmid == 1), fe vce(cluster country)
outreg2 using myreg.tex, append ctitle(Lower-Middle Income Countries) label nocons bracket addstat(Number of Countries, e(N_clust)) 

*rich countries*
xtreg  logpop loglifeexpect yr1 yr9 if (year==1960 | year==2000 & rich == 1), fe vce(cluster country)
outreg2 using myreg.tex, append ctitle(Rich Countries) label nocons bracket addstat(Number of Countries, e(N_clust)) 


*Panel B Population under 14*
gen log_youngpop = log(youngpop)

*whole sample
xtreg  log_youngpop loglifeexpect yr1 yr7 if (year==1960 | year==2000), fe vce(cluster category)

*poor countries*
xtreg  log_youngpop loglifeexpect yr1 yr7 if (year==1960 | year==2000 & poor == 1), fe vce(cluster pan_id)

*medium countries*
xtreg  log_youngpop loglifeexpect yr1 yr7 if (year==1960 | year==2000 & medium == 1), fe vce(cluster pan_id)

*rich countries*
xtreg  log_youngpop loglifeexpect yr1 yr7 if (year==1960 | year==2000 & rich == 1), fe vce(cluster pan_id)

*Table 3: OLS estimates*

*Panel A log GNI per capita*

gen loggni = log(gni)

*whole sample
xtreg  loggni loglifeexpect yr1 yr7 if (year==1960 | year==2000), fe vce(cluster pan_id)

*poor countries*
xtreg  loggni loglifeexpect yr1 yr7 if (year==1960 | year==2000 & poor == 1), fe vce(cluster pan_id)

*medium countries*
xtreg  loggni loglifeexpect yr1 yr7 if (year==1960 | year==2000 & medium == 1), fe vce(cluster pan_id)

*rich countries*
xtreg  loggni loglifeexpect yr1 yr7 if (year==1960 | year==2000 & rich == 1), fe vce(cluster pan_id)

*also done for log GDP and log GDP per working age pop*

*Table 4: affect of interventions*
