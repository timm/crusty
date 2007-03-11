#<h3>size.awk</h3>

 function unempty(a,  i) { for(i in a) return 1; return 0 }
 function empty(a)       { return ! unempty(a) }

