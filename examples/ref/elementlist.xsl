<xsl:stylesheet 
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0"
  exclude-result-prefixes="tei" 
>
<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="/">
<tei:glossList>
  <xsl:for-each select="//tei:elementSpec">
    <xsl:sort select="@ident"/>
    <tei:label><tei:gi><xsl:value-of select="@ident"/></tei:gi>
    (<tei:emph><xsl:value-of select="@module"/></tei:emph>)</tei:label> 
    <tei:item>
      <xsl:value-of select="tei:desc"/>
      [<tei:emph>Attributes</tei:emph>: <xsl:for-each select="tei:attList/tei:attDef">
	<xsl:sort select="@ident"/>
	<xsl:if test="not(position() = 1) and count(../tei:attDef)&gt;1">, </xsl:if>
	<xsl:choose>
	  <xsl:when test="@usage='req'">
	    <tei:hi>
	      <xsl:value-of select="@ident"/>
	    </tei:hi>
	  </xsl:when>
	  <xsl:otherwise>
	      <xsl:value-of select="@ident"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>]
      [<tei:emph>Classes</tei:emph>: <xsl:for-each select="tei:classes/tei:memberOf">
	<xsl:sort select="@key"/>
	<xsl:if test="not(position() = 1) and count(../tei:memberOf)&gt;1">, </xsl:if>
	<xsl:value-of select="@key"/>
      </xsl:for-each>]
    </tei:item> 
 </xsl:for-each>
</tei:glossList>
</xsl:template>
</xsl:stylesheet>
