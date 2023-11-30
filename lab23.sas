proc printto log='/home/u49497589/BIOS511/Logs/lab23_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 23 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-11-10
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. Create a macro variable to hold your PID;

%let pid = 730317945;

* 2. Create a macro variable to hold path to output files;

%let output = /home/u49497589/BIOS511/Output;

* 3. Use the macro variables in ODS pdf statement;

ods pdf file = "&output./lab23_&pid..pdf";

* 4. Create a macro variable with text as first title in all generated output;

%let title = BIOS 511 LAB 23 Macro Variables;

* 5. Put patient counts for each treatment into macro variables;

proc means data = class.prostate noprint;
	class treatment;
	output out=treatment n=counts;
run;

data _null_;
	set treatment;
	if treatment = "." then call symputx('tot99', counts);
		else call symputx(cats('tot', treatment), counts);
run;
	
* 6. Write the values of the macro variables to the log;

%put tot99 = &tot99 tot1 = &tot1 tot2 = &tot2 tot3 = &tot3 tot4 = &tot4;

* 7. Generate a horizontal bar of the frequency of stage variable;

proc sgplot data = class.prostate;
	hbar stage;
	title1 "&title.";
	title2 "&tot99";
run;

* 8. Create a macro with list of names of char variables in dm;

proc contents data=class.dm out=dm(where=(type=2)) noprint;

proc sort data=dm; 
	by varnum;

data _null_;
 set dm end=finish;
 length varnames $1000;
 retain;
 	varnames = catx(' ',varnames,name);
 if finish then
 	call symputx('list', varnames);
run;

* %put list = &list;

* 9. Use macro variable from 8;

data lowcaselist;
	set class.dm;
	array vars(13) &list;
	do i = 1 to 13;
		vars{i} = lowcase(vars{i});
	end;
	drop i;
run;

* 10. Print 5 observations from 9;

proc print data = lowcaselist (obs=5) noobs;
	title1 "&title.";
	title2 "10. 5 Observations of Lowercase dm data";
	var &list;
run;

* 11. Create a series of macro variables;

proc sort data=class.vs(keep=vstestcd vstest) out=vs nodupkey;
 by vstestcd;
run;

data _null_;
 set vs;
 call symputx(cats('vstest', _n_), vstestcd);
 call symputx(cats('vsname', _n_), vstest);
run;

* %put vstest1 = &vstest1 vsname1 = &vsname1;

* 12. Create a proc report on vs data;

proc report data = class.vs;
	title1 "12. &title.";
	title2 "&vsname1.";
	where vstestcd = "&vstest1";
	column visitnum visit vsstresn;
	define visitnum / group noprint;
	define visit / group;
	define vsstresn / mean "VS Result";
run;

* 13. Repeat for remaining vstest values;

* vstest2;
proc report data = class.vs;
	title1 "13. &title.";
	title2 "&vsname2.";
	where vstestcd = "&vstest2";
	column visitnum visit vsstresn;
	define visitnum / group noprint;
	define visit / group;
	define vsstresn / mean "VS Result";
run;

* vstest3;
proc report data = class.vs;
	title1 "13. &title.";
	title2 "&vsname3.";
	where vstestcd = "&vstest3";
	column visitnum visit vsstresn;
	define visitnum / group noprint;
	define visit / group;
	define vsstresn / mean "VS Result";
run;

* vstest4;
proc report data = class.vs;
	title1 "13. &title.";
	title2 "&vsname4.";
	where vstestcd = "&vstest4";
	column visitnum visit vsstresn;
	define visitnum / group noprint;
	define visit / group;
	define vsstresn / mean "VS Result";
run;

* vstest5;
proc report data = class.vs;
	title1 "13. &title.";
	title2 "&vsname5.";
	where vstestcd = "&vstest5";
	column visitnum visit vsstresn;
	define visitnum / group noprint;
	define visit / group;
	define vsstresn / mean "VS Result";
run;

* End of code;

ods _all_ close;
proc printto; 
run;