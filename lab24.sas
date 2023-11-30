proc printto log='/home/u49497589/BIOS511/Logs/lab24_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 24 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-11-15
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Send output to pdf file;
ods pdf file = '/home/u49497589/BIOS511/Output/lab24_730317945.pdf';

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. Turn on macro debugging variables;
options mprint;
options mlogic;
options symbolgen;

*2. Write a macro program;
%macro q2(lib=, ds=, class=, var=, stat=);
	title "&ds";
	ods noproctitle;
	proc means data = &lib..&ds &stat;
	class &class;
	var &var;
	output out=&ds._stats;
	run;
	proc print data = &ds._stats;
		title "&ds._stats";
		where _type_ = 1 and _stat_ = 'MEAN';
	run;
%mend q2;

* 3. Execute the macro from #2;
%q2(lib=class, ds=budget, class=region qtr, var=yr2019, stat= mean min max);
%q2(lib=sashelp, ds=baseball, class=team, var=crhits crrbi, stat= mean);

* 4. Write a macro program;
%macro q4(ds=);
	title "&ds";
	%if &obs^=0 %then %do;
		proc print data = &ds (obs=5);
		run;
	%end;
%mend q4;

* 5. Execute the macro in #4;
%let obs=0;
%q4(ds=sashelp.cars);
%let obs=1;
%q4(ds=sashelp.class);
	
* End of code;

ods _all_ close;
proc printto; 
run;