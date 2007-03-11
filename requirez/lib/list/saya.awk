#<h3>saya.awk</h3>
#Print a string in key-sort order.

 function saya(s,a,q1,q2,eol,    com,i,j,n,tmp,str,sep) {
	 com="sort";
	 q1= q1 ? "\"" : "";
	 q2= q2 ? "\"" : "";
	 for(i in a) {
		 sep="";
		 str= s"[";
		 n=split(i,tmp,SUBSEP);
		 for(j=1;j<=n;j++) {
			 str=str sep q1 tmp[j] q1;
			 sep=",";
		 }
		 print str "] = " q2 a[i] q2 eol  | com;
	 };
	 close(com);
 }

