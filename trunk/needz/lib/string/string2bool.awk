 function string2bool(bools,str,   n,i,tmp) {
    # generate list of booleans keyed by sub-strings of "str"
	 n=split(str,tmp,/,/);
	 for(i=1;i<=n;i++) bools[tmp[i]]=1;   
 }  

