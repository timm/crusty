 function namesAllUnique(f,names,all,unique,   lines) {
	while(getline < f) 
	    namesAllUnique1(++lines,names,all,unique)
 }

 function namesAllUnique1(line,names,all,unique, i) {
	if (line<2) { 
		for(i=1;i<=NF;i++)  {
			names[i]=$i; 
			names[$i]=i; 
		}
		names[0]=NF;
		return 1
	} 
	for(i=1;i<=NF;i++) 
		if (++all[i,$i] == 1 ) 
			unique[i,++unique[i,0]] = $i;
 }

