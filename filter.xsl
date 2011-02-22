<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="xsl tei">
   <xsl:import href="equivs.xsl"/>
   <xsl:template match="*">
      <xsl:copy>
         <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
      </xsl:copy>
   </xsl:template>
   <xsl:template match="text()|comment()|@*|processing-instruction()">
      <xsl:copy/>
   </xsl:template>
   <xsl:template match="tei:verbatim">
      <xsl:call-template name="q"/>
   </xsl:template>
   <xsl:template match="tei:kw">
      <xsl:call-template name="ident"/>
   </xsl:template>
   <xsl:template match="tei:path">
      <xsl:call-template name="ident"/>
   </xsl:template>
   <xsl:template match="tei:command">
      <xsl:call-template name="ident"/>
   </xsl:template>
   <xsl:template match="tei:software">
      <xsl:call-template name="ident"/>
   </xsl:template>
   <xsl:template match="tei:url">
      <xsl:call-template name="ident"/>
   </xsl:template>
   <xsl:template match="tei:glossList">
      <xsl:call-template name="list"/>
   </xsl:template>
   <xsl:template match="tei:oList">
      <xsl:call-template name="list"/>
   </xsl:template>
   <xsl:template match="tei:uList">
      <xsl:call-template name="list"/>
   </xsl:template>
   <xsl:template match="tei:transclude">
      <xsl:call-template name="ptr"/>
   </xsl:template>
</xsl:stylesheet>