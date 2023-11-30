proc printto log='/home/u49497589/BIOS511/Logs/lab10_730317945.log' 
	new; 
run; 

/**************************************************************************** 
* 
* Project 		: BIOS 511 Course 
* 
* Program name 	: Lab 10 
* 
* Author 		: Sara O’Brien
* 
* Date created 	: 2021-09-22
*  
*****************************************************************************/

%put %upcase(no)TE: Program being run by 730317945;
options nofullstimer; 

* Start of code;

ods pdf file = '/home/u49497589/BIOS511/Output/lab10_730317945.pdf';

LIBNAME class '~/my_shared_file_links/u49231441/Data' access=readonly;
run;

** 1. Create a horizontal bar chart with proc sgplot;

proc sgplot data = class.employee_donations;
	title 'Horizontal Bar Chart of Employee Donations Data';
	hbar paid_by / response=qtr4 dataskin=matte stat=sum;
run;

** 2. Create overlaid vbars with proc sgplot;

proc sgplot data = sashelp.cars;
	title 'Overlaid Vertical Bar Charts of Cars Data';
	vbar origin / response=msrp stat=sum transparency=0.3;
	vbar origin / response=invoice stat=sum transparency=0.3 barwidth=0.5;
run;

** 3. Summarize the vs data set;

proc means data = class.vs noprint nway;
	class vstestcd vstest visitnum visit;
	var vsstresn;
	output out = vstemp mean=Mean;
run;

** 4. run a proc splot on vstemp;

proc sgplot data = vstemp noautolegend;
	title 'Series and Scatterplot of vs Data';
	where vstestcd = 'HR';
	series x=visit y=mean;
	scatter x=visit y=mean / markerattrs= (symbol=diamond);
	yaxis values= (59.9 to 60.3 by .05) label = 'Heart Rate';
run;

* End of code;

ods _all_ close;
proc printto; run;