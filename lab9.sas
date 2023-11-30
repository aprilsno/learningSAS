proc printto log='/home/u49497589/BIOS511/Logs/lab9_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 9 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-09-20
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

** 1. Create an rtf file;

ods rtf file = '/home/u49497589/BIOS511/Output/lab9_730317945.rtf';

* Run a proc univariate on sashelp.bweight;

proc sort data = sashelp.bweight out = bweight;
	by momedlevel;
run;

proc univariate data = bweight plots;
	title 'Plots of bweight Data'; 
	by momedlevel;
	var momwtgain;
	ods select plots; 
run;

* Run a proc freq on dm;

LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

proc freq data = class.dm;
	title 'Race by armcd in dm Data';
	tables armcd*race / norow nocol plots=(freqplot(groupby=row twoway=cluster));
run;

* Run a proc freq on sashelp.bweight;

proc freq data = sashelp.bweight;
	title 'Agree Plot for bweight Data';
	tables momsmoke*boy / agree plots=(agreeplot);
run;

* End code;

ods _all_ close;
proc printto; 
run; 