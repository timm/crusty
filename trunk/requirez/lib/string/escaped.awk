# requirez(string2self)

 BEGIN {
 	string2self(Escaped,"* $ ^ . ?"," ");
 }
 function escaped(x) {
 	return  (x in Escaped) ? "\\" x : x;
 }
