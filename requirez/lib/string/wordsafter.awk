 function lineAfter(x,  sep,i,str) {
	for(i=x+1;i<=NF;i++) { 
		str = str sep $i;
		sep = " "
	}
	return str
 }
 function arrayAfter(x,l,  n,sep,i,str) {
	n=l[0];
	for(i=x+1;i<=n;i++) { 
		str = str sep l[i];
		sep = " "
	}
	return str
 }
