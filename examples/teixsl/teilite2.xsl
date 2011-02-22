<xsl:stylesheet 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

<xsl:include href="/usr/share/xml/tei/stylesheet/html/tei.xsl"/>

<xsl:param name="pageLayout">CSS</xsl:param>
<xsl:param name="splitLevel">0</xsl:param>
<xsl:param name="STDOUT">false</xsl:param>
<xsl:param name="outputName">teilite2</xsl:param>
<xsl:param name="parentWords">TEI Consortium</xsl:param>

<xsl:template name="navbar">
  <a class="navbar" href="http://www.tei-c.org/Stylesheets/">Stylesheets</a> |
  <a class="navbar" href="http://www.tei-c.org/Consortium/">Consortium</a> |
  <a class="navbar" href="http://www.tei-c.org/Faq/">FAQ</a> |
  <a class="navbar" href="http://www.tei-c.org/P5/">TEI P5</a> 
</xsl:template>

<xsl:template name="cssHook">
<style>
#hdr{
   background: url("jaco001d.png");
   background-repeat : no-repeat;
   overflow : inherit;
   height: 140;
}
h1.maintitle{
   color: red;
   margin-left: 200px;
}
body {
 background-color: #dddddd;
}
</style>
</xsl:template>

</xsl:stylesheet>