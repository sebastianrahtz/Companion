<xsl:stylesheet 
    xmlns:xd="http://www.pnp-software.com/XSLTdoc" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:XSL="http://www.w3.org/1999/XSL/Transform" 
    xmlns:m="http://www.w3.org/1998/Math/MathML" 
    xmlns:edate="http://exslt.org/dates-and-times"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    exclude-result-prefixes="tei xd m xsl edate fo XSL"
    version="1.0">

<xsl:key name="XDTEMPLATES" match="xd:doc[following-sibling::xsl:*[1]/self::xsl:template]" use="@class"/>
<xsl:key name="XDPARAMS" match="xd:doc[following-sibling::xsl:*[1]/self::xsl:param]" use="@class"/>

<xsl:output indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="PATH"/>
<xsl:include href="verbatim.xsl"/>

<xsl:template match="/tei:div">
 <tei:div1>
   <tei:head>Customization variables and templates</tei:head>
  <xsl:apply-templates/>
 </tei:div1>
</xsl:template>

<xsl:template match="tei:div">
<div2 xmlns="http://www.tei-c.org/ns/1.0">
<xsl:apply-templates select="@*|text()|*"/>
<xsl:if test="@xml:id">
	<xsl:call-template name="listparams">
	  <xsl:with-param name="Type">common</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="listparams">
	  <xsl:with-param name="Type">html</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="listparams">
	  <xsl:with-param name="Type">fo</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="listparams">
	  <xsl:with-param name="Type">latex</xsl:with-param>
	</xsl:call-template>

      <xsl:call-template name="listtemplates">
	<xsl:with-param name="Type">common</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="listtemplates">
	<xsl:with-param name="Type">html</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="listtemplates">
	<xsl:with-param name="Type">fo</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="listtemplates">
	<xsl:with-param name="Type">latex</xsl:with-param>
      </xsl:call-template>

</xsl:if>
</div2>
</xsl:template>

<xsl:template name="listparams">
  <xsl:param name="Type"/>
  <xsl:variable name="I" select="@xml:id"/>
  <xsl:for-each
      select="document(concat($PATH,$Type,'/tei-param.xsl'))">
    <xsl:if test="count(key('XDPARAMS',$I))&gt;0">
      <div3 xmlns="http://www.tei-c.org/ns/1.0">
	<head xmlns="http://www.tei-c.org/ns/1.0">(<xsl:value-of select="$Type"/>) parameters</head>
      <glossList rend="small" xmlns="http://www.tei-c.org/ns/1.0">
	  <xsl:for-each select="key('XDPARAMS',$I)">
	  <label xmlns="http://www.tei-c.org/ns/1.0">
	  <ident xmlns="http://www.tei-c.org/ns/1.0">
	    <xsl:value-of select="following-sibling::xsl:*[1]/@name"/>
	  </ident>
	  </label>
	  <item xmlns="http://www.tei-c.org/ns/1.0">
	    <xsl:text> (</xsl:text>
	    <xsl:value-of select="@type"/>
	    <xsl:text>) </xsl:text>
	    <xsl:choose>
	      <xsl:when test="starts-with(xd:short,'[')">
		<xsl:value-of select="substring-after(xd:short,']')"/>
	      </xsl:when>
	      <xsl:when test="xd:short"><xsl:apply-templates
	      select="xd:short"/></xsl:when>
	      <xsl:when test="starts-with(.,'[')">
		<xsl:value-of select="substring-after(.,']')"/>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:apply-templates select="*|text()"/>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:apply-templates select="xd:long"/>
	    <xsl:for-each select="following-sibling::xsl:*[1]">
	      <xsl:choose>
		<xsl:when test="*">
		  <egXML xmlns="http://www.tei-c.org/ns/Examples">
		    <xsl:copy-of select="*|text()"/>
		  </egXML>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:text>&#160;</xsl:text>
		  <code rend="box" xmlns="http://www.tei-c.org/ns/1.0">
		    <xsl:apply-templates/>
		  </code>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:for-each>
	  </item>
	  </xsl:for-each>
      </glossList>
      </div3>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="listtemplates">
  <xsl:param name="Type"/>
  <xsl:variable name="I" select="@xml:id"/>
  <xsl:for-each
      select="document(concat($PATH,$Type,'/tei-param.xsl'))">
    <xsl:if test="count(key('XDTEMPLATES',$I))&gt;0">
      <div3 xmlns="http://www.tei-c.org/ns/1.0">
	<head xmlns="http://www.tei-c.org/ns/1.0">(<xsl:value-of select="$Type"/>) templates</head>
	<glossList  rend="small" xmlns="http://www.tei-c.org/ns/1.0">
	  <xsl:for-each select="key('XDTEMPLATES',$I)">
	      <label xmlns="http://www.tei-c.org/ns/1.0">
		<ident xmlns="http://www.tei-c.org/ns/1.0">
		  <xsl:value-of select="following-sibling::xsl:*[1]/@name"/>
		</ident>
	      </label>
	      <item xmlns="http://www.tei-c.org/ns/1.0">
		  <xsl:choose>
		    <xsl:when test="starts-with(xd:short,'[')">
		      <xsl:value-of select="substring-after(xd:short,']')"/>
		    </xsl:when>
		    <xsl:when test="xd:short"><xsl:apply-templates
		    select="xd:short"/></xsl:when>
		    <xsl:when test="starts-with(.,'[')">
		      <xsl:value-of select="substring-after(.,']')"/>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:apply-templates select="*|text()"/>
		    </xsl:otherwise>
		  </xsl:choose>
		  <xsl:apply-templates select="xd:long"/>
		  <xsl:for-each select="following-sibling::xsl:*[1]">
		    <xsl:choose>
		      <xsl:when test="*">
			<egXML xmlns="http://www.tei-c.org/ns/Examples">
			  <xsl:copy-of select="*|text()"/>
			</egXML>
		      </xsl:when>
		      <xsl:otherwise>
			&#160;<code rend="box"  xmlns="http://www.tei-c.org/ns/1.0">
			  <xsl:value-of select="."/>
			</code>
		      </xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	      </item>
	  </xsl:for-each>
	</glossList>
      </div3>
    </xsl:if>
  </xsl:for-each>
</xsl:template>
      
<xsl:template match="*">
 <xsl:element name="{local-name(.)}" xmlns="http://www.tei-c.org/ns/1.0">
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
 </xsl:element>
</xsl:template>

<xsl:template match="xd:*">
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
</xsl:template>

<xsl:template match="text()|processing-instruction()|comment()|@*">
    <xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>

