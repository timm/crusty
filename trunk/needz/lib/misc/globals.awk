#<h3>globals.awk</h3>
#Create some handy globals.

 function globals() { 
    #  Magic array positions (should all be < 0 so index==0 is an error):  #{
	N = -1;  # height of stack (number of rows);
	M = -2;  # breadth of array (number of colums)
    # Numeric constants: #{
	Inf    = 10^32;
	NegInf = -1 * Inf;
	Ee     = 848456353 / 312129649;
	Pi     = 428224593349304 / 136308121570117; # good to 29 digits
    # Some useful strings: 
		Sp     = " ";
	Q      = "\"";
	_      = SUBSEP; 
	Zero   = "0 ";
	White  = "^[ \t\n\r]*$";
	Number = "[+-]?([0-9]+[.]?[0-9]*|[.][0-9]+)([eE][+-]?[0-9]+)?";
	Integer = "[+-]?[0-9]+";
}

