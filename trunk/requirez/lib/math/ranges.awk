 function from(x,y,z) {
   return (z >= x && z <= y) ? z : bad(z " not in [" x ".." y "]");
 } 
 function round(x) {
   return x<0 ? int(x-0.5) : int(x+0.5)
 } 
 function between(min,max) {
   return max==min ?  min : min + ((max-min)*rand())
 } 
 function most(x,y)  { return x > y ? x : y }
 function least(x,y) { return x < y ? x : y }
 
 function within(min,max,bias) {
   # pick a number between "min" and "max", with a little "bias"
   return min + (max - min)*rand()^bias
   # if bias = A >= 1 then mean = (max+min)*B is towards to "min" end
   #          BIAS                         mean
   #          ----                         ----
   #           1                           0.5
   #           2                           0.33
   #           3                           0.25
   #           4                           0.2
   #           5                           0.17
   #           6                           0.14
   #           7                           0.13
   #           8                           0.11
   #           9                           0.10
   #           10                          0.09
 
   # if bias = A < 1 then mean = (max+min)*B is towards the "max" end
   #          BIAS                         mean
   #          ----                         ----
   #           0.5                         0.67
   #           0.33                        0.75
   #           0.25                        0.8
   #           0.2                         0.83
   #           0.167                       0.86
   #           0.14                        0.87
   #           0.125                       0.89
   #           0.11                        0.9
   #           0.10                        0.91
 }
