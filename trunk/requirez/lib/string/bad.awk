#<h3>Stuff</h3>

 function bad(str) {
   print str >> "/dev/stderr";
   fflush("/dev/stderr");
   Errors++;
   Patience--;
 }
 function imPatient() {
   if (Patience<=0) {
     print "Aborting" >> "/dev/stderr";
     fflush("/dev/stderr");
     exit 1 }
 }
 
 function badIf(check,txt) {
    if (check) bad(txt); return check;
 }
 
