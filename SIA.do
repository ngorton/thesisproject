clear

insheet using SIA.csv, comma names
save SIA_complete, replace 

bysort iso year: gen SIA = 1
bysort iso year: egen totalreached = sum(reachedpopulation)
rename iso code

bysort code year: gen dup = cond(_N==1,0,_n)
drop if dup > 1


keep(code year SIA reachedpopulation)
save SIA, replace

 merge 1:1 code year using finaldata
 
 drop _merge
