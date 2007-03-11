# <h3>keys.awk</h3>
# Empty the second argument, then fill it up only with the keys from the first.

 function keys(a,k, i) {
  array(k);
  for(i in a)
    if(i > 0)
      Push(i,k);
 }

