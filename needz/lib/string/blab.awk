#<h3>Stuff</h3>

 function blab(str) {
   printf str >> "/dev/stderr";
   fflush("/dev/stderr");
 }
  function blabln(str) {
	blab(str"\n")
 }
 
