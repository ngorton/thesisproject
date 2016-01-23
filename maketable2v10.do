*Creates Table 2: Life Expectancy, Population, Births, and Percentage of Population under 20: OLS Estimates
***********************************************************
clear
capture log close
log using maketable2, replace

/*Data Files Used
	disease
	
*Data Files Created as Final Product
	none
	
*Data Files Created as Intermediate Product
	none*/
	
use disease, clear

tsset ctry year

* Panel A log population

* col 1
xtreg  logmaddpop loglifeexpect yr1960 yr2000 if (year==1960 | year==2000) & allcountrypanel19602000==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2a, ti(z10tab2a) cti(1) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) replace

* col 2
xtreg  logmaddpop loglifeexpect yr1960 yr2000 if (year==1960 | year==2000) & sjbasesamplenoncomm==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2a, cti(2) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 3
xtreg  logmaddpop loglifeexpect yr1940 yr1980 if (year==1940 | year==1980) & (sample40==1 & sample80==1) & sjbasesamplenoncomm==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2a, cti(3) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 4
xtreg  logmaddpop loglifeexpect yr1940 yr1980 if (year==1940 | year==1980) & (sample40==1 & sample80==1)& sjbasesamplenoncomm==1 & startrich!=1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2a, cti(4) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 5
xtreg  logmaddpop loglifeexpect yr1940 yr2000 if (year==1940 | year==2000) & (sample40==1 & sample80==1) & sjbasesamplenoncomm==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2a, cti(5) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 6
xtreg  logmaddpop loglifeexpect yr1940 yr2000 if (year==1940 | year==2000) & (sample40==1 & sample80==1)& sjbasesamplenoncomm==1 & startrich!=1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2a, cti(6) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append




* Panel B log number of births

* col 1 with extended sample on log of births
xtreg  logtotalbirthstwo loglifeexpect yr1960 yr1990 if (year==1960 | year==1990) & allcountrypanel19601990==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2b, ti(z10tab2b) cti(1) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) replace

* col 1b with standard sample on log of births (not shown in table)
xtreg  logtotalbirths loglifeexpect yr1960 yr1990 if (year==1960 | year==1990) & allcountrypanel19601990==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2b, cti(1b) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 2
xtreg  logtotalbirths loglifeexpect yr1960 yr1990 if (year==1960 | year==1990) & allcountrypanel19601990==1 & sjbasesamplenoncomm==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2b, cti(2) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 3  (missing Brazil 40)
xtreg  logtotalbirths loglifeexpect yr1940 yr1980 if country!="Brazil" & (year==1940 | year==1980) & sjbasesamplenoncomm==1 & (sample40==1 & sample80==1), fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2b, cti(3) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 4 (missing Brazil 40)
xtreg  logtotalbirths loglifeexpect yr1940 yr1980 if country!="Brazil" & (year==1940 | year==1980) & sjbasesamplenoncomm==1 & (sample40==1 & sample80==1) & startrich!=1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2b, cti(4) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append


* col 5  (missing Brazil 40)
xtreg  logtotalbirths loglifeexpect yr1940 yr1990 if country!="Brazil" & (year==1940 | year==1990) & sjbasesamplenoncomm==1 & (sample40==1 & sample80==1), fe vce(cluster ctrycluster)

outreg2 loglifeexpect using z10tab2b, cti(5) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append


* col 6 (missing Brazil 40)
xtreg  logtotalbirths loglifeexpect yr1940 yr1990 if country!="Brazil" & (year==1940 | year==1990) & sjbasesamplenoncomm==1 & (sample40==1 & sample80==1) & startrich!=1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2b, cti(6) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append


* Panel C percent of population under age 20

* col 1
xtreg  poppct20 loglifeexpect yr1960 yr2000 if (year==1960 | year==2000) & allcountrypanel19602000==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2c, ti(z10tab2c) cti(1) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) replace

* col 2
xtreg  poppct20 loglifeexpect yr1960 yr2000 if (year==1960 | year==2000) & sjbasesamplenoncomm==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2c, cti(2) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 3
xtreg  poppct20 loglifeexpect yr1940 yr1980 if (year==1940 | year==1980) & (sample40==1 & sample80==1) & sjbasesamplenoncomm==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2c, cti(3) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 4
xtreg  poppct20 loglifeexpect yr1940 yr1980 if (year==1940 | year==1980) & (sample40==1 & sample80==1)& sjbasesamplenoncomm==1 & startrich!=1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2c, cti(4) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 5
xtreg  poppct20 loglifeexpect yr1940 yr2000 if (year==1940 | year==2000) & (sample40==1 & sample80==1) & sjbasesamplenoncomm==1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2c, cti(5) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append

* col 6
xtreg  poppct20 loglifeexpect yr1940 yr2000 if (year==1940 | year==2000) & (sample40==1 & sample80==1)& sjbasesamplenoncomm==1 & startrich!=1, fe vce(cluster ctrycluster)

outreg2  loglifeexpect using z10tab2c, cti(6) excel nocons bracket noaster  addstat(Number of Countries, e(N_clust)) append




