<xsl:stylesheet 
  xmlns:tei="http://www.tei-c.org/ns/1.0" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0"
>

<xsl:output method="text"/>
<xsl:template match="/">
  <xsl:for-each select="//tei:pb">
*      <xsl:value-of select="local-name(..)"/>
  </xsl:for-each>
</xsl:template>
</xsl:stylesheet>


