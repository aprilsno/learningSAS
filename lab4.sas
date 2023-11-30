proc printto log='/home/u49497589/BIOS511/Logs/lab4_730317945.log' 
	new; 
run;

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 4 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-08-30
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* reference shared data folder;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. run a proc sort on customer_dim by last name;
proc sort data = class.customer_dim out = custdim_lastname;
	by Customer_LastName;
run;

* 2. run a proc sort on customer_dim by customer group and type;
proc sort data = class.customer_dim out = custdim_grouptype (keep=Customer_Group Customer_Type);
	by Customer_Group Customer_Type;
run;

* 3. run a proc sort on customer_dim by descending age;
proc sort data = class.customer_dim out = custdim_age;
	by descending Customer_Age;
run;

* reference personal data folder;
LIBNAME data '/home/u49497589/BIOS511/Data';
run;

* 4. run a proc sort on customer_dim by ID with only male customers;
proc sort data = class.customer_dim out = data.custdim_male;
	where Customer_Gender = 'M';
	by Customer_ID;
run;

* 5. run a proc contents on data set in #1 with VARNUM option;
proc contents data = custdim_lastname VARNUM;
	title1 'PROC CONTENTS on Customer_Dim Data Sorted by Last Name';
run;

* 6. run a proc contents on data set in #1 with noprint;
proc contents data = custdim_lastname noprint out = custdim_lastname2;
run;

ods _all_ close;
proc printto; run; 