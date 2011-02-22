<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">

<xsl:template match="bibl">
 <xsl:param name="rend"/>
 <xsl:choose>
  <xsl:when test="$rend='citebibyear'">
    <xsl:call-template name="bibyear"/>
  </xsl:when>
  <xsl:when test="$rend='citenoun'">
    <xsl:call-template name="authed"/>
  </xsl:when>
  <xsl:when test="$rend='citeparen'">
    (<xsl:call-template name="authed"/> <xsl:call-template name="bibyear"/>)
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="authed"/> (<xsl:call-template name="bibyear"/>)
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template name="authed">
</xsl:template>

<xsl:template name="bibyear">
</xsl:template>

</xsl:stylesheet>
