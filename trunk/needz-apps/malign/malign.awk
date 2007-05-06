{ N++;  
 for(I=1;I<=NF;I++) {
   $I=Trim ? trim($I) : $I;
   if( (L=length($I)) > Max[I]) Max[I]=L;
   ++Data[N,0]
   Data[N,I]=$I;}
}
END {
  for(J=1;J<=N;J++) {
    Str=Sep1="";
    if (Data[J,0]>1) {  
      for(I=1;I<=NF;I++) {
        L=length(Data[J,I]);
        Str = Str Sep1 str(most(Width,Max[I]+Gutter)-L," ") Data[J,I];
        Sep1= OFS;
      }} else {Str=Data[J,1]}
    print Str;}
}
