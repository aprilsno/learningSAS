proc printto log='/home/u49497589/BIOS511/Logs/lab3_730317945.log' 
	new; 
run;

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 3 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-08-25
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer;

* Start of code;

* 1. Assign a libref to access shared file path;

LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 2. Assign a libref to Data folder in BIOS511 folder;

LIBNAME data '/home/u49497589/BIOS511/Data';

* 3. Create a temporary data set with charities data set;

data charities;
set class.charities;
run;

* 4. Create a permanent data set with charities data set;

data data.charities;
set class.charities;
run;

* 5. Run PROC PRINT;

options obs=5;
proc print data=charities;
	title1 "Five Charities";
	footnote "This is the bottom.";
run;

* 6. Run a PROC OPTIONS printing only LISTCONTROL;
proc options group=LISTCONTROL;
run;

* End of code;

ods _all_ close;
proc printto; 
run;