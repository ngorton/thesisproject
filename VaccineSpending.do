* Vaccine Spending *

sort gavi_status_00

lab def origin 0 "Not-GAVI Supported" 1 "GAVI-Supported", modify

estpost tabstat interpolated_school survival_rate young_survive vaxspending unicefmcv1 unicefmcv2 unicefdtp1 unicefdtp3 unicefpol3 lifeexpect pop gdpcap, by(gavi_status_00) statistics(mean sd max min) columns(statistics) listwise not 
esttab using tables12.tex, replace main(mean) aux(sd) nostar unstack noobs nomtitle nonumber booktabs addnote("note")  eqlabels(`e(labels)') cells("mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))")  

estpost tabstat interpolated_school survival_rate lifeexpect  logpop loggni, by(gavi_status_00) statistics(mean sd max min) columns(statistics) listwise not 
esttab using tables2.tex, replace main(mean) aux(sd) nostar unstack noobs nomtitle nonumber booktabs  addnote("note") eqlabels(`e(labels)') cells("mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))")  

estpost tabstat vaxspending unicefmcv1 unicefmcv2 unicefdtp1 unicefdtp3 measles_prcnt_under5 dtp_prcnt_under5 mortality lifeexpect rateofoutofschoolMF logpop loggni, by(gavi_status_00) statistics(mean sd) columns(statistics) listwise not 
esttab using tables3.tex, replace main(mean) aux(sd) nostar unstack noobs nomtitle nonumber addnote("note")  eqlabels(`e(labels)') cells("mean(fmt(2)) sd(fmt(2))")  



xtreg unicefmcv1 vaxspending gdpcap pop liberties i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
outreg2 using firststage2.tex, label nocons keep(l5.mortality) noobs replace ctitle("OLS, 5-year Lag") addtext(Country FE, Yes, Year FE, Yes, Controls, Yes)

xtreg unicefmcv2 vaxspending i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

xtreg unicefdtp1 vaxspending i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

xtreg unicefdtp3 vaxspending i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)

xtreg unicefpol3 vaxspending i.year if in_sample == 1 & gavi_status_00 == 1, fe robust cluster(pan_id)
