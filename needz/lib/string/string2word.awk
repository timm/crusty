 function string2word(words,word,str,  tmp,i) {
	 split(str,tmp,/,/);
	 for(i in tmp)
		 words[tmp[i]]=word;
 }
