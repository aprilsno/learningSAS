proc printto log='/home/u49497589/BIOS511/Logs/lab2_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 2 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-08-23 
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Run a PROC CONTENTS;
proc contents data=sashelp.demographics;
run;

* Run a PROC PRINT;
proc print data=sashelp.demographics (obs=8);
run;

*Create completely new data;
data Demographics;
	first_name = "Sara";
	last_name = "O'Brien";
	age = 20;
run;

*Run a PROC CONTENTS on new data set;
proc contents data=Demographics;
run;

* End of code; 

ods _all_ close;
proc printto; 
run;
