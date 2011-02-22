#!/usr/local/bin/perl
BEGIN {
  $0 = readlink $0 while -l $0;
  $0 =~ /(.*)\/bin\/.*/;
  $::library = "$1";
  unshift @INC, "$::library";
}
require "lexsetup.pm";
$DATA="$LEXDIR/lex3.xml";
use CGI ':standard';
use CGI::Carp;
use CGI::Carp qw(fatalsToBrowser);

print header;
print "<h3>Lexicon of Greek Personal Names name search</h3>\n";
print    start_form,
    "Search for <font face=Symbol>",textfield('name'),  "</font> ",   p,
    submit,p
    "Scroll down to view results",p,
    end_form,
    hr;
showtable();
if (param()) {
    $Job = "$SEARCH -q  \".*tr/\" -s \".*/td[0]\" -t \"". param('name'). "\"";

$Job = $Job . " < $DATA  > $Outfile";
#print $Job;
system($Job);
#$Job="$SAXON $Outfile $LEXDIR/lex3.xsl > $WWWDIR/lexicon$$.html";
#print "\n$Job";
#system($Job);
print "<h2>Search results</h2>",
      "for name: <font face=Symbol>",em(param('name')),"</font>",br;
print "<hr/><table border=\"\"><tr>\n";
print "<td>Name</td><td>Volume 1</td><td>Volume 2</td><td>Volume 3</td></tr>\n";
open(FOO,"$WWWDIR/lexicon$$.html") || die "file $WWWDIR/lexicon$$.html does not exist";
while (<FOO>) { 
  if (/^<tr/) {
                s/'>/' font='Symbol'>/;
	        s/s</V</;
		if (/font/) { s!6!</font><i>F</i><font face="Symbol">!g; }
                print ;
}}
close(FOO);
print "</table>\n";
}
unlink $Outfile;
unlink "$WWWDIR/lexicon$$.html";
unlink "$WWWDIR/err$$";
print end_html;
