# requirez(bad.awk)
function columnNumbers(str,nums,max, sep,  tmp,i,j,n) {
	sep = sep ? sep : ",";
	n=split(str,tmp,sep);
	for(i in tmp) {
		j =  (tmp[i] < 0) ? tmp[i]+1+max : tmp[i]
	    if ((j > max) || (j< 1)) {
			bad("can't find column " i)
		} else { nums[j]=j }};
	return n;
}
