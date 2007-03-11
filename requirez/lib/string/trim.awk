#<h3>trim.awk</h3> Trim whitespace.

 function trim(str) { 
	sub(/^[ \t]*/,"",str); 
	sub(/[ \t]*$/,"",str); 
	return str 
 }

