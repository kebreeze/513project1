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
* Store this as a new dataset called EUU in our Project1 Library;

DATA Project1.EUU;
	SET Project1.worldDI;
	WHERE (Region_Code = 'EUU');
RUN; 

**********************************************************************
* Income per capita data for EURO REGION
* Renaming the Value variable to INCOME and giving descriptive label
**********************************************************************;

*Select only observations in our EUU dataset where the Indicator_Code is NY.ADJ.NNTY.PC.CD (correponding to the "Adjusted net national income per capita (current US$)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EUUinc in our Project1 Library;

DATA Project1.EUUinc;
	SET Project1.EUU;
	RENAME Value = INCOME; 
	LABEL Value = Adjusted net national income per capita (current US$);
	WHERE Indicator_Code = 'NY.ADJ.NNTY.PC.CD';
RUN; 


**********************************************************************
* CO2 emissions data for EURO REGION
* Renaming the Value variable to CO2 and giving descriptive label
**********************************************************************;

*Select only observations in our EUU dataset where the Indicator_Code is EN.ATM.CO2E.PC (correponding to the "CO2 emissions (metric tons per capita)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EUUCO2 in our Project1 Library;

DATA Project1.EUUCO2;
	SET Project1.EUU;
	RENAME Value = CO2;
	LABEL Value = CO2 emissions (metric tons per capita);
	WHERE Indicator_Code = 'EN.ATM.CO2E.PC';
RUN; 
 

**********************************************************************
* Urban Population data for EURO REGION
* Renaming the Value variable to URBAN and giving descriptive label
**********************************************************************;

*Select only observations in our EUU dataset where the Indicator_Code is SP.URB.TOTL.IN.ZS (correponding to the "Urban population (% of total population)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASurban in our Project1 Library;

DATA Project1.EUUurban;
	SET Project1.EUU;
	RENAME Value = URBAN;
	LABEL Value = Urban population (% of total population);
	WHERE Indicator_Code = 'SP.URB.TOTL.IN.ZS';
RUN; 

****************************************************************************************************************
*ASIA REGION
****************************************************************************************************************;

*Select only observations where the Region_Code is EAS correponding to the East Asia & Pacific region
* Store this as a new dataset called EAS in our Project1 Library;

DATA Project1.EAS;
	SET Project1.worldDI;
	WHERE (Region_Code = 'EAS');
RUN; 

**********************************************************************
* Income per capita data for ASIA REGION
* Renaming the Value variable to INCOME and giving descriptive label
**********************************************************************;

*Select only observations in our EAS dataset where the Indicator_Code is NY.ADJ.NNTY.PC.CD (correponding to the "Adjusted net national income per capita (current US$)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASinc in our Project1 Library;

DATA Project1.EASinc;
	SET Project1.EAS;
	RENAME Value = INCOME;
	LABEL Value = Adjusted net national income per capita (current US$);
	WHERE Indicator_Code = 'NY.ADJ.NNTY.PC.CD';
RUN; 


**********************************************************************
* CO2 emissions data for ASIA REGION
* Renaming the Value variable to CO2 and giving descriptive label
**********************************************************************;

*Select only observations in our EAS dataset where the Indicator_Code is EN.ATM.CO2E.PC (correponding to the "CO2 emissions (metric tons per capita)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASCO2 in our Project1 Library;

DATA Project1.EASCO2;
	SET Project1.EAS;
	RENAME Value = CO2;
	LABEL Value = CO2 emissions (metric tons per capita);
	WHERE Indicator_Code = 'EN.ATM.CO2E.PC';
RUN; 


**********************************************************************
* Urban Population data for ASIA REGION
* Renaming the Value variable to URBAN and giving descriptive label
**********************************************************************;

*Select only observations in our EAS dataset where the Indicator_Code is SP.URB.TOTL.IN.ZS (correponding to the "Urban population (% of total population)")
* and create a descriptive label for our "Value" variable. Store this as a new dataset called EASurban in our Project1 Library;

DATA Project1.EASurban;
	SET Project1.EAS;
	RENAME Value = URBAN;
	LABEL Value = Urban population (% of total population);
	WHERE Indicator_Code = 'SP.URB.TOTL.IN.ZS';
RUN; 


************************************************************************************************************************************
*MERGING DATASETS OF OF THE SAME VARIBALES FOR COMPARISON
************************************************************************************************************************************;
DATA Project1.MergedINC;
	SET Project1.EUUinc Project1.EASinc;
RUN;

DATA Project1.MergedCO2;
	SET Project1.EUUCO2 Project1.EASCO2;
RUN;

DATA Project1.MergedURBAN;
	SET Project1.EUUurban Project1.EASurban;
RUN;


************************************************************************************************************************************
*USING MERGED DATASETS TO PLOT RELEVANT GRAPHS TO COMPARE
*INCOME PER CAPITA FOR EURO REGION & ASIA REGION 
************************************************************************************************************************************;

PROC SGPLOT DATA = PROJECT1.MERGEDINC;
	TITLE "Net Income Per Capita EURO and ASIA Regions 1970-2018";
	LOESS X = YEAR Y = INCOME/
						GROUP = REGION_CODE;
RUN;

PROC MEANS DATA = PROJECT1.MERGEDINC MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Net Income Per Capita EURO and ASIA Regions 1980-1999";
	CLASS REGION_CODE;
	VAR INCOME;
	WHERE (YEAR BETWEEN 1970 AND 1979);
RUN;

PROC MEANS DATA = PROJECT1.MERGEDINC MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Net Income Per Capita EURO and ASIA Regions 1980-1999";
	CLASS REGION_CODE;
	VAR INCOME;
	WHERE (YEAR BETWEEN 1980 AND 1999);
RUN;

PROC MEANS DATA = PROJECT1.MERGEDINC MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Net Income Per Capita EURO and ASIA Regions 2000-2018";
	CLASS REGION_CODE;
	VAR INCOME;
	WHERE (YEAR BETWEEN 2000 AND 2018);
RUN;

************************************************************************************************************************************
*USING MERGED DATASETS TO PLOT RELEVANT GRAPHS TO COMPARE AND CONTRAST
* CO2 emissions data FOR EURO REGION & ASIA REGION 
************************************************************************************************************************************;

PROC SGPLOT DATA = PROJECT1.MergedCO2;
	TITLE "CO2 Emissions Per Capita EURO and ASIA Regions 1960-2016";
	LOESS X = YEAR Y = CO2/
						GROUP = REGION_CODE;
RUN;

PROC MEANS DATA = PROJECT1.MergedCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "CO2 Emmisions per Capita EURO and ASIA Regions 1960-1979";
	CLASS REGION_CODE;
	VAR CO2;
	WHERE (YEAR BETWEEN 1960 AND 1979);
RUN;

PROC MEANS DATA = PROJECT1.MergedCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "CO2 Emmisions per Capita EURO and ASIA Regions 1980-1999";
	CLASS REGION_CODE;
	VAR CO2;
	WHERE (YEAR BETWEEN 1980 AND 1999);
RUN;

PROC MEANS DATA = PROJECT1.MergedCO2 MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "CO2 Emmisions per Capita EURO and ASIA Regions 2000-2016";
	CLASS REGION_CODE;
	VAR CO2;
	WHERE (YEAR BETWEEN 2000 AND 2016);
RUN;


************************************************************************************************************************************
*USING MERGED DATASETS TO PLOT RELEVANT GRAPHS TO COMPARE AND CONTRAST
* CO2 emissions data FOR EURO REGION & ASIA REGION 
************************************************************************************************************************************;

PROC SGPLOT DATA = PROJECT1.MergedURBAN;
	TITLE "Urban Population EURO and ASIA Regions 1960-2019";
	LOESS X = YEAR Y = URBAN/
						GROUP = REGION_CODE;
RUN;

PROC MEANS DATA = PROJECT1.MergedURBAN MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Urban population (% of total population) EURO and ASIA Regions 1960-1979";
	CLASS REGION_CODE;
	VAR URBAN;
	WHERE (YEAR BETWEEN 1960 AND 1979);
RUN;

PROC MEANS DATA = PROJECT1.MergedURBAN MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Urban population (% of total population) EURO and ASIA Regions 1980-1999";
	CLASS REGION_CODE;
	VAR URBAN;
	WHERE (YEAR BETWEEN 1980 AND 1999);
RUN;

PROC MEANS DATA = PROJECT1.MergedURBAN MEAN VAR STDDEV MIN Q1 MEDIAN Q3 MAX MAXDEC = 2;
	TITLE "Urban population EURO and ASIA Regions 2000-2019";
	CLASS REGION_CODE;
	VAR URBAN;
	WHERE (YEAR BETWEEN 2000 AND 2019);
RUN;


**********************************************************************************************************************************************
* DATA SET CONTAINING CO2, INCOME AND URBAN VARIABLES (WHICH WERE RENAMED IN PREVIOUS STEPS FROM THE SINGLE VALUE VARIABLE) FOR BOTH REGIONS
**********************************************************************************************************************************************;
DATA Project1.MergedALL;
	SET Project1.MergedURBAN Project1.MERGEDCO2 Project1.mergedinc;
RUN;


********************************************************
* EURO REGION COMPARISONS
********************************************************;



*******************************************************
* CO2 and Income
* Years with data for both variables are 1970-2016
*******************************************************;
PROC SGPLOT DATA=Project1.mergedall;
	TITLE "EURO REGION: CO2 Emissions Compared to Per Capita Income 1970-2016";
	WHERE (YEAR BETWEEN 1970 and 2016) AND (Region_Code='EUU');
	LOESS X=Year Y=CO2/ 
		name="CO2" LINEATTRS=(color=red) MARKERATTRS=(color=red);
	LOESS X=Year Y=INCOME/
		y2axis name="INCOME" LINEATTRS=(color=green) MARKERATTRS=(color=green symbol=diamond);
	keylegend "CO2" / title= "CO2 Axis" position=bottomleft;
	keylegend "INCOME" / title="Income Axis" position=bottomright;
	xaxis values=(1970 to 2020 by 5);
	yaxis values=(0 to 10 by 0.5) LABELATTRS=(color=red weight=bold) VALUEATTRS=(color=red);
	y2axis values=(0 to 35000 by 5000) LABELATTRS=(color=green weight=bold) VALUEATTRS=(color=green);
RUN;

*****************************************************
* CO2 and Urban Population
* Years with data for both variables are 1960-2016
*****************************************************;
PROC SGPLOT DATA=Project1.mergedall;
	TITLE "EURO REGION: CO2 Emissions Compared to Percent Urban Population 1960-2016";	
	WHERE (YEAR BETWEEN 1960 and 2016) AND (Region_Code='EUU');
	LOESS X=Year Y=CO2/ 
		name="CO2" LINEATTRS=(color=red) MARKERATTRS=(color=red);
	LOESS X=Year Y=URBAN/
		y2axis name="Urban Population" LINEATTRS=(color=blue) MARKERATTRS=(color=blue symbol=triangle);
	keylegend "CO2" / title= "CO2 Axis" position=bottomleft;
	keylegend "Urban Population" / title="Urban Population Axis" position=bottomright;
	xaxis values=(1960 to 2020 by 5);
	yaxis values=(0 to 10 by 0.5) LABELATTRS=(color=red weight=bold) VALUEATTRS=(color=red);
	y2axis values=(55 to 75 by 5) LABELATTRS=(color=blue weight=bold) VALUEATTRS=(color=blue);
RUN;

***************************************************
* Income and Urban Population
* Years with data for both variables are 1970-2016
***************************************************;
PROC SGPLOT DATA=Project1.mergedall;
	TITLE "EURO REGION: Per Capita Income Compared to Percent Urban Population 1970-2016";	
	WHERE (YEAR BETWEEN 1970 and 2016) AND (Region_Code='EUU');
	LOESS X=Year Y=INCOME/ 
		name="INCOME" LINEATTRS=(color=green) MARKERATTRS=(color=green symbol=diamond);
	LOESS X=Year Y=URBAN/
		y2axis name="Urban Population" LINEATTRS=(color=blue) MARKERATTRS=(color=blue symbol=triangle);
	keylegend "Urban Population" / title= "Urban Population Axis" position=bottomleft;
	keylegend "INCOME" / title="Income Axis" position=bottomright;
	xaxis values=(1970 to 2020 by 5);
	yaxis values=(0 to 35000 by 5000) LABELATTRS=(color=green weight=bold) VALUEATTRS=(color=green) ;
	y2axis values=(62 to 76 by 2) LABELATTRS=(color=blue weight=bold) VALUEATTRS=(color=blue);
RUN;

********************************************************
* ASIA REGION COMPARISONS
********************************************************;


***************************************************
* CO2 and Income ASIA
* Years with data for both variables are 1970-2016
***************************************************;
PROC SGPLOT DATA=Project1.mergedall;
	TITLE "ASIA REGION: CO2 Emissions Compared to Per Capita Income 1970-2016";
	WHERE (YEAR BETWEEN 1970 and 2016) AND (Region_Code='EAS');
	LOESS X=Year Y=CO2/ 
		name="CO2" LINEATTRS=(color=red) MARKERATTRS=(color=red);
	LOESS X=Year Y=INCOME/
		y2axis name="INCOME" LINEATTRS=(color=green) MARKERATTRS=(color=green symbol=diamond);
	keylegend "CO2" / title= "CO2 Axis" position=bottomleft;
	keylegend "INCOME" / title="Income Axis" position=bottomright;
	xaxis values=(1970 to 2020 by 5);
	yaxis values=(0 to 6.5 by 0.5) LABELATTRS=(color=red weight=bold) VALUEATTRS=(color=red);
	y2axis values=(0 to 8000 by 500) LABELATTRS=(color=green weight=bold) VALUEATTRS=(color=green);
RUN;



***************************************************
* CO2 and Urban Population ASIA
* Years with data for both variables are 1960-2016
***************************************************;


PROC SGPLOT DATA=Project1.mergedall;
	TITLE "ASIA REGION: CO2 Emissions Compared to Percent Urban Population 1960-2016";	
	WHERE (YEAR BETWEEN 1960 and 2016) AND (Region_Code='EAS');
	LOESS X=Year Y=CO2/ 
		name="CO2" LINEATTRS=(color=red) MARKERATTRS=(color=red);
	LOESS X=Year Y=URBAN/
		y2axis name="Urban Population" LINEATTRS=(color=blue) MARKERATTRS=(color=blue symbol=triangle);
	keylegend "CO2" / title= "CO2 Axis" position=bottomleft;
	keylegend "Urban Population" / title="Urban Population Axis" position=bottomright;
	xaxis values=(1960 to 2020 by 5);	
	yaxis values=(0 to 10 by 0.5) LABELATTRS=(color=red weight=bold) VALUEATTRS=(color=red);
	y2axis values=(20 to 65 by 5) LABELATTRS=(color=blue weight=bold) VALUEATTRS=(color=blue);
RUN;


****************************************************
* Income and Urban Population ASIA
* Years with data for both variables are 1970-2016
****************************************************;
PROC SGPLOT DATA=Project1.mergedall;
	TITLE "ASIA REGION: Percent Urban Population Compared to Per Capita Income 1970-2016";	
	WHERE (YEAR BETWEEN 1970 and 2016) AND (Region_Code='EAS');
	LOESS X=Year Y=URBAN/ 
		name="Urban Population" LINEATTRS=(color=blue) MARKERATTRS=(color=blue symbol=triangle);
	LOESS X=Year Y=INCOME/
		y2axis name="INCOME" LINEATTRS=(color=green) MARKERATTRS=(color=green symbol=diamond);
	keylegend "Urban Population" / title= "Urban Population Axis" position=bottomleft;
	keylegend "INCOME" / title="Income Axis" position=bottomright;
	xaxis values=(1970 to 2020 by 5);	
	yaxis values=(20 to 65 by 5) LABELATTRS=(color=blue weight=bold) VALUEATTRS=(color=blue);
	y2axis values=(0 to 8000 by 500) LABELATTRS=(color=green weight=bold) VALUEATTRS=(color=green);
RUN;


*******************************************************************************************************************************
CORRELATION ANALYSIS
*******************************************************************************************************************************;
****************************************************************************
* MERGING EXISTING EUU DATASETS BY YEAR SO WE
* CAN PERFORM CORRELATION ANALYSIS ON OUR VARIABLES
****************************************************************************;

DATA Project1.EUUall;
	MERGE Project1.EUUCO2 Project1.EUUINC Project1.EUUURBAN;
	BY Year;
RUN;


*************************************************
* correlation for EUU region CO2 and Income
* YEARS 1970-2016 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EUUall COV;
		TITLE "EURO REGION CO2 and INCOME 1970-2016";
		WHERE (YEAR BETWEEN 1970 and 2016);
		VAR CO2 Income;
RUN;

*************************************************
* correlation for EUU region CO2 and Income
* YEARS 1970-1980 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EUUall COV;
		TITLE "EURO REGION CO2 and INCOME 1970-1980";
		WHERE (YEAR BETWEEN 1970 and 1980);
		VAR CO2 Income;
RUN;

*************************************************
* correlation for EUU region CO2 and Income
* YEARS 1991-2016 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EUUall COV;
		TITLE "EURO REGION CO2 and INCOME 1981-2016";
		WHERE (YEAR BETWEEN 1981 and 2016);
		VAR CO2 Income;
RUN;




*************************************************
* correlation for EUU region CO2 and URBAN
* YEARS 1960-2016 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EUUall COV;
		TITLE "EURO REGION CO2 and URBAN 1960-2016";
		WHERE (YEAR BETWEEN 1960 and 2016);
		VAR CO2 URBAN;
RUN;

*************************************************
* correlation for EUU region CO2 and URBAN
* YEARS 1960-1980 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EUUall COV;
		TITLE "EURO REGION CO2 and URBAN 1960-1980";
		WHERE (YEAR BETWEEN 1960 and 1980);
		VAR CO2 URBAN;
RUN;

*************************************************
* correlation for EUU region CO2 and URBAN
* YEARS 1981-2016 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EUUall COV;
		TITLE "EURO REGION CO2 and URBAN 1981-2016";
		WHERE (YEAR BETWEEN 1981 and 2016);
		VAR CO2 URBAN;
RUN;






*************************************************
* correlation for EUU region URBAN and Income
* YEARS 1970-2018 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EUUall COV;
		TITLE "EURO REGION URBAN and INCOME 1970-2018";
		WHERE (YEAR BETWEEN 1970 and 2018);
		VAR URBAN Income;
RUN;


*******************************************************************************
* MERGING EXISTING EAS DATASETS BY YEAR SO WE
* CAN PERFORM CORRELATION ANALYSIS ON OUR VARIABLES
*******************************************************************************;

DATA Project1.EASall;
	MERGE Project1.EASCO2 Project1.EASINC Project1.EASURBAN;
	BY Year;
RUN;

*************************************************
* correlation for EAS region CO2 and Income
* YEARS 1970-2016 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EASall COV;
		TITLE "ASIA REGION CO2 and INCOME 1970-2016";		
		WHERE (YEAR BETWEEN 1970 and 2016);
		VAR CO2 Income;
RUN;

*************************************************
* correlation for EAS region CO2 and URBAN
* YEARS 1960-2016 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EASall COV;
		TITLE "ASIA REGION CO2 and URBAN 1960-2016";	
		WHERE (YEAR BETWEEN 1960 and 2016);
		VAR CO2 Urban;
RUN;

*************************************************
* correlation for EAS region INCOME and URBAN
* YEARS 1970-2018 have data for both variables
*************************************************;
PROC CORR DATA = PROJECT1.EASall COV;
		TITLE "ASIA REGION URBAN and INCOME 1970-2018";	
		WHERE (YEAR BETWEEN 1970 and 2018);
		VAR Income Urban;
RUN;
