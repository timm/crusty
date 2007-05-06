# needz(commandLine.awk)
BEGIN { Who  = "Tim Menzies";
        What = "bars";
        When = "2006";
        How  = "b:cd:hk:m:nst:v:w:";
        Why  = "show column data as histograms";
}
function usage() {  about(Who,What,When,Why);

	prints("Usage: "What" [FLAGS] FILE"," ",
	"FILE is columns of data."," ",
	" -b NUM    width of bars; default=["BarColumnWidth"]",
	" -c        show copyright",
	" -d CHAR   field seperator",
	" -h        show help",
	" -k NUM    width of 'key' column;default=["KeyColumnWidth"]",
	" -m CHAR   character to draw one histogram dot; default=["Mark"]",
	" -n        no sorting of keys",
	" -s        provides mean and standard deviation of each bar",
	" -t NUM    target column; default=["Collect"]",
	" -v NUM    width of 'value' column; default=["ValueColumnWidth"]",
	" -w NUM    width of each data bin; default=["Round"]");
}
function defaults() {
	NoSort = 0;
	ShowMeanSTDEV = 0;
	inits(How,"-b 20 -d , -k 4 -m * -t 2 -v 3 -w 10");
}
function set(x,y) {
	if (x == "b")  {return BarColumnWidth = y};
	if (x == "c")  {copyleft();   exit};
	#if (x == "d")  {return FS=","    };
	if (x == "d")  {return FS = y};
	if (x == "h")  {usage();      exit};
	if (x == "k")  {return KeyColumnWidth = y};
	if (x == "m")  {return Mark = y};
	if (x == "n")  {return NoSort = 1};
	if (x == "s")  {return ShowMeanSTDEV = 1};
	if (x == "t")  {return Collect = y};
	if (x == "v")  {return ValueColumnWidth = y};
	if (x == "w")  {return Round = y};
	bad(x "? usage: " What " " How); exit;
}

