*********************************
*Kelley Breeze and Daniel Cisneros
*ST 513 Mini-Project 1
*9/19/2022
*********************************;



*Creating a permanent library for our project data called Project1;
LIBNAME Project1 '/home/u61708299/myLib';

FILENAME WDI '/home/u61708299/myLib/WorldDevelopmentIndicators.xlsx';

PROC IMPORT DATAFILE=WDI
	DBMS= xlsx
	OUT=Project1.worldDI;
	GETNAMES=YES;
	SHEET="Data";
RUN;

*Rename the Country Name to Region, Country Code to Region_Code, Indicator Name to Indicator_Name and 
* Indicator Code to Indicator_Code;

DATA Project1.worldDI;
	SET Project1.worldDI;
	RENAME 	'Country Name'n = Region
			'Country Code'n = Region_Code
			'Indicator Name'n = Indicator_Name
			'Indicator Code'n = Indicator_Code;
RUN;




***************************************************************************************************
*EURO REGION
***************************************************************************************************;

*Select only observations where the Region_Code is EUU correponding to the European Union region
* Store this as a new dataset called EUU in our Project1 folder;

DATA Project1.EUU;
	SET Project1.worldDI;
	WHERE (Region_Code = 'EUU');
RUN; 

*********************************************
* Income per capita data for EURO REGION
*********************************************;

*Select only observations in our EUU dataset where the Indicator_Code is NY.ADJ.NNTY.PC.CD (correponding to the "Adjusted net national income per capita (current US$)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EUUinc in our Project1 folder;

DATA Project1.EUUinc;
	SET Project1.EUU;
	LABEL 'Value'n = Adjusted net national income per capita (current US$);
	WHERE Indicator_Code = 'NY.ADJ.NNTY.PC.CD';
RUN; 

title "Euro Region Net Income Per Capita 1970-2018"; 
PROC SGPLOT DATA = Project1.EUUinc;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.EUUinc MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Euro Region Net Income Per Capita 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.EUUinc MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Euro Region Net Income Per Capita 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;


**************************************
* CO2 emissions data for EURO REGION
**************************************;

*Select only observations in our EAS dataset where the Indicator_Code is EN.ATM.CO2E.PC (correponding to the "CO2 emissions (metric tons per capita)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASCO2 in our Project1 folder;

DATA Project1.EUUCO2;
	SET Project1.EUU;
	LABEL 'Value'n = CO2 emissions (metric tons per capita);
	WHERE Indicator_Code = 'EN.ATM.CO2E.PC';
RUN; 

title "Euro Region CO2 Emmisions per Capita (metric tons) 1960-2016"; 
PROC SGPLOT DATA = Project1.EUUCO2;
	REG X = YEAR Y = Value;
RUN;

PROC SGPLOT DATA = Project1.EUUCO2;
	TITLE "Euro Region CO2 Emissions Per Capita (metric tons) 1960-1979";
	REG X = YEAR Y = Value;
	WHERE (YEAR BETWEEN 1960 AND 1979);
RUN;

PROC MEANS DATA = Project1.EUUCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Euro Region CO2 Emissions Per Capita (metric tons) 1960-1979";
	VAR Value;
	WHERE (YEAR BETWEEN 1960 AND 1979);
RUN;


PROC SGPLOT DATA = Project1.EUUCO2;
	TITLE "Euro Region CO2 Emissions Per Capita (metric tons) 1980-1999";
	REG X = YEAR Y = Value;
	WHERE (YEAR BETWEEN 1980 AND 1999);
RUN;

PROC MEANS DATA = Project1.EUUCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Euro Region CO2 Emissions Per Capita (metric tons) 1980-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1980 AND 1999);
RUN;

PROC SGPLOT DATA = Project1.EUUCO2;
	TITLE "Euro Region CO2 Emissions Per Capita (metric tons) 2000-2016";
	REG X = YEAR Y = Value;
	WHERE (YEAR BETWEEN 2000 AND 2016);
RUN;

PROC MEANS DATA = Project1.EUUCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Euro Region CO2 Emissions Per Capita (metric tons) 2000-2016";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2016);
RUN;


**********************************************
* Urban Population data for EURO REGION
**********************************************;

*Select only observations in our EUU dataset where the Indicator_Code is SP.URB.TOTL.IN.ZS (correponding to the "Urban population (% of total population)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASurban in our Project1 folder;

DATA Project1.EUUurban;
	SET Project1.EUU;
	LABEL 'Value'n = Urban population (% of total population);
	WHERE Indicator_Code = 'SP.URB.TOTL.IN.ZS';
RUN; 



title "Euro Region Urban population (% of total population) 1960-2019"; 
PROC SGPLOT DATA = Project1.EUUurban;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.EUUurban MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Euro Region Urban population (% of total population) 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.EUUurban MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Euro Region Urban population (% of total population) 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;







****************************************************************************************************************
*ASIA REGION
****************************************************************************************************************;

*Select only observations where the Region_Code is EAS correponding to the East Asia & Pacific region
* Store this as a new dataset called EAS in our Project1 folder;

DATA Project1.EAS;
	SET Project1.worlddi;
	WHERE (Region_Code = 'EAS');
RUN; 


*********************************************
* Income per capita data for ASIA REGION
*********************************************;

*Select only observations in our EAS dataset where the Indicator_Code is NY.ADJ.NNTY.PC.CD (correponding to the "Adjusted net national income per capita (current US$)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASinc in our Project1 folder;


DATA Project1.EASinc;
	SET Project1.EAS;
	LABEL 'Value'n = Adjusted net national income per capita (current US$);
	WHERE Indicator_Code = 'NY.ADJ.NNTY.PC.CD';
RUN; 

title "Asia Region Net Income Per Capita 1970-2018"; 
PROC SGPLOT DATA = Project1.EASinc;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.EASinc MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Asia Region Net Income Per Capita 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.EASinc MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Asia Region Net Income Per Capita 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;





**************************************
* CO2 emissions data for ASIA REGION
**************************************;

*Select only observations in our EAS dataset where the Indicator_Code is EN.ATM.CO2E.PC (correponding to the "CO2 emissions (metric tons per capita)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASCO2 in our Project1 folder;

DATA Project1.EASCO2;
	SET Project1.EAS;
	LABEL 'Value'n = CO2 emissions (metric tons per capita);
	WHERE Indicator_Code = 'EN.ATM.CO2E.PC';
RUN; 

title "Asia Region CO2 Emmisions per Capita (metric tons) 1960-2016"; 
PROC SGPLOT DATA = Project1.EASCO2;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.EASCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Asia Region CO2 Emissions Per Capita (metric tons) 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.EASCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Asia Region CO2 Emissions Per Capita (metric tons) 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;



**********************************************
* Urban Population data for ASIA REGION
**********************************************;

*Select only observations in our EAS dataset where the Indicator_Code is SP.URB.TOTL.IN.ZS (correponding to the "Urban population (% of total population)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASurban in our Project1 folder;

DATA Project1.EASurban;
	SET Project1.EAS;
	LABEL 'Value'n = Urban population (% of total population);
	WHERE Indicator_Code = 'SP.URB.TOTL.IN.ZS';
RUN; 



title "Asia Region Urban population (% of total population) 1960-2019"; 
PROC SGPLOT DATA = Project1.EASurban;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.EASurban MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Asia Region Urban population (% of total population) 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.EASurban MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Asia Region Urban population (% of total population) 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;





************************************************************************************************************************************
* Comparing "High income" regions (HIC) to "Lower middle income" regions (LMC) for income per capita, CO2 emissions, and % urban population
************************************************************************************************************************************;



*************************************************************
* "High income" Regions
************************************************************;

*Select only observations where the Region_Code is HIC correponding to High income region
* Store this as a new dataset called HIC in our Project1 folder;

DATA Project1.HIC;
	SET Project1.worlddi;
	WHERE (Region_Code = 'HIC');
RUN; 


*********************************************
* Income per capita data for High Income REGION
*********************************************;

*Select only observations in our HIC dataset where the Indicator_Code is NY.ADJ.NNTY.PC.CD (correponding to the "Adjusted net national income per capita (current US$)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASinc in our Project1 folder;


DATA Project1.HICinc;
	SET Project1.HIC;
	LABEL 'Value'n = Adjusted net national income per capita (current US$);
	WHERE Indicator_Code = 'NY.ADJ.NNTY.PC.CD';
RUN; 

title "High Income Region Net Income Per Capita 1970-2018"; 
PROC SGPLOT DATA = Project1.HICinc;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.HICinc MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "High Income Region Net Income Per Capita 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.HICinc MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "High Income Region Net Income Per Capita 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;





**************************************
* CO2 emissions data for High Income REGION
**************************************;

*Select only observations in our HIC dataset where the Indicator_Code is EN.ATM.CO2E.PC (correponding to the "CO2 emissions (metric tons per capita)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASCO2 in our Project1 folder;

DATA Project1.HICCO2;
	SET Project1.HIC;
	LABEL 'Value'n = CO2 emissions (metric tons per capita);
	WHERE Indicator_Code = 'EN.ATM.CO2E.PC';
RUN; 

title "High Income Region CO2 Emmisions per Capita (metric tons) 1960-2016"; 
PROC SGPLOT DATA = Project1.HICCO2;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.HICCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "High Income Region CO2 Emissions Per Capita (metric tons) 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.HICCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "High Income Region CO2 Emissions Per Capita (metric tons) 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;



**********************************************
* Urban Population data for High Income REGION
**********************************************;

*Select only observations in our HIC dataset where the Indicator_Code is SP.URB.TOTL.IN.ZS (correponding to the "Urban population (% of total population)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASurban in our Project1 folder;

DATA Project1.HICurban;
	SET Project1.HIC;
	LABEL 'Value'n = Urban population (% of total population);
	WHERE Indicator_Code = 'SP.URB.TOTL.IN.ZS';
RUN; 



title "High Income Region Urban population (% of total population) 1960-2019"; 
PROC SGPLOT DATA = Project1.HICurban;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.HICurban MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "High Income Region Urban population (% of total population) 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.HICurban MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "High Income Region Urban population (% of total population) 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;





*************************************************************
* "Lower middle income" Regions
************************************************************;

*Select only observations where the Region_Code is LMC correponding to Low income region
* Store this as a new dataset called LIC in our Project1 folder;

DATA Project1.LMC;
	SET Project1.worlddi;
	WHERE (Region_Code = 'LMC');
RUN; 


***************************************************
* Income per capita data for Lower middle income REGION
***************************************************;

*Select only observations in our LMC dataset where the Indicator_Code is NY.ADJ.NNTY.PC.CD (correponding to the "Adjusted net national income per capita (current US$)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASinc in our Project1 folder;


DATA Project1.LMCinc;
	SET Project1.LMC;
	LABEL 'Value'n = Adjusted net national income per capita (current US$);
	WHERE Indicator_Code = 'NY.ADJ.NNTY.PC.CD';
RUN; 

title "Lower Middle Income Region Net Income Per Capita 1970-2018"; 
PROC SGPLOT DATA = Project1.LMCinc;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.LMCinc MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Lower Middle Income Region Net Income Per Capita 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.LMCinc MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Lower Middle Income Region Net Income Per Capita 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;





**************************************
* CO2 emissions data for Lower middle income REGION
**************************************;

*Select only observations in our LMC dataset where the Indicator_Code is EN.ATM.CO2E.PC (correponding to the "CO2 emissions (metric tons per capita)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASCO2 in our Project1 folder;

DATA Project1.LMCCO2;
	SET Project1.LMC;
	LABEL 'Value'n = CO2 emissions (metric tons per capita);
	WHERE Indicator_Code = 'EN.ATM.CO2E.PC';
RUN; 

title "Lower Middle Income Region CO2 Emmisions per Capita (metric tons) 1960-2016"; 
PROC SGPLOT DATA = Project1.LMCCO2;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.LMCCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Lower Middle Income Region CO2 Emissions Per Capita (metric tons) 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.LMCCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Lower Middle Income Region CO2 Emissions Per Capita (metric tons) 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;



**********************************************
* Urban Population data for Lower middle income REGION
**********************************************;

*Select only observations in our LMC dataset where the Indicator_Code is SP.URB.TOTL.IN.ZS (correponding to the "Urban population (% of total population)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASurban in our Project1 folder;

DATA Project1.LMCurban;
	SET Project1.LMC;
	LABEL 'Value'n = Urban population (% of total population);
	WHERE Indicator_Code = 'SP.URB.TOTL.IN.ZS';
RUN; 



title "Lower Middle Income Region Urban population (% of total population) 1960-2019"; 
PROC SGPLOT DATA = Project1.LMCurban;
	REG X = YEAR Y = Value;
RUN;

PROC MEANS DATA = Project1.LMCurban MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Lower Middle Income Region Urban population (% of total population) 1981-1999";
	VAR Value;
	WHERE (YEAR BETWEEN 1981 AND 1999);
RUN;

PROC MEANS DATA = Project1.LMCurban MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Lower Middle Income Region Urban population (% of total population) 2000-2019";
	VAR Value;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;
























