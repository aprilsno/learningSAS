proc printto log='/home/u49497589/BIOS511/Logs/lab15_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 15 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-10-13
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Send output to pdf file;
ods pdf file = '/home/u49497589/BIOS511/Output/lab15_730317945.pdf';

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* libref for personal data folder;
* LIBNAME data '/home/u49497589/BIOS511/Data';
* run;

* 1. Create a temp data set of prostate data;
data prostate;
	set class.prostate;
	length resultingcat $10;
	if stage = 3 and bonemetastastes = 0 then resultingcat = "Acceptable";
		else if stage = 3 and bonemetastastes = 1 then resultingcat = "Bad";
		else if stage = 3 and bonemetastastes = 9 then resultingcat = "Unknown";
		else if stage = 4 and bonemetastastes = 0 then resultingcat = "Bad";
		else if stage = 4 and bonemetastastes = 1 then resultingcat = "Very Bad";
		else if stage = 4 and bonemetastastes = 9 then resultingcat = "Unknown";
	label resultingcat = "Resulting Category";
run;

* 2. Use a proc freq on prostate data;
proc freq data = prostate;
	title "Resulting Category for Prostate Data";
	tables resultingcat;
run;

* 3. Recreate prostate data set with select;
data prostate2;
	set class.prostate;
	length resultingcat $10;
	select;
		when(stage = 3 and bonemetastastes = 0) resultingcat = "Acceptable";
		when(stage = 3 and bonemetastastes = 1) resultingcat = "Bad";
		when(stage = 3 and bonemetastastes = 9) resultingcat = "Unknown";
		when(stage = 4 and bonemetastastes = 0) resultingcat = "Bad";
		when(stage = 4 and bonemetastastes = 1) resultingcat = "Very Bad";
		when(stage = 4 and bonemetastastes = 9) resultingcat = "Unknown";
	end;
	label resultingcat = "Resulting Category";
run;

* 4. Use a proc compare on prostate data sets;
proc compare base=prostate comp=prostate2;
	title "Comparison of Prostate Data Sets";
run;

* 5. Create a temp version of employee_donations;
data donations;
	set class.employee_donations;
	sum1 = sum(qtr1, qtr2, qtr3, qtr4);
	sum2 = qtr1 + qtr2 + qtr3 + qtr4;
	diff = sum1 - sum2;
run;

* 6. Use a proc means on donations data;
proc means data = donations min max mean sum nmiss;
	title "Difference Variable for Donation Sums";
	var diff;
run;

* End of code;

ods _all_ close;
proc printto; 
run; 