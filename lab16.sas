proc printto log='/home/u49497589/BIOS511/Logs/lab16_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 16 
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
ods pdf file = '/home/u49497589/BIOS511/Output/lab16_730317945.pdf';

* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

* 1. Use a proc format to create a format for a numeric variable;
proc format;
	value num
	0 = "No"
	1 = "Yes"
	;
run;
	
* 2. Use a proc format to create a format for a numeric variable;
proc format fmtlib;
	title "2. Catalog with Information About Informats/Formats";
	value school
	0 = "Unknown"
	1 = "High School"
	2 = "College/University"
	3 = "Graduate Studies"
	;
run;

* 3. Create a stacked vbar using sashelp.bweight;
proc sgplot data = sashelp.bweight;
	title "Vertical Bars of bweight data";
	vbar married / group=momedlevel seglabel name="vbar";
	format momedlevel school.;
	format married num.;
	keylegend "vbar"/ across=1 position=NW location=inside;
run;

* 4. Calculate the difference in days between multiple dates in dm;
data dm;
	set class.dm;
	informed = input(rficdtc,yymmdd10.);
	first = input(rfxstdtc, yymmdd10.);
	last = input(rfxendtc, yymmdd10.);
	informedfirst = first - informed;
	lastfirst = last - first;
run;

* 5. Use a proc means on dm;
proc means data = dm;
	title "5. proc means on dm";
	class country sex;
	var informedfirst lastfirst;
run;

* 6. Create a temp version of budget;
data budget;
	set class.budget;
	length change $15;
	percentchange = (yr2019 - yr2018) / yr2018;
	change = put(percentchange, percent8.2);
	label change="Percent Change from 2018 to 2019";
run;

* 7. Print 10 obs from budget data;
proc print data = budget (obs=10) label;
	title "7. 10 observations of budget data";
	var department change;
run;


* End of code;

ods _all_ close;
proc printto; 
run; 