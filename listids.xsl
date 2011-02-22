<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">

<!--
 listids.xsl. Sebastian Rahtz. $Date$

 For a TEI document, make a sorted list of all ID elements. For each
 one show the context (the route to it from the top-level <text>), and
 a list of <ptr> or <ref> elements that link to it. Each of those also
 shows its context.
-->
<xsl:output method="text"/>

<xsl:key name="xrefs" match="ptr|ref" use="@target"/>

<xsl:template match="text()"/>

<xsl:template match="/">

<xsl:apply-templates/>

<xsl:for-each select="//*[@id]">
 <xsl:sort select="@id"/>
ID <xsl:value-of select="@id"/>:	<xsl:call-template name="context"/>
 <xsl:if test="count(key('xrefs',@id)) &gt; 0">
   Links:
      <xsl:for-each select="key('xrefs',@id)">
         <xsl:call-template name="context"/>
     <xsl:text>  
</xsl:text>
      </xsl:for-each>
 </xsl:if>
     <xsl:text>  
</xsl:text>
</xsl:for-each>
</xsl:template>

<xsl:template name="context">
<xsl:value-of select="name(.)"/>: <xsl:for-each select="ancestor::*">
  <xsl:sort select="position()"/>
<xsl:if test="position() &gt; 2">
 <xsl:if test="position() &gt;3">, </xsl:if>
 <xsl:value-of select="name(.)"/>
  <xsl:text>/</xsl:text><xsl:number/>
  <xsl:if test="@id">
    <xsl:text>[id=</xsl:text><xsl:value-of select="@id"/><xsl:text>]</xsl:text>
  </xsl:if>
  </xsl:if>
</xsl:for-each>  
</xsl:template>

</xsl:stylesheet>
