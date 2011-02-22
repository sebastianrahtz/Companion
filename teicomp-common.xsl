<xsl:stylesheet
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns:rss="http://purl.org/rss/1.0/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
 xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
 xmlns:exsl="http://exslt.org/common"
 xmlns:estr="http://exslt.org/strings"
 xmlns:cc="http://web.resource.org/cc/"
 extension-element-prefixes="exsl estr"
 exclude-result-prefixes="exsl cc rdf"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="1.0">

<xsl:key name="IDS" match="*[@xml:id]" use="@xml:id"/>


<xsl:template match="tei:transclude">
  <xsl:apply-templates select="document(@url)"/>
</xsl:template>

</xsl:stylesheet>
