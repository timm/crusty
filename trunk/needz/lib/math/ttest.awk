#A t-test implementes a _I(hypothesis test)
#that accepts or rejects the null hypothesis at some I(confidence level) that
#the means of two distributions are the same.
#Only if the t-test rejects the null hypothesis can we
#make statements like the mean of one distribution is different to another.

 ##_ROOT/bin/ttest1.awk
 function compare(mean,sd,k,alpha) {
   if ( same(mean,sd,k,alpha) ) return  0;
   if ( mean < 0 ) return -1;
   if ( mean > 0 ) return 1;
 }

#Two parameters control the t-test. Firstly, there is the _I(confidence)
#level. 

 BEGIN {  Alpha=0.05 } ## default confidence levels

#Secondly, there is the degrees of  freedom _I(k) in the test. _I(K)  is
#one minus the sample sample _I(n) from the distributions. 
#So, 
#to check if two distributions  are the same, we compare the t-value (_I(tval))
#against a threshold value from the _I(t-tables).  

 function same(mean,sd,k,alpha,  t) {
  if (!sd) return (mean==0); ## same if no deviation and zero mean
  t = tval(mean,sd,k+1);
  t = t<0 ? -1*t : t;
  return t < t2table(k,alpha);
 }

#The _I(tval)
#is calculated as follows:

 function tval(mean,sd,n)  { return mean/(sd/sqrt(n)) }

#The t-table value is calculated from a set of fixed values.
#If the target value is not in the table, then we extraplote
#between known values.

 function t2table(f,l,   r) {
   if ( ( l != 0.05 && l != 0.01 )  || f < 1 ) {
     print "ttest internal panic!"; exit -1};
   if (f < 31) {return T2[f,l]};
   if (f < 101) {f=int(f/5)*5; return T2[f,l]};
   if (f < 350) { return T2[200,l] };
   if (f < 750) { return T2[500,l] }
   r=T2[1000,l];
   if (!r) 
     print "ERROR in t-test; unknown alpha="alpha" degrees="k " values";
   return r;
 }

 BEGIN { ## magic thresholds for 95 and 99% confidence tests.
   T2[1,0.05] = 12.706;	        T2[1,0.01] = 63.6570;
   T2[2,0.05] = 4.3030;	        T2[2,0.01] = 9.9250;
   T2[3,0.05] = 3.1820;	        T2[3,0.01] = 5.8410;
   T2[4,0.05] = 2.7760;	        T2[4,0.01] = 4.6040;
   T2[5,0.05] = 2.5710;	        T2[5,0.01] = 4.0320;
   T2[6,0.05] = 2.4470;	        T2[6,0.01] = 3.7070;
   T2[7,0.05] = 2.3650;	        T2[7,0.01] = 3.4990;
   T2[8,0.05] = 2.3060;	        T2[8,0.01] = 3.3550;
   T2[9,0.05] = 2.2620;	        T2[9,0.01] = 3.2500;
   T2[10,0.05] = 2.2280;        T2[10,0.01] = 3.1690;
   T2[11,0.05] = 2.2010;	T2[11,0.01] = 3.1060;
   T2[12,0.05] = 2.1790;        T2[12,0.01] = 3.0550;
   T2[13,0.05] = 2.1600;	T2[13,0.01] = 3.0120;
   T2[14,0.05] = 2.1450;	T2[14,0.01] = 2.9770;
   T2[15,0.05] = 2.1310;	T2[15,0.01] = 2.9470;
   T2[16,0.05] = 2.1200;	T2[16,0.01] = 2.9210;
   T2[17,0.05] = 2.1100;	T2[17,0.01] = 2.8980;
   T2[18,0.05] = 2.1010;	T2[18,0.01] = 2.8780;
   T2[19,0.05] = 2.0930;	T2[19,0.01] = 2.8610;
   T2[20,0.05] = 2.0860;	T2[20,0.01] = 2.8450;
   T2[21,0.05] = 2.0800;	T2[21,0.01] = 2.8310;
   T2[22,0.05] = 2.0740;	T2[22,0.01] = 2.8190;
   T2[23,0.05] = 2.0690;        T2[23,0.01] = 2.8070;
   T2[24,0.05] = 2.0640;	T2[24,0.01] = 2.7970;
   T2[25,0.05] = 2.0600;	T2[25,0.01] = 2.7870;
   T2[26,0.05] = 2.0560;	T2[26,0.01] = 2.7790;
   T2[27,0.05] = 2.0520;	T2[27,0.01] = 2.7710;
   T2[28,0.05] = 2.0480;	T2[28,0.01] = 2.7630;
   T2[29,0.05] = 2.0450;	T2[29,0.01] = 2.7560;
   T2[30,0.05] = 2.0420;	T2[30,0.01] = 2.7500;
   T2[35,0.05] = 2.03;  	T2[35,0.01] = 2.72;
   T2[40,0.05] = 2.02;  	T2[40,0.01] = 2.7;
   T2[45,0.05] = 2.01;  	T2[45,0.01] = 2.69;
   T2[50,0.05] = 2.01;  	T2[50,0.01] = 2.68;
   T2[55,0.05] = 2;  		T2[55,0.01] = 2.67;
   T2[60,0.05] = 2;  		T2[60,0.01] = 2.66;
   T2[65,0.05] = 2;  		T2[65,0.01] = 2.65;
   T2[70,0.05] = 1.99;  	T2[70,0.01] = 2.65;
   T2[75,0.05] = 1.99;  	T2[75,0.01] = 2.64;
   T2[80,0.05] = 1.99;  	T2[80,0.01] = 2.64;
   T2[85,0.05] = 1.99;  	T2[85,0.01] = 2.63;
   T2[90,0.05] = 1.99;  	T2[90,0.01] = 2.63;
   T2[95,0.05] = 1.99;  	T2[95,0.01] = 2.63;
   T2[100,0.05] = 1.98;  	T2[100,0.01] = 2.63;
   T2[200,0.05] = 1.97;  	T2[200,0.01] = 2.6;
   T2[500,0.05] = 1.96;  	T2[500,0.01] = 2.59;
   T2[1000,0.05] = 1.96;  	T2[1000,0.01] = 2.58;
   T2["inf",0.05] = 1.96;  	T2["inf",0.01] = 2.58;
 }
 
