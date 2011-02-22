<xsl:stylesheet 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
<xsl:include href="/usr/share/xml/tei/stylesheet/html/tei.xsl"/>
<xsl:param name="pageLayout">CSS</xsl:param>
<xsl:param name="splitLevel">0</xsl:param>
<xsl:param name="STDOUT">false</xsl:param>
<xsl:param name="outputName">battle2b</xsl:param>
<xsl:param name="parentWords">Documenting the American South</xsl:param>
<xsl:template name="navbar">
  <a class="navbar" href="/Histories/">Histories</a> |
  <a class="navbar" href="/Letters/">Letters</a> |
  <a class="navbar" href="/Testimonies/">Testimonies</a> |
  <a class="navbar" href="/Novels/">Novels</a> 
</xsl:template>
</xsl:stylesheet>