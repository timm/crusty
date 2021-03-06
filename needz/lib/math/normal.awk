# needs globals.awk
#### gaussian stuff

 function gaussianPdf(m,s,x) {
   return 1/(s*sqrt(2*Pi))^(-1*(x-m)^2/(2*s*s))
 }
 function normal(m,s) {
   # pull a number from a normal  distribution
   return m+box_muller()*s;
 }
 function box_muller(m,s,    n,x1,x2,w) {
   w=1;
   while (w >= 1) {
     x1= 2.0 * rand() - 1;
     x2= 2.0 * rand() - 1;
     w = x1*x1 + x2*x2};
   w = sqrt((-2.0 * log(w))/w);
   return x1 * w;
 }
 function mean(sumX,n) {
   return sumX/n;
 }
 function sd(sumSq,sumX,n) {
   # find  sd of a normal distribution
   return sqrt((sumSq-((sumX*sumX)/n))/(n-1));
 }

