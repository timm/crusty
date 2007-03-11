#<h3>s2b.awk</h3> Convert strings to arrays.

 function s2b(s,a,c,  tmp,i) { 
	 split(s,tmp,c);
	 for(i in tmp) 
		 a[tmp[i]]=1;
 }

