#requirez(bad.awk)
#requirez(trim.awk)

function table(arr,header,body,   \
		names,rows,\
        rowName,col,row,  \
		data,i,j,m,n,key,datum) {
	m=split(header,names,/,/);
	names[0]=m;
	for(i=1;i<=m;i++) 
		names[i] = trim(names[i]);
	key=names[1];
	n=split(body,data,/,/);
	if (n % m) 
		bad("table rows don't hold "m" items");
	j=1;
	for(i=1;i<=n;i++) {
		datum = trim(data[i]);
		if (j==1) {
			rowName=datum
			rows[++rows[0]]=datum;
		} else {
			col=names[j];
			if(datum != "") 
				arr[key,rowName,col]=datum
		}
		j= (j==m) ? 1 : j + 1;
	}}
