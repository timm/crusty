# <h3> copy.awk</h3>
# Empty the second argument, then fill it up only with the first.

 function copy(a,b,  i) { 
	 array(b);
	 for(i in a) 
		 b[i]=a[i];
 }

