proc printto log='/home/u49497589/BIOS511/Logs/lab5_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 5 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-09-01
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

** 1. run a PROC PRINT on sashelp.failure;

* sort data in a temporary data set;
proc sort data = sashelp.failure out = tempfailure;
	by cause;
run;

* run the proc print;
proc print data = tempfailure;
	title "Day and Count of Failures by Cause";
	by cause;
	var day count;
run;

** 2. run a proc print on employee_donations;

* pull data from course folder; 
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

/* look at variable names;
proc contents data = class.employee_donations;
run; */

* run the proc print;
proc print data = class.employee_donations noobs label;
	title "Employee Donations";
	options missing = "0";
	format Qtr1 Qtr2 Qtr3 Qtr4 dollar8.2;
	label Paid_By = 'Type of Payment';
	var paid_by recipients qtr1 qtr2 qtr3 qtr4;
	sum qtr1 qtr2 qtr3 qtr4;
run;

* 3. determine gender distribution within customer_dim;

/* see variable names;
proc contents data = class.customer_dim;
run; */

* run a proc sort to remove duplicates;
proc sort data = class.customer_dim nodupkey out = tempcustomer_dim;
	by customer_name;
run;

* run proc freq;
proc freq data = tempcustomer_dim;
	title 'Customer Gender Frequencies';
	tables customer_gender;
run;
	
** 4. run a proc freq on gender and age;
proc freq data = tempcustomer_dim;
	title 'Customer Gender and Age Group Frequencies';
	tables customer_gender*customer_age_group;
run;

** 5. run a proc freq on customer type and customer group;
proc freq data = tempcustomer_dim;
	title 'Customer Type and Group Frequencies Tables';
	tables customer_type*customer_group / LIST ;
	where customer_age > 50;
	tables customer_group*customer_type / LIST ;
run;

** 6. run a proc freq on migraine dataset;

/* run a proc contents to see variable names;
proc contents data = class.migraine;
run; */

* run a proc freq with Cochran-Mantel-Haenszel;
proc freq data = class.migraine;
	title 'Treatment and Response Frequencies and Cochran-Mantel-Haenszel';
	tables treatment*response / CMH relrisk;
run;

ods _all_ close;
proc printto; run; 