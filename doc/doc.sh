main() {
	case $1 in
		contents) 	contents ;;
		ascii) 		contents | groff -Tascii -man  ;;
		less) 		contents | groff -Tascii -man | less ;;
		html)  		contents | groff -Thtml -man  > $HOME/tmp/eg.html ;;
		ps)    		contents | groff -Tps   -man  > $HOME/tmp/eg.ps; 
					pstopdf $HOME/tmp/eg.ps ;;
		*)	   		echo "unknown option: $1"
	esac
}
# NAME           Name section, the name of the function or command.
# SYNOPSIS       Usage.
# DESCRIPTION    General description
# OPTIONS        Should include options and parameters.
# RETURN VALUES  Sections two and three function calls.
# ENVIRONMENT    Describe environment variables.
# FILES          Files associated with the subject.
# EXAMPLES       Examples and suggestions.
# DIAGNOSTICS    Normally used for section 4 device interface
#                diagnostics.
# ERRORS         Sections two and three error and signal handling.
# SEE ALSO       Cross references and citations.
# STANDARDS      Conformance to standards if applicable.
# BUGS           Gotchas and caveats.
# SECURITY CONSIDERATIONS
#                Security issues to be aware of.

# .BI text
#     Causes text on the same line to appear alternately in bold face and italic. 
# .IB text
#     Causes text to appear alternately in italic and bold face. 
# .BR text
#     Causes text on the same line to appear alternately in bold face and roman. 
# .RB text
#     Causes text on the same line to appear alternately in roman and bold face.
# .R text
#     Causes text to appear in roman font. 
# .B text
#     Causes text to appear in bold face. 
# .I text
#     Causes text to appear in italic. 

contents() {
cat<<-'EOF' 
	.TH "<program name>" 1
	.SH NAME
	<program name> \- <one line description of program>
	.SH SYNOPSIS
	.B <program name>
	<grammar for command line>
	.SH DESCRIPTION
	<detailed description of what the program does>
	.SH OPTIONS
	.TP
	.B \-<a command line switch>
	<description of what that switch does>
	.TP
	.B \-<a command line switch>
	<description of what that switch does>
	.TP
	.B <etc . . .>
	.SH "SEE ALSO"
	<a list of related man pages>
	.SH BUGS
	<known bugs if any>
	EOF
}
main $1
