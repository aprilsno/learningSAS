proc printto log='/home/u49497589/BIOS511/Logs/lab20_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 20 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-11-01
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Send output to pdf file;
ods pdf file = '/home/u49497589/BIOS511/Output/lab20_730317945.pdf';

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. Use proc transpose on budget;

proc sort data = class.budget out = budgetsort;
	by region;
run;

proc transpose data = budgetsort out = budget_trans (rename= (_name_ = year));
	by region;
	id department;
	var yr2016 yr2017 yr2018 yr2019 yr2020;
run;

* 2. Print transposed budget;

proc print data = budget_trans (obs=3);
	title "3 observations of transposed budget data";
run;
	
* 3. Use proc transpose on stocks;

proc sort data = sashelp.stocks out = stocks;
	by date;
run;

proc transpose data = stocks out = stocks_trans (drop = _name_);
	by date;
	id stock;
	var open;
run;

* 4. Create a series graph on stocks_trans;

proc sgplot data = stocks_trans;
	title "Series graph of intel stock data";
	series x = date y = intel;
run;

* 5. Use data step on budget data;

data budget;
	set class.budget;
	where department = 'A';
	length year 4.;
	array years{5} yr2016-yr2020;
	do i = 1 to 5;
		year = 2015 + i ;
		* better code: year = input(substr(vname(years{i}), 3), 8.);
		budget = years{i};
		output;
	end;
	format budget dollar10.;
	keep region qtr year budget;
	label region = "Region" qtr = "Quarter" year = "Year" budget = "Budget";
run;

* 6. Run a proc contents on budget;

proc contents data = budget;
	title "PROC CONTENTS on budget data";
	ods select variables;
run;
	

* End of code;

ods _all_ close;
proc printto; 
run;