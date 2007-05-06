# needz(commandLine.awk)

BEGIN { Who  = "Tim Menzies";
        What = "malign";
        When = "2006";
        How  = "cht:b:o:w:g:r";
		Why  = "align columns in a text file";
}
function usage() {  
	about(Who,What,When,Why);  
	prints("Usage: "What" [FLAGS] ",
			" -r        raw mode: turns off cell trimming",
			" -w NUM    minimum column width",      
			" -g NUM    minimum gutter width",      
			" -b CHAR   input  file sepertor",
			" -o CHAR   output file sepertor",
			" -c        show copyright",
			" -h        show help");
}
function defaults() {
	inits(How,"-w 1 -g 1 -b , -o ,");
}
function set(x,y) {
   if (x == "r")  {return set("t",0) };
   if (x == "t")  {return Trim    = y};
   if (x == "w")  {return Width   = y};
   if (x == "g")  {return Gutter  = y};
   if (x == "b")  {return FS      = y};
   if (x == "o")  {return OFS     = y};
   if (x == "c")  {copyleft();   exit};
   if (x == "h")  {usage();      exit};
   bad("usage: " What " " How);  exit;
}
