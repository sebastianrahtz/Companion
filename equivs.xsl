<xsl:stylesheet
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 exclude-result-prefixes="xsl tei"    
 version="1.0">

<xsl:template name="list">
  <tei:list>
    <xsl:copy-of select="@xml:id|@n"/>
    <xsl:attribute name="type">
      <xsl:choose>
	<xsl:when test="local-name(.)='oList'">ordered</xsl:when>
	<xsl:when test="local-name(.)='uList'">unordered</xsl:when>
	<xsl:when test="local-name(.)='glossList'">gloss</xsl:when>
	<xsl:otherwise>
	  <xsl:message terminate="yes"><xsl:value-of
	  select="local-name(.)"/> is mapped to "list", but I do not know
	  what to do to with it</xsl:message>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </tei:list>
</xsl:template>

<xsl:template name="ident">
  <tei:ident type="{local-name(.)}">
    <xsl:copy-of select="@xml:id|@n"/>
    <xsl:apply-templates/>
  </tei:ident>
</xsl:template>

<xsl:template name="ptr">
  <tei:ptr type="transclude" target="{@url}"/>
</xsl:template>

<xsl:template name="q">
  <xsl:choose>
    <xsl:when test="local-name(.)='verbatim'">
      <tei:q rend="verbatim">
	<xsl:copy-of select="@xml:id|@n"/>
	<xsl:apply-templates/>
      </tei:q>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message terminate="yes"><xsl:value-of
      select="local-name(.)"/> is mapped to "q", but I do not know
      what to do to with it</xsl:message>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>

</xsl:stylesheet>
