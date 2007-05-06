 function string2pairs(pairs,str,   sep,   n,i,tmp) {
  # generate list of booleans keyed by sub-strings of "str"
	 n=split(str,tmp, (sep ? sep : ","));
	 for(i=1;i<=n;i=i+2) pairs[tmp[i]]=tmp[i+1];
	 return n;
 }
