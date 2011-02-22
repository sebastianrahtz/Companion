if ($^O eq 'MSWin32') 
 { $IsWin32 = 1 ;}
else 
 { $IsWin32 = 0 ;}
if ($IsWin32 == 1)
{
$Outfile="d:\\srahtz\\lexicon\\names.$$";
$WWWDIR="d:\\wwwroot";
$SEARCH = "e:\\ltxml\\bin\\sggrep";
$LEXDIR="d:\\srahtz\\lexicon";
$JADE="jade";
$DATA="$LEXDIR\\v1mnames.xml";
}
else
{
 $ENV{SGML_CATALOG_FILES}="/export/home/lgpn/lexicon/dtd/catalog";
 $LEXDIR="/export/home/lgpn/lexicon";
 $WWWDIR="/export/home/lgpn/tmp";
#
 $DATA="$LEXDIR/v1mnames.xml";
#
 $BIN="/export/home/lgpn/bin";
 $JADE="/export/home/lgpn/bin/jade";
 $SEARCH = "$BIN/sggrep";
#
 $Outfile="$WWWDIR/names.$$";
}
sub showtable {
print <<FOO;
<table>
<tr>
<td>A</td><td>B</td><td>G</td><td>D</td><td>E</td><td>6</td><td>Z</td><td>H</td><td>Q</td><td>I</td><td>K</td><td>L</td><td>M</td><td>N</td><td>X</td><td>O</td><td>P</td><td>R</td><td>S</td><td>T</td><td>U</td><td>F</td><td>C</td><td>Y</td><td>W</td>
</tr>
<tr>
<td><font face="symbol">A</font></td><td><font face="symbol">B</font></td><td><font face="symbol">G</font></td><td><font face="symbol">D</font></td><td><font face="symbol">E</font></td><td><i>F</i></td><td><font face="symbol">Z</font></td><td><font face="symbol">H</font></td><td><font face="symbol">Q</font></td><td><font face="symbol">I</font></td><td><font face="symbol">K</font></td><td><font face="symbol">L</font></td><td><font face="symbol">M</font></td><td><font face="symbol">N</font></td><td><font face="symbol">X</font></td><td><font face="symbol">O</font></td><td><font face="symbol">P</font></td><td><font face="symbol">R</font></td><td><font face="symbol">S</font></td><td><font face="symbol">T</font></td><td><font face="symbol">U</font></td><td><font face="symbol">F</font></td><td><font face="symbol">C</font></td><td><font face="symbol">Y</font></td><td><font face="symbol">W</font></td>
</tr>
<tr>
<td>a</td><td>b</td><td>g</td><td>d</td><td>e</td><td>6</td><td>z</td><td>h</td><td>q</td><td>i</td><td>k</td><td>l</td><td>m</td><td>n</td><td>x</td><td>o</td><td>p</td><td>r</td><td>s</td><td>t</td><td>u</td><td>f</td><td>c</td><td>y</td><td>w</td></tr>
<tr><td><font face="symbol">a</font></td><td><font face="symbol">b</font></td><td><font face="symbol">g</font></td><td><font face="symbol">d</font></td><td><font face="symbol">e</font></td><td><i>F</i></td><td><font face="symbol">z</font></td><td><font face="symbol">h</font></td><td><font face="symbol">q</font></td><td><font face="symbol">i</font></td><td><font face="symbol">k</font></td><td><font face="symbol">l</font></td><td><font face="symbol">m</font></td><td><font face="symbol">n</font></td><td><font face="symbol">x</font></td><td><font face="symbol">o</font></td><td><font face="symbol">p</font></td><td><font face="symbol">r</font></td><td><font face="symbol">s</font></td><td><font face="symbol">t</font></td><td><font face="symbol">u</font></td><td><font face="symbol">f</font></td><td><font face="symbol">c</font></td>
<td><font face="symbol">y</font></td><td><font face="symbol">w</font></td>
</tr>
</table>
<hr>
FOO

}
1;
