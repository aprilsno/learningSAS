proc printto log='/home/u49497589/BIOS511/Logs/lab14_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 14 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-10-11
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Send output to pdf file;
ods pdf file = '/home/u49497589/BIOS511/Output/lab14_730317945.pdf';

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* libref for personal data folder;
LIBNAME data '/home/u49497589/BIOS511/Data';
run;

* 1. Create a permanent data set aedm;
proc sort data = class.dm out = dm;
	by usubjid;
run;

proc sort data = class.ae out = ae;
	by usubjid;
run;

data data.aedm;
	merge dm ae;
	by usubjid;
run;

* 2. Run a PROC contents on aedm;
proc contents data = aedm;
	title '2. PROC CONTENTS aedm data';
	ods exclude EngineHost;
run;

* 3. Create a temp data set aedm2;
data aedm2;
	merge dm(in=ind) ae(in=int);
	by usubjid;
	putlog usubjid= ind= int=;
	if ind=1 and int=0;
	keep usubjid sex age;
run;

* 4. Print aedm2 data;
proc print data = aedm2 (obs=10);
	title '4. 10 observations from aedm2';
run;

* 5. Create a permanent data set aedm2;
data data.aedm2;
	merge dm(in=ind) ae(in=int);
	by usubjid;
	putlog usubjid= ind= int=;
	if ind=1 and int=1;
run;

* 6. Create a panel graph of vbar;
proc sgpanel data = data.aedm2;
	title "Vertical Bars for aedm2 Data";
	panelby country arm / columns=2 novarname;
	vbar aesev / group=sex;
run;

* 7. Create a temp data set with vs and new data;
data diabp;
	set class.vs;
	where vstestcd = 'DIABP';
	diabp = vsstresn;
	keep usubjid visitnum visit diabp;
run;

data sysbp;
	set class.vs;
	where vstestcd = 'SYSBP';
	sysbp = vsstresn;
	keep usubjid visitnum visit sysbp;
run;

proc sort data = diabp;
	by usubjid visitnum;
run;

proc sort data = sysbp;
	by usubjid visitnum;
run;

data bp1;
	merge diabp sysbp;
	by usubjid visitnum;
run;

* 8. Print the observations for ECHO-011-015;
proc print data = bp1;
	title "ECHO-011-015 Diastolic and Systolic BP";
	where usubjid = "ECHO-011-015";
run;

* 9. Recreate 7b dataset;
proc sort data = class.vs out = vs;
	by usubjid visitnum;
run;

data bp2;
	merge vs(where=(vstestcd = "DIABP") rename=(vsstresn=diabp)) vs(where=(vstestcd = "SYSBP") rename=(vsstresn=sysbp));
	by usubjid visitnum;
	keep usubjid visitnum visit diabp sysbp;
run;
	
* 10. Run a proc contents on bp2;
proc contents data = bp2;
	title "PROC CONTENTS on bp2 data";
	ods exclude EngineHost;
run;

* End of code;

ods _all_ close;
proc printto; 
run; 