# requirez(str.awk)
 BEGIN {CONVFMT=OFMT="%-20.20g"}
 function cdfs(i,all,unique,cdf,\
		       j,jmax,k,l,sum,some,emos,new,cumm) {
	jmax=unique[i,0];
	for(j=1;j<=jmax;j++) {
		k      = unique[i,j];
        l      = all[i,k] + rand()/10^9 ;
		sum   += l;
	    some[k]=l
	    emos[l]=k
    }
	jmax=asort(some)		
	for(j=1;j<=jmax;j++) {
		k    = emos[some[j]];
		new  = ++cdf[i,0]
	   	cumm += some[j]/sum;
		cdf[i,new,"key"  ] = k;
        cdf[i,new,"value"] = cumm;
	}
 }
 function printCdf(names,cdf,char,   show,now,b4,val,i,imax,j,jmax,com) {
	imax=names[0];
	com="sort -t: -n +0 | malign -b : -o ' '"
		for(i=1;i<=imax;i++) {
			print "";
			jmax=cdf[i,0];
			for(j=1;j<=jmax;j++) { 
				now = cdf[i,j,"value"]; 
				b4  = cdf[i,( j - 1 ), "value"];
				val = (j> 1 ? now - b4 : now)
				show = int(50*val)
				#val = 50*int(now)
				printf("%s : %s : %s % : %s\n",
						Aka[names[i]],
						cdf[i,j,"key"],
						int(100*val),
						str(show,char) str(50-show,".")) | com
			}
			close(com)
		}
 }
function cdf2File(f,names,cdf,   i,imax,saved) {
	printf "" > f;
	imax=names[0];
	saved = OFMT;
	OFMT = "%3.1f"
	for(i=1;i<=imax;i++) 
		print  names[i] cdf2File1(i,cdf[i,0],cdf) >> f
	close(f)
	OFMT = saved;
}		
function cdf2File1(i,jmax,cdf,     j,k,cumm,new,line) {
	for(j=1;j<=jmax;j++) {
		k    = cdf[i,j,"key"];
		cumm  = cdf[i,j,"value"];
		new  = j == 1 ? cumm : (cumm - cdf[i,(j-1),"value"]);
		line = line OFS k OFS sprintf("%5.2f",new);
	}
	return line
}
function file2Cdf(f,names,cdf,    x,lines) {
	while(getline  < f) 
		file2Cdf1(++lines,names,cdf)
	names[0]=lines;
}
function file2Cdf1(i,names,cdf,   all,unique,\
                    keyi,vali,key,val,fields,f) {
	names[i]=$1;
	names[$1]=i;
	fields=(NF-1)/2
	for(f=0;f<fields;f++) {
		keyi = 2 + f*2;
		vali = keyi + 1;
		key = $keyi  ;
		val = $vali  ;
		all[i,key]=val
		unique[i,++unique[i,0]]=key
	}
	cdfs(i,all,unique,cdf)
}
