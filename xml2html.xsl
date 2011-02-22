<xsl:stylesheet 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:h="http://www.w3.org/1999/xhtml"
exclude-result-prefixes="h" 
>


<xsl:output method="html" indent="no"/>

<xsl:template match="*|@*|processing-instruction()">
 <xsl:copy>
  <xsl:apply-templates select="*|@*|processing-instruction()|text()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="text()">
    <xsl:value-of select="."/> 
</xsl:template>

<xsl:template match="h:body">
 <body>
 <xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
  <xsl:apply-templates/>
 <h2>List of links</h2>
 <xsl:for-each select="//h:a[@href]">
<xsl:text>[</xsl:text>
 <xsl:number level="any"/>
<xsl:text>] </xsl:text> <xsl:value-of select="@href"/>
  <br/>
 </xsl:for-each>
 </body>
</xsl:template>

<xsl:template match="h:a">
<a>
<xsl:copy><xsl:apply-templates select="@*"/></xsl:copy>
<xsl:apply-templates/>
</a>
<xsl:if test="@href">
<xsl:text>[</xsl:text>
 <xsl:number level="any"/>
<xsl:text>]</xsl:text>
</xsl:if>
</xsl:template>

</xsl:stylesheet>







