BEGIN{
	split("",Num,""); 		#array where we store the numbers
	Inf= 2^32;   			#the largest number we can process
	Max = -1*Inf; 			#max count seen in any bucket
							#initialized to the smallest number
	Here;         			#the key of the current bucket
	Empty = 1;     			#false if some data seen
	SumOfSquares[0] = 0;	#initializes the array for sum of squares
	Sums[0] = 0;			#initializes the array for sums
	STDEVColumnWidth = 0;	#initializes the width of the STDEV column
	MeanColumnWidth = 0;	#initializes the width of the mean column
	DefaultWidth = 7;		#this is the default column width
}
NR==1{ 
	if (Collect=="NF") Collect = NF;
	#it finds the length of the column from the maximum digits needed
	STDEVColumnWidth = Round ? round(log(Round)/log(10)) + 1 : DefaultWidth;
	MeanColumnWidth = STDEVColumnWidth;
}
{  
	Empty = 0;
	Here = Round ? round($Collect/Round) * Round : $Collect;
	Num[Here]++;
	Max = (Num[Here] > Max) ? Num[Here] : Max;
	SumOfSquares[Here] = SumOfSquares[Here] + $Collect*$Collect; 
	Sums[Here] = Sums[Here] + $Collect;

	#if the column is not wide enough, if uses the maximum number of digits
	if (round(log($Collect)/log(10)) + 1 > MeanColumnWidth)
		MeanColumnWidth = round(log($Collect)/log(10)) + 1;
}
END{ 
	if (! Empty) 
		NoSort ?  histogram(Num) : sortedgram(Num);
}
function histogram(a, i){
	for (i in a) print bar(a, i);
}
function sortedgram(a, add, i, j, keys, n){ 
	#Pre-sort the histogram and generated the bars in sorted order
	for (i in a) {
		if (Round) {
			keys[j++] = i+0;}   #ensures numeric, not string, sort
		else keys[j++] = i;}
	n = asort(keys);
	for (i = 1; i <= n; i++)
		print bar(a, keys[i]);
}
function bar(a, i, scale, stdev, mean){
	#Genrate a single histogram bar of Marks, resized according to 
	#the BarColumnWidth.
	scale =  (Max < BarColumnWidth) ? 1 : BarColumnWidth/Max;

	if (ShowMeanSTDEV){
		#Calculates stdev from the SumOfSquares and Sums arrays.
		if (a[i] > 1)
			stdev=sqrt((SumOfSquares[i]-(Sums[i]^2)/a[i])/(a[i]-1))
		else
			stdev = 0;

		#Calculates the mean from Sums array.
		if (a[i] > 0)
			mean = Sums[i]/a[i];
		else
			mean = Sums[i];
	}

	if (Round){
		if (ShowMeanSTDEV){
			return sprintf(" %" KeyColumnWidth ".0f|%"\
					ValueColumnWidth "d| %"\
					MeanColumnWidth + 3 ".2f| %"\
					STDEVColumnWidth + 3 ".2f| %s",\
					i, a[i], mean, stdev,\
					str(round(a[i]*scale), Mark))}
		else{
			return sprintf(" %" KeyColumnWidth ".0f| %"\
					ValueColumnWidth "d| %s",\
					i, a[i], str(round(a[i]*scale), Mark))}
	}
	else{
		if (ShowMeanSTDEV){
			return sprintf(" %" KeyColumnWidth " s| %"\
					ValueColumnWidth " d| %"\
					MeanColumnWidth + 3 ".2f| %"\
					STDEVColumnWidth + 3 ".2f| %s",\
					i, a[i], mean, stdev,\
					str(round(a[i]*scale), Mark))}
		else{
			return sprintf(" %" KeyColumnWidth " s| %"\
					ValueColumnWidth " d| %s",\
					i, a[i], str(round(a[i]*scale), Mark))}
	}
}

