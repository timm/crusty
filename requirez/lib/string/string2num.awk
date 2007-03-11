 function string2num(nums,str,   n,i,tmp) {
     # generate list of booleans keyed by sub-strings of "str"
	 n=split(str,tmp,/,/);
	 for(i=1;i<=n;i++) nums[tmp[i]]=i;
	 return n;
 }

