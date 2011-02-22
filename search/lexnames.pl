#!/usr/local/bin/perl
BEGIN {
  $0 = readlink $0 while -l $0;
  $0 =~ /(.*)\/bin\/.*/;
  $::library = "$1";
  unshift @INC, "$::library";
}
use lexsetup ();
use CGI ':standard';

print header;
print "<h3>Lexicon of Greek Personal Names search</h3>\n";
print    start_form,
    "Search data file: ",popup_menu(-name=>'namelist',
	   -values=>['alpha','beta'],'alpha'),p,
    "Search for ",textfield('name'),  " in name",   p,
    "Search for ",textfield('date'),  " in date",p,
    "Search for ",textfield('place'), " in place",p,
    "Search for ",textfield('ref'),   " in reference",   p,
    submit,
    end_form,
    hr;
showtable();
if (param()) {
    $DATA="$LEXDIR/" . param('namelist') . ".xml";
$first=0;
if (param('name') ne "") {
    $first=1;
    $Job = $Job . "$SEARCH \".*person/\" \".*/name\" \"". param('name'). "\""; 
    $Job = $Job . " < $DATA";
}
if (param('place') ne "") {
    if ($first) { $Job=$Job . "|" }
    $Job = $Job . "$SEARCH \".*person/\" \".*/place/.*\" \"". param('place'). "\"";
    if (!$first) { $Job = $Job . " < $DATA"; }
    $first=1;
}
if (param('date') ne "") {
    if ($first) { $Job=$Job . "|" }
    $Job = $Job . "$SEARCH \".*person/\" \".*/date\" \"". param('date'). "\"";
    if (!$first) { $Job = $Job . " < $DATA"; }
    $first=1;
}
if (param('ref') ne "") {
    if ($first) { $Job=$Job . "|" }
    $Job = $Job . "$SEARCH \".*person/\" \".*/ref\" \"". param('ref'). "\"";
    if (!$first) { $Job = $Job . " < $DATA"; }
    $first=1;
}
$Job = $Job . " > $Outfile";
print $Job;
system($Job);
$Job="$JADE -d $LEXDIR/lexhtml.dsl -t sgml -f $WWWDIR/err.$$ $LEXDIR/lexicon.dtd $Outfile > $WWWDIR/lexicon$$.html";
print $Job;
system($Job);
print "<h2>Search results</h2>",hr,
      "for name: <font face=Symbol>",em(param('name')),"</font>",br, 
      "place: ",em(param('place')),br, 
      "date: ",em(param('date')),br, 
      "reference: ",em(param('ref')),br, 
      "Data file: ",em(param('namelist')),br, 
	hr;
open(FOO,"$WWWDIR/lexicon$$.html");
while (<FOO>) { s/&#38;/&/g; print ;}
close(FOO);
}
unlink $Outfile;
unlink "$WWWDIR/err.$$";
unlink "$WWWDIR/lexicon$$.html";
print end_html;
