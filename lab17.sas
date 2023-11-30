proc printto log='/home/u49497589/BIOS511/Logs/lab17_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 17 
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
ods pdf file = '/home/u49497589/BIOS511/Output/lab17_730317945.pdf';

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. Create a new temp data set of dates;
data dates;
	format date date9.;
	do date = "01Oct2021"d to "31Dec2021"d;
		u = rand("Uniform");
		output;
	end;
run;

* 2. print November records;
proc print data = dates noobs;
	title "2. November Dates and Random Numbers";
	where date > "31Oct2021"d and date < "01Dec2021"d;
	format u 5.3;
run;

* 3. Create a temporary data set with sashelp.stocks;
data stocks;
	set sashelp.stocks;
	where stock = "IBM" and date = "01Dec05"d;
	do i = 1 to 5;
		adjclose = adjclose * 1.11;
		date = intnx('year', '01Dec05'd, i);
		output;
	end;
	keep stock date adjclose;
run;

* 4. Print stocks data;
proc print data = stocks;
	title "4. Stocks Data";
run;

* 5. Modify #3;
data stocks2;
	set sashelp.stocks;
	where stock = "IBM" and date = "01Dec05"d;
	i = 0;
	do until(adjclose > 200);
		i = i + 1;
		adjclose = adjclose * 1.11;
		date = intnx('year', '01Dec05'd, i);
		output;
	end;
	keep stock date adjclose;
run;

* 6. Print #5;
proc print data = stocks2;
	title "6. Stocks Data w/ Conditional Do Loop";
run;

* 7. Use a data _null_ and putlog;
data _null_;
	set class.prostate;
	where age > 85 and stage = 3 and treatment = 4;
	putlog patientnumber=;
run;

* End of code;

ods _all_ close;
proc printto; 
run; 