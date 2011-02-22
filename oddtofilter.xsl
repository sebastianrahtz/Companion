<xsl:stylesheet
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:XSL="http://www.w3.org/1999/XSL/TransformAlias" 
    exclude-result-prefixes="xsl" 
    version="1.0"
>
<xsl:key name="EQUIVFILES" match="tei:equiv" use="@filter"/>

<xsl:output method="xml" indent="yes" encoding="utf-8"/>

<xsl:namespace-alias stylesheet-prefix="XSL" result-prefix="xsl"/>

<xsl:template match="/">
  
  <XSL:stylesheet version="1.0"
		  exclude-result-prefixes="xsl tei" 
		  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		  xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:for-each select="//tei:equiv">
      <xsl:if test="generate-id(.)=generate-id(key('EQUIVFILES',@filter)[1])">
	<XSL:import href="{@filter}"/>  
      </xsl:if>
    </xsl:for-each>
    
    <XSL:template match="*">
      <XSL:copy>
	<XSL:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
      </XSL:copy>
    </XSL:template>
    
    <XSL:template match="text()|comment()|@*|processing-instruction()">
      <XSL:copy/>
    </XSL:template>
    
    <xsl:for-each select="//tei:equiv">
      <XSL:template>
	<xsl:attribute name="match">
	  <xsl:text>tei:</xsl:text>
	  <xsl:value-of select="parent::tei:elementSpec/@ident"/>
	</xsl:attribute>
	<XSL:call-template name="{@name}"/>
      </XSL:template>
    </xsl:for-each>
    
  </XSL:stylesheet>
</xsl:template>

</xsl:stylesheet>
