<xsl:stylesheet 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
<xsl:include href="/usr/share/xml/tei/stylesheet/html/tei.xsl"/>
<xsl:param name="pageLayout">CSS</xsl:param>
<xsl:param name="splitLevel">0</xsl:param>
<xsl:param name="STDOUT">false</xsl:param>
<xsl:param name="outputName">battle5</xsl:param>
<xsl:param name="parentWords">University of North Carolina</xsl:param>

<xsl:template name="rh-col-top">
  <xsl:call-template name="pageHeader"/>
</xsl:template>

<xsl:template name="lh-col-bottom">
<ul>
  <li><a href="/Histories/">Histories</a></li>
  <li><a href="/Letters/">Letters</a></li>
  <li><a href="/Testimonies/">Testimonies</a></li>
  <li><a href="/Novels/">Novels</a></li>
</ul>
</xsl:template>

<xsl:template name="hdr">
  <h1 class="maintitle">Documenting the American South</h1>
</xsl:template>

<xsl:template name="hdr2"/>

<xsl:template name="hdr3"/>

<xsl:template name="cssHook">
<style>
#hdr2{
    background-color: white;
     }
#hdr3{
    background-color: white;
     }
#hdr{
    background-color: white;
    color: blue;
}
body {
    background-color: white;
}

</style>
</xsl:template>
</xsl:stylesheet>
