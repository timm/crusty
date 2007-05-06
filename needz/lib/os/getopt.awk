#!/usr/bin/gawk -f
# getopt --- do C library getopt(3) function in awk
# Author: arnold@gnu.ai.mit.edu (in the 1990s)
# (and the clearArgs() function was added at the suggestion of Mathew Hall
# Tue, 2 Aug 2005)

# Valid options are passed to a function opt(opts,opt,arg) which
# must be supplied outside this file. e.g.
#
# function opt(opts,flag,arg) { print opt "= [" arg "]" }
# USAGE:
# a call to "getOpts(String)" (e.g. getopts("ab:cd") )
# will lead to on call xoof opt for each valid argument

 function getOpts(opts, debug,     tmp) {
  Optind = 1;        # skip ARGV[0]   
  Opterr = debug;    # default is to diagnose
  while ((tmp = getopt(ARGC, ARGV, opts)) != -1)
    set(tmp, Optarg);
  clearARGV(debug);  
 }

# External variables:
#    Optind -- index of ARGV for first non-option argument
#    Optarg -- string value of argument to current option
#    Opterr -- if non-zero, print our own diagnostic
#    Optopt -- current option letter
# Returns
#    -1     at end of options
#    ?      for unrecognized option
#    <c>    a character representing the current option

 function getopt(argc, argv, options,    thisopt, i) {
  if (length(options) == 0)    # no options given
    return -1;
  if (argv[Optind] == "--") {  # all done
    Optind++;
    _opti = 0;
    return -1;
  } else if (argv[Optind] !~ /^-[^: \t\n\f\r\v\b]/) {
    _opti = 0;
    return -1;
      }
  if (_opti == 0)
    _opti = 2;
  thisopt = substr(argv[Optind], _opti, 1);
  Optopt = thisopt;
  i = index(options, thisopt);
  if (i == 0) {
    if (Opterr)
      printf("%c -- invalid option\n",
             thisopt) > "/dev/stderr"
        if (_opti >= length(argv[Optind])) {
          Optind++;
          _opti = 0;
        } else
          _opti++;
    return "?";
  }
  if (substr(options, i + 1, 1) == ":") {
     # get option argument
    if (length(substr(argv[Optind], _opti + 1)) > 0)
      Optarg = substr(argv[Optind], _opti + 1);
    else
      Optarg = argv[++Optind];
    _opti = 0;
  } else
    Optarg = "";
  if (_opti == 0 || _opti >= length(argv[Optind])) {
    Optind++;
    _opti = 0
      } else
        _opti++;
  return thisopt;
 }
 function clearARGV(debug,   i,n,tmp) {
  for(i=0;i<=ARGC;i++) 
    if(i>=Optind  ) {
      tmp[++n]=ARGV[i];
      if(debug && i!=ARGC) printf("\trest ARGV[%d] = <%s>\n",i, ARGV[i]); 
    } else {     
      if(debug) printf("\tused ARGV[%d] = <%s>\n",i, ARGV[i]); 
    }
  split("",ARGV,"");
  ARGC=0
  for(i in tmp) 
    ARGV[++ARGC]=tmp[i];
 }
