m4_divert(-1)`'m4_dnl 
m4_changecom(`##')
m4_define(`requirez1',`#---- [$1 ] ------------------------------------------
m4_define(`HAVE`$1'',1)'`m4_include($1)') 
m4_define(`requirez',`m4_ifdef(`HAVE`$1'',`',`requirez1(`$1')')')
m4_divert`'m4_dnl

