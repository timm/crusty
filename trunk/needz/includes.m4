m4_divert(-1)`'m4_dnl 
m4_changecom(`##')
m4_define(`needz1',`#---- [$1 ] ------------------------------------------
m4_define(`HAVE`$1'',1)'`m4_include($1)') 
m4_define(`needz',`m4_ifdef(`HAVE`$1'',`',`needz1(`$1')')')
m4_divert`'m4_dnl

