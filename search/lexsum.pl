#!/usr/local/bin/perl
BEGIN {
  $0 = readlink $0 while -l $0;
  $0 =~ /(.*)\/bin\/.*/;
  $::library = "$1";
  unshift @INC, "$::library";
}
use lexsetup ();

use CGI ':standard';
use CGI::Carp;
use CGI::Carp qw(fatalsToBrowser);


print header;
print "<h3>Lexicon of Greek Personal Names summary name search</h3>\n";
print    start_form,
    "Search for <font face=Symbol>",textfield('name'),  "</font> in name",   p,
    submit,
    end_form,
    hr;
showtable();
if (param()) {
    $Job = "$SEARCH \".*name/\" \".*/sname\" \"". param('name'). "\"";

$Job = $Job . " < $DATA  > $Outfile";
print $Job;
system($Job);
$Job="$JADE -d $LEXDIR/lexsumhtml.dsl -t sgml -f $LEXDIR/err.$$ $LEXDIR/lexnames.dtd $Outfile > $LEXDIR/lexicon$$.html";
system($Job);
print "<h2>Search results</h2>",
      "for name: <font face=Symbol>",em(param('name')),"</font>",br, 
open(FOO,"$LEXDIR/lexicon$$.html");
while (<FOO>) { s/&#38;/&/g; print ;}
close(FOO);
}
unlink $Outfile;
unlink "$LEXDIR/lexicon$$.html";
unlink "$LEXDIR/err.$$";
print end_html;




