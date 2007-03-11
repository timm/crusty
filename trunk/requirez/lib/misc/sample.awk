# i in all
# cdf[i,0]=range
# j in 1 .. i
# cdf[i,j,"key"] 
# cdf[i,j,"value"]

 function sample(r,all,cdf) { 
	while(r--) 
		sample1(all,cdf) 
 }
 function sample1(all,cdf,cache,  one) { 
	for(one=1;one<=all;one++) 
		cache[one]=sample2(one,cdf) 
 }
 function sample2(i,cdf,     enough,j,max) {
	max    = cdf[i,0];
	enough = rand(); 
	for(j=1;j<=max;j++) 
		if (cdf[i,j,"value"] >= enough)
			return cdf[i,j,"key"];
	return cdf[i,max,"key"]
 }	
