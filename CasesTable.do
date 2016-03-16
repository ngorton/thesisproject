// Tables

estpost tabstat measles_cases pertussis tetanus diptheria if gavi_status_00 == 1, statistics(max min mean sd n sum) columns(statistics)
esttab using Cases.tex, replace label booktabs title("Number of Cases") compress 
