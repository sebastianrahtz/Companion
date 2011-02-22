[-q] query required, but missing
#usage: 
#
#   sggrep [<options>] -q query [ -s sub-query] [-t regexp] file... 
#     or
#   sggrep [<options>] query [[sub-query] regexp] [[--] file...] 
#
#   query:  pattern on items to select, basically path based with terms 
#     separated by /, <term>:=<GI><cond>?'*'? 
#                     <GI>:=<elementName>|'.' 
#		     <cond>:='['<index>|<atests>|<index> <atests>']' 
#		     <index>:=<number> 
#		     <atests>:=<atest>(' '<atest>)* 
#		     <atest>:=<aname>( ['='|'!='] <aval> )? 
#     Aname and aval are as per SGML, except that if the -r flag is given,  
#     aval are regular expressions. 
#     A GI of . matches any tag.  A condition with an index matches only the 
#     index'th sub-element of the enclosing element.  Attribute tests are not 
#     exhaustive, and will match against both explicitly present and defaulted 
#     attribute values, using string equality.  Bare anames are satisfied by 
#     ANY value, explicit or defaulted.  Terms ending with * match 
#     any number of links in the chain, including 0. 
#
#   sub-query:  if present, selects sub-elements of query-selected item for 
#               regexp to match 
#
#   regexp:  Regular expression to match against text directly contained in 
#            query-selected item (if no sub-query) or in any sub-query selected 
#	    sub-element of query-selected item. 
#            If empty (i.e. '') matches anything, including empty elements, 
#            indeed this is the ONLY way to get empty elements if required. 
#
#When using the second, terse, form, the '--' is required unless both regexp and 
#sub-query are provided. 
#
#Other options:
#  -d ddb-file:  Take Dtd from specified ddb file 
#  -e: don't expand entities
#  -o out-file: Put output to specified file 
#  -v: invert sense of sub-query+regexp 
#  -n: don't force a newline between output matches 
#  -r: attribute values in queries are regular expressions 
#
#  -mq mark-query: is an NSL query which tells us which subelements of 
#                  elements matching <query> are going to be 'marked'. 
#                  Sub-elements matching <mark-query> are 'marked' if they 
#                  in turn contain a sub element which matches 
#                  <sub-query> which includes text matching <regexp> 
#                  mt must be specified if mq is 
#  -mt mark-tag:  indicates which tag is to be used to wrap the marked elements.
# 
#  -a element-name: Give an element name to act as a toplevel element 
#                    in which matching elements will be embedded. 
#                    (in NSL mode this tag must be in the DTD) 
#
