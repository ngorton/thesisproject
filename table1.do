***********************************************************
*Creates Table 1: Descriptive Statistics
***********************************************************
clear
capture log close

/*Data Files Used
	totaldata
	
*Data Files Created as Final Product
	none
	
*Data Files Created as Intermediate Product
	none*/
	
use totaldata, clear

* life expectancy at birth
sum lifeexpect if year==1980
sum lifeexpect if year==1980 & category == "poor"
sum lifeexpect if year==1980 & category == "medium" 
sum lifeexpect if year==1980 & category == "rich"
sum lifeexpect if year==1980 & gavi_status2 == 1
sum lifeexpect if year==1980 & gavi_status2 == 0


sum lifeexpect if year==1990
sum lifeexpect if year==1990 & category == "poor"
sum lifeexpect if year==1990 & category == "medium" 
sum lifeexpect if year==1990 & category == "rich"
sum lifeexpect if year==1990 & gavi_status2 == 1
sum lifeexpect if year==1980 & gavi_status2 == 0


sum lifeexpect if year==2000
sum lifeexpect if year==2000 & category == "poor"
sum lifeexpect if year==2000 & category == "medium" 
sum lifeexpect if year==2000 & category == "rich"
sum lifeexpect if year==2000 & gavi_status2 == 1
sum lifeexpect if year==1980 & gavi_status2 == 0


sum lifeexpect if year==2010
sum lifeexpect if year==2010 & category == "poor"
sum lifeexpect if year==2010 & category == "medium" 
sum lifeexpect if year==2010 & category == "rich"
sum lifeexpect if year==2010 & gavi_status2 == 1
sum lifeexpect if year==1980 & gavi_status2 == 0


* life expectancy at birth
sum mortality if year==1980
sum mortality if year==1980 & category == "poor"
sum mortality if year==1980 & category == "medium" 
sum mortality if year==1980 & category == "rich"
sum mortality if year==1980 & gavi_status2 == 1
sum mortality  if year==1980 & gavi_status2 == 0


sum mortality if year==1990
sum mortality if year==1990 & category == "poor"
sum mortality if year==1990 & category == "medium" 
sum mortality if year==1990 & category == "rich"
sum mortality if year==1990 & gavi_status2 == 1
sum mortality if year==1980 & gavi_status2 == 0


sum mortality if year==2000
sum mortality if year==2000 & category == "poor"
sum mortality if year==2000 & category == "medium" 
sum mortality if year==2000 & category == "rich"
sum mortality if year==2000 & gavi_status2 == 1
sum mortality if year==1980 & gavi_status2 == 0


sum mortality if year==2010
sum mortality if year==2010 & category == "poor"
sum mortality if year==2010 & category == "medium" 
sum mortality if year==2010 & category == "rich"
sum mortality if year==2010 & gavi_status2 == 1
sum mortality if year==1980 & gavi_status2 == 0

*Before GAVI vaccines*
sum unicefmcv1 if year==1980 & gavi_status2 == 1
sum unicefmcv1 if year==1980 & gavi_status2 == 0

sum unicefmcv2 if year==1980 & gavi_status2 == 1
sum unicefmcv2 if year==1980 & gavi_status2 == 0

sum unicefdtp1 if year==1980 & gavi_status2 == 1
sum unicefdtp1 if year==1980 & gavi_status2 == 0

sum unicefpol3 if year==1980 & gavi_status2 == 1
sum unicefpol3 if year==1980 & gavi_status2 == 0

*after gavi vaccines*
sum unicefmcv1 if year==2010 & gavi_status2 == 1
sum unicefmcv1 if year==2010 & gavi_status2 == 0

sum unicefmcv2 if year==2010 & gavi_status2 == 1
sum unicefmcv2 if year==2010 & gavi_status2 == 0

sum unicefdtp1 if year==2010 & gavi_status2 == 1
sum unicefdtp1 if year==2010 & gavi_status2 == 0

sum unicefpol3 if year==2010 & gavi_status2 == 1
sum unicefpol3 if year==2010 & gavi_status2 == 0


