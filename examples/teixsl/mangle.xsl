<xsl:stylesheet 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0"
>
<xsl:output method="xml" indent="yes" encoding="utf-8"/>

<xsl:template match="*|@*|processing-instruction()">
 <xsl:copy>
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="text()">
    <xsl:value-of select="."/> 
</xsl:template>

<xsl:template match="tei:TEI/tei:text/tei:body/tei:div1">
<tei:div>
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
</tei:div>
</xsl:template>

<xsl:template match="tei:TEI/tei:text/tei:body/tei:div1/tei:div2">
<tei:div>
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
</tei:div>
</xsl:template>

<xsl:template match="tei:TEI/tei:text/tei:body/tei:div1/tei:div2/tei:div3">
<tei:div>
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
</tei:div>
</xsl:template>

<xsl:template match="tei:TEI/tei:text/tei:body/tei:div1/tei:div2/tei:div3/tei:div4">
<tei:div>
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
</tei:div>
</xsl:template>
</xsl:stylesheet>


