proc printto log='/home/u49497589/BIOS511/Logs/lab6_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 6 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-09-08
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

** 1. Run a PROC MEANS on budget data;

* pull data from course folder; 
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

proc means data=class.budget css q3 median uclm lclm mode;
	title "Six Statistics on Budget Data Set";
run;

** 2. Run a PROC MEANS on budget data;

proc means data=class.budget n sum mean;
	title "Budget Data by Department for 2019 and 2020";
	class department;
	var yr2019 yr2020;
run;

** 3. Run a PROC MEANS on sashelp.orsales;

proc means data=sashelp.orsales noprint nway;
	where year = 2002;
	class product_line product_category;
	var quantity profit total_retail_price;
	output out = orsales sum= /autoname;
run;

** 4. Run a PROC PRINT on orsales;

proc print data = orsales noobs;
	title "Orsales Data";
	where product_category = "Racket Sports";
	format profit_sum dollar12.2;
	var product_line product_category profit_sum;
run;

** 5. Modify code from #3;

proc means data=sashelp.orsales noprint nway sum mean;
	where year = 2002;
	class product_line product_category;
	var profit total_retail_price;
	output out = orsales2 sum=Sum mean=Mean;
run;

proc print data = orsales2;
	title "Orsales Data 2.0";
run;

** 6. Run a PROC UNIVARIATE on budget;

proc sort data = class.budget out = budget;
	by department;
run;

proc univariate data = budget cibasic;
	title "PROC UNIVARIATE on Budget Data";
	by department;
	var yr2020;
run;

** 7. Create a histogram for budget;

proc univariate data = budget noprint;
	title "Budget Histogram";
	histogram;
		inset mean std / position=NW;
	class department;
	var yr2020;
run;

* End of code;

ods _all_ close;
proc printto; run;