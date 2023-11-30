proc printto log='/home/u49497589/BIOS511/Logs/lab22_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 22 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-11-08
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

* Send output to pdf file;
ods pdf file = '/home/u49497589/BIOS511/Output/lab22_730317945.pdf';

/* Pull in course data;
LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run; */

* 1. Import country.dat file using proc import;

proc import datafile='/home/u49497589/my_shared_file_links/u49231441/Data/country.dat'
	out=country1
	replace 
	dbms=dlm;
	delimiter = '!';
	getnames=no;
run;

* 2. Modify country data set; 

data country1_labeled;
	set country1;
	rename var1 = abbreviation var2 = country;
	label var1 = 'Abbreviation' var2 = 'Country';
run;

* 3. Read in country.dat in data step;

filename cntry '/home/u49497589/my_shared_file_links/u49231441/Data/country.dat';

data country2;
	infile cntry dlm='!';
	length var1 $2 var2 $20;
	input var1 var2;
	label var1 = 'Abbreviation' var2 = 'Country';
run;

* 4. Run a proc compare;

proc compare base=country1 compare=country2;
	title "4. Comparing country data sets";
run;

* 5. Create a format from variables in data set;

data question5;
	set country1;
	start = var1;
	label = var2;
	fmtname = '$cnty';
	retain fmtname;
run;

proc format cntlin=question5 lib=work fmtlib;
	title "5b. Generating a format";
run; 

* 6. Use datalines to hold a class schedule;

data schedule;
	length classname $7 sectiontype $7 building $20 room 4. day $9 starttime 8.;
	input classname sectiontype building room day starttime time10.;
	label classname = "Class Name" sectiontype = "Section Type" building = "Building" room = "Room" day = "Day of the Week" starttime = "Start Time";
	format starttime time.;
	datalines;
BIOS511 Lecture McGavran-Greenberg 2301 Monday 9.05
BIOS511 Lab Rosenau 0228 Monday 10.10
SPHG351 Lecture Rosenau 0228 Monday 11.15
SPAN381 Lecture Dey 0301 Monday 1.25
BIOS650 Lecture McGavran-Greenberg 2308 Tuesday 9.30
BIOS512 Lecture McGavran-Greenberg 2308 Tuesday 11.00
BIOS511 Lecture McGavran-Greenberg 2301 Wednesday 9.05
BIOS511 Lab Rosenau 0228 Wednesday 10.10
SPAN381 Lecture Dey 0301 Wednesday 1.25
BIOS650 Lecture McGavran-Greenberg 2308 Thursday 9.30
BIOS512 Lecture McGavran-Greenberg 2308 Thursday 11.00
SPHG351 Lecture Rosenau 0228 Friday 11.15
;

* 7. Print the data set in 6;

proc print data = schedule noobs label;
	title '7. My class schedule';
run;

* End of code;

ods _all_ close;
proc printto; 
run;