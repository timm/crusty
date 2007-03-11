 function inits(flags,str, argp,tmp,n,i,x) {
 	argps(argp,flags);
 	n=split(str,tmp," ");	
 	while(i < n) {
 		i++;
 		x=tmp[i];
 		if (sub(/^-/,"",x)) {
 			if(argp[x]) { 
 				set(x,tmp[i+1]); i++ 
 			 } else  { set(x) }
 		} else {bad("skipping " tmp[i-1] " " x)}
 	}
 }
 function argps(argp,flags, x,n,tmp,i) {
 	n=split(flags,tmp,"");
 	for(i=1;i<=n;i++) 
 		if (tmp[i]==":") 
 			argp[tmp[i-1]]=1
 }
