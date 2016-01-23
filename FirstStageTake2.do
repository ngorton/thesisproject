clear

use finaldata


*Health care costs per 10000 people*

gen loghealthcare = log(healthcare)
label variable loghealthcare "Log healthcare spending per capita"
gen loggni = log(gni)
label variable loggni "Log GNI per capita"



local health_controls "loghealthcare"
local infrastructure_controls "gni"
local schooling_controls "yr_sch_sec yr_sch_pri"



*Measles*

xtreg f2.mortality i.low#c.unicefmcv1 loghealthcare i.year, fe cluster(pan_id)
outreg2 using firststage2.tex, nocons se bracket keep(low#c.unicefmcv1 loghealthcare) noobs replace title("First Stage Estimates, Measles")

xtreg f3.mortality i.low#c.unicefmcv1 loghealthcare i.year, fe cluster(pan_id)
outreg2 using firststage2.tex, nocons se bracket keep(low#c.unicefmcv1 loghealthcare) noobs append

xtreg f4.mortality i.low#c.unicefmcv1 loghealthcare i.year, fe cluster(pan_id)
outreg2 using firststage2.tex, nocons se bracket keep(low#c.unicefmcv1 loghealthcare) noobs append

xtreg f2.mortality i.low#c.unicefmcv1 loggni i.year, fe cluster(pan_id)
outreg2 using firststage2.tex, nocons se bracket keep(low#c.unicefmcv1 loggni) noobs append 

xtreg f3.mortality i.low#c.unicefmcv1 loggni i.year, fe cluster(pan_id)
outreg2 using firststage2.tex, nocons se bracket keep(low#c.unicefmcv1 loggni) noobs append 


*DTPs*

xtreg f2.mortality i.low#c.unicefdtp1 loghealthcare i.year, fe cluster(pan_id)
outreg2 using firststage3.tex, nocons se bracket keep(low#c.unicefdtp1 loghealthcare) noobs replace title("First Stage Estimates, DTP")

xtreg f3.mortality i.low#c.unicefdtp1 loghealthcare i.year, fe cluster(pan_id)
outreg2 using firststage3.tex, nocons se bracket keep(low#c.unicefdtp1 loghealthcare) noobs append

xtreg f4.mortality i.low#c.unicefdtp1 loghealthcare i.year, fe cluster(pan_id)
outreg2 using firststage3.tex, nocons se bracket keep(low#c.unicefdtp1 loghealthcare) noobs  append

xtreg f2.mortality i.low#c.unicefdtp1 loggni i.year, fe cluster(pan_id)
outreg2 using firststage3.tex, nocons se bracket keep(low#c.unicefdtp1 healthcare loggni) noobs append 

xtreg f3.mortality i.low#c.unicefdtp1 loggni i.year, fe cluster(pan_id)
outreg2 using firststage3.tex, nocons se bracket keep(low#c.unicefdtp1 healthcare loggni) noobs append

*OLS Estimates*
xtreg f5.some_primary mortality loghealthcare i.year, fe cluster(pan_id)

