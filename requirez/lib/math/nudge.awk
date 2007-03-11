#requirez(normal)
#requirez(ranges)
#requirez(globals)

 function gaussian(m,std,nudgep,old,nudge,   delta,up,down,got,retries) {
 	if (nudgep) {
 		delta = normal(1,nudge);
 		up    = old + (std * delta);
 		down  = old - (std * delta);
 		retries = 128;
 		while(retries-- ) {
 			got=normal(m,std);
 			if (got >= down && got <= up) return got;
 		}
 		return old;
 	} else {
 		return normal(m,std)
 	}
 }
 function ratio(min,max,nudgep,old,nudge,  delta) {
   if (min==max)
     return min;
   if (nudgep) {
     delta=(max-min)*nudge/2;
     min=most(min,old-delta);
     max=least(max,old+delta);
   };
   return between(min,max);
 }
 
 function ratioInt(min,max,nudgep,old,nudge,   out,delta,aLittle) {
   if(min==max)
     return min;
   if (nudgep) {
     delta=(max-min)*nudge/2;
     min=most(min,old-delta);
     max=least(max,old+delta);
   }
   else {
     aLittle = 0.499999;
     min=min - aLittle;
     max=max + aLittle;
   };
   return round(between(min,max));
 }
 
 function ordinal(range,nudgep,old,nudge,   i,j,dim) {
    dim=range[_n];
    if (nudgep) {
      i=indexOf(old,range);
      j=ratioInt(1,dim,1,i,nudge);
    }
    else {
      j=ratioInt(1,dim);
    };
    return range[j];
  }
 
 function nominal(range,nudgep,old,nudge) {
   if (nudgep && nudge==0) {
     return old}
   else { return ordinal(range,nudgep,old,nudge)}
 }
 
 function indexOf(x,range,i) {
   for(i in range) {
     if (i < 0 ) continue;
     if (range[i]==x) return i;
   };
   bad(x " not in range \n");
 }

