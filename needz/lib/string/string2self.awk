 function string2self(words,str,sep,  tmp,i) {
	 split(str,tmp, sep ? sep : "," );
	 for(i in tmp)
		 words[tmp[i]]=tmp[i];
 }

