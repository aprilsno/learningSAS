proc printto log='/home/u49497589/BIOS511/Logs/lab21_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 21 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-11-03
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Send output to pdf file;
ods pdf file = '/home/u49497589/BIOS511/Output/lab21_730317945.pdf';

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. Count of severity for AEs;

proc sort data = class.ae out = aesort;
	by aesoc aeterm aesev;
run;

data ae;
	set aesort;
	by aesoc aeterm aesev;
		array severity{3} $ _temporary_ ('MILD' 'MODERATE' 'SEVERE');
		array vars{3} mild moderate severe;
		retain mild moderate severe 0;
		
		if first.aeterm then do i=1 to dim(vars);
			vars{i} = 0;
		end;
		
		do i=1 to dim(severity);
			if aesev = severity{i} then vars{i} = vars{i} + 1; 
		end;
		
	if last.aeterm;
	keep aeterm aesoc mild moderate severe;
run;
	
* 2. Print bronchitis data;

proc print data = ae;
	title "2. Bronchitis Severity Counts";
	where aeterm = "Bronchitis";
run;

* 3. Restructure lb data set;

proc sort data = class.lb out = lbsort;
	by usubjid visitnum visit lbtestcd;
run;

data lb;
	set lbsort;
	by usubjid visitnum visit lbtestcd;
		array test{3} $ _temporary_ ('ALB' 'CA' 'HCT');
		array vars{3} ALB CA HCT;
		retain ALB CA HCT;
		
		if first.usubjid then do i=1 to dim(vars);
			vars{i} = .;
		end;
		
		do i=1 to dim(test);
			if lbtestcd = test{i} then vars{i} = lbstresn; 
		end;
		
	if last.visitnum;
	keep usubjid visit visitnum alb ca hct;
run;

* 4. Print ECHO-012-001 data;

proc print data = lb;
	title "Subject ECHO-012-001 Lab Results";
	where usubjid = "ECHO-012-001";
run;

* 5. Create a data set based on prostate;

data prostate;
	set class.prostate;
	output;
	treatment=99; output;
run;
	
* 6. Use a proc freq to get number of patients for each treatment;

proc freq data = prostate;
	title "Number of Patients per Treatment";
	tables treatment;
run;

* End of code;

ods _all_ close;
proc printto; 
run;