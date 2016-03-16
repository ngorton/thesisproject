// Only keep certain years


gen young_mort = mortality-infantmort
gen young_survive = (1 - young_mort/1000)*100
gen adult_survive = (1 - adultmort/1000)*100

gen logsch = log(yr_sch)
gen interlogsch = log(interpolated_years)
