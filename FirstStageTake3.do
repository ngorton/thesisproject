*Health care costs per 10000 people*

gen loghealthcare = log(healthcare)
label variable loghealthcare "Log healthcare spending per capita"
gen loggni = log(gni)
label variable loggni "Log GNI per capita"

local health_controls "loghealthcare"
local infrastructure_controls "gni"
local schooling_controls "yr_sch_sec yr_sch_pri"

replace healthcare = heathcare*1000
replace gni = gni*1000



xtreg l.measles_deaths unicefmcv1 gni, fe robust cluster(pan_id)
