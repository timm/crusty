function push(x,a)     { a[++a[0]]=x; return a[0] }
function pop(a,emptyp) { return ((a[0] > 0) ? a[a[0]--] : emptyp) } 
