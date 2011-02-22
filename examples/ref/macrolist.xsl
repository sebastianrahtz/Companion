<xsl:stylesheet 
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:edate="http://exslt.org/dates-and-times"
    xmlns:exsl="http://exslt.org/common"
    xmlns:estr="http://exslt.org/strings"
    exclude-result-prefixes="exsl estr edate tei" 
    extension-element-prefixes="edate exsl estr"
    version="1.0"
>
<xsl:output method="xml" encoding="utf-8" indent="yes"/>
<xsl:include href="/usr/share/xml/tei/stylesheet/odds/RngToRnc.xsl"/>
<xsl:param name="displayMode">rnc</xsl:param>
<xsl:param name="TEISERVER"></xsl:param>

<xsl:template name="make-ns-declaration">
  <xsl:param name="is-default"/>
  <xsl:param name="prefix"/>
  <xsl:param name="uri"/>
</xsl:template>

<xsl:template name="inhnamespace"/>

<xsl:template match="/">
<tei:glossList>
  <xsl:for-each select="//tei:macroSpec">
    <xsl:sort select="@ident"/>
    <xsl:choose>
      <xsl:when test="starts-with(@ident,'TEI.')"/>
      <xsl:when test="starts-with(@ident,'mix.')"/>
      <xsl:otherwise>
	<tei:label><xsl:value-of select="@ident"/></tei:label>
	<tei:item>
	  <xsl:apply-templates select="tei:desc"/>
	  <tei:output>
	    <xsl:variable name="content">
	    	<Wrapper>
		  <rng:define name="{@ident}">
		    <xsl:copy-of select="tei:content/*"/>
		  </rng:define>
		</Wrapper>
	    </xsl:variable>
	    <xsl:call-template name="make-body-from-r-t-f">
	      <xsl:with-param name="schema">
		<xsl:for-each  select="exsl:node-set($content)/Wrapper">
		  <xsl:call-template name="make-compact-schema"/>
		</xsl:for-each>
	      </xsl:with-param>
	    </xsl:call-template>
	  </tei:output>
	</tei:item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</tei:glossList>
</xsl:template>

<xsl:template name="linkTogether">
  <xsl:param name="name"/>
  <xsl:param name="url"/>
  <xsl:value-of select="$name"/>
</xsl:template>


</xsl:stylesheet>
