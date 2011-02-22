<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="exsl" 
		version="1.0">

<!--
 listatts.xsl. Sebastian Rahtz. 

 For a TEI document, make a sorted list of all elements, showing the
 attributes and values used for each
-->

<xsl:key name="atts" match="@*" use="name(parent::*)"/>

<xsl:key name="elements" match="*" use="name(.)"/>

<xsl:template match="/">
<html>
<body>
<table>
<xsl:for-each select="//*">
  <xsl:sort select="name(.)"/>
 <xsl:if test="generate-id(.)=generate-id(key('elements',name(.))[1])">
<tr>
<td valign="top"><xsl:value-of select="name(.)"/></td>
<td valign="top">
  <xsl:call-template name="forelement">
   <xsl:with-param name="element" select="name(.)"/>
  </xsl:call-template>
</td>
</tr>
 </xsl:if>
</xsl:for-each>
</table>
</body>
</html>
</xsl:template>


<xsl:template name="forelement">
<xsl:param name="element"/>
<xsl:message>Process element <xsl:value-of select="$element"/></xsl:message>
<table>
<xsl:variable name="Attributes">
<Atts>
 <xsl:for-each select="key('elements',name(.))">
	<xsl:sort select="."/>
        <xsl:for-each select="@*">
           <Att><xsl:value-of select="name(.)"/></Att>
        </xsl:for-each>
 </xsl:for-each>
</Atts>
</xsl:variable>

<xsl:for-each select="exsl:node-set($Attributes)/Atts/Att">
   <xsl:if test="not(preceding-sibling::Att = .)">
      <xsl:variable name="this" select="."/>
      <tr>
        <td valign="top"><xsl:value-of select="$this"/></td>
        <td>
	<xsl:variable name="values">
          <Values>
             <xsl:for-each select="key('atts',$element)">
      	       <xsl:sort select="."/>
<xsl:message>found <xsl:value-of select="name(.)"/></xsl:message>
                <xsl:if test="name(.) = $this">
                 <Val><xsl:value-of select="."/></Val>
                </xsl:if>
               </xsl:for-each>
          </Values>
         </xsl:variable>
         <xsl:for-each select="exsl:node-set($values)/Values/Val">
         <xsl:if test="not(preceding-sibling::Val = .)">
          <xsl:variable name="inner" select="."/>
          <xsl:value-of select="$inner"/>
          <xsl:text> (</xsl:text>
          <xsl:value-of select="count(following-sibling::Val[$inner = .]) + 1"/>
          <xsl:text>) </xsl:text>
         </xsl:if>
        </xsl:for-each>
        </td>
      </tr>
   </xsl:if>
</xsl:for-each>

</table>
</xsl:template>

</xsl:stylesheet>
