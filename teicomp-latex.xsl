<xsl:stylesheet
    xmlns:dbk="http://docbook.org/docbook-ng"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:XSL="http://www.w3.org/1999/XSL/Transform" 
    xmlns:teix="http://www.tei-c.org/ns/Examples"
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
<!---->
<xsl:import
    href="/usr/share/xml/tei/stylesheet/latex/tei.xsl"/>

<xsl:import href="teicomp-common.xsl"/>

<xsl:param name="institution">TEI Consortium</xsl:param>
<xsl:param name="dateWord"></xsl:param>
<xsl:param name="authorWord">Author:</xsl:param>
<xsl:param name="revisedWord">revised</xsl:param>
<xsl:param name="dateWord"></xsl:param>
<xsl:param name="realFigures">true</xsl:param>
<xsl:param name="latexLogoFile">logo.pdf</xsl:param>
<xsl:param name="classParameters"></xsl:param>
<xsl:param name="pageSetup"></xsl:param>
<xsl:output method="text" encoding="utf8"/>

<xsl:template name="latexPackages">
\usepackage{longtable}
\usepackage{teicomp}
</xsl:template>

<xsl:template name="latexLayout">
\setlength\textheight{526pt} % integral number of lines! 4pt's missing
\renewcommand\TTCTexampleIdentification
   {The TEI Companion, (January 2006)}
\newenvironment{bibitemlist}[1]{%
   \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}%
	}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}%
  {\def\@noitemerr
    {\@latex@warning{Empty `bibitemlist' environment}}%
    \endlist}

</xsl:template>

<xsl:template name="preambleHook">
\def\author#1{\gdef\@author{#1}}
</xsl:template>

<xsl:template name="latexBegin">
\begin{halftitlepage}
\title{The TEI Companion}
\subtitle{A guide to the Text Encoding Initiative}
\end{halftitlepage}

\begin{seriespage}
\end{seriespage}


\begin{titlepage}
\title{The TEI Companion}
\subtitle{A guide to the Text Encoding Initiative}
\author{Lou Burnard}
\author{Sebastian Rahtz}
\address{Oxford University Computing Services}


\end{titlepage}

\begin{copyrightpage}
\copyrightyear{2006}
\ISBN{xxxxxxxxxxxxxx}
\AWcode{xxxxxxxxxxxx}
\edition{First printing, January 2006}
\begin{LofCCinP}
gooblebygook
\end{LofCCinP}
\end{copyrightpage}

\begin{dedicationpage}
\begin{fullpage}
\vspace*{\stretch{2}}
\begin{quote}
\begin{tabular}{@{\hspace{1.8cm}}p{\linewidth-2cm}@{\hspace{.2cm}}}
  \begin{quote}\raggedright
  We dedicate this book to Xanana Gusmão, President of East
  Timor\end{quote}
\end{tabular}
\end{quote}

\vspace*{\stretch{2}}
\end{fullpage}
\end{dedicationpage}
</xsl:template>


<xsl:template match="tei:verbatim[@url]">
\VerbatimInput[numbers=left]{<xsl:value-of select="@url"/>}
</xsl:template>

<xsl:template match="tei:verbatim">
<xsl:choose>
<xsl:when test="@n">
\begin{Verbatim}[numbers=left,label={<xsl:value-of select="@n"/>}]
<xsl:apply-templates mode="eg"/>
\end{Verbatim}
</xsl:when>
<xsl:otherwise>
\begin{Verbatim}[numbers=left]
<xsl:apply-templates mode="eg"/>
\end{Verbatim}
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="tei:gi">
<xsl:text>\texttt{&lt;</xsl:text>
<xsl:apply-templates/>
<xsl:text>&gt;}</xsl:text>
</xsl:template>

<xsl:template match="tei:ident">
<xsl:text>\textsf{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
 </xsl:template>

<xsl:template match="tei:code">
<xsl:text>\texttt{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="tei:code[@rend='box']">
<xsl:text>\fbox{\texttt{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="tei:kw">
<xsl:text>{\ttfamily\underline{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="tei:value">
<xsl:text>`{\ttfamily </xsl:text>
<xsl:apply-templates/>
<xsl:text>}'</xsl:text>
</xsl:template>


<xsl:template match="tei:path">
<xsl:text>\path{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
 </xsl:template>

<xsl:template match="tei:command">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:software">
<xsl:text>\textit{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="tei:url">
<xsl:text>\url{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
 </xsl:template>

<xsl:template match="tei:oList">
\begin{enumerate}
<xsl:apply-templates/>
\end{enumerate}
 </xsl:template>

<xsl:template match="tei:uList">
\begin{itemize}
<xsl:apply-templates/>
\end{itemize}
</xsl:template>


<xsl:template match="tei:glossList/tei:label"/>
<xsl:template match="tei:glossList/tei:item">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:glossList">
\begin{description}
<xsl:for-each select="tei:label">
  \item[<xsl:apply-templates/>]
<xsl:apply-templates select="following-sibling::tei:item[1]"/>
</xsl:for-each>
\end{description}
</xsl:template>

<xsl:template match="tei:glossList[@rend='small']">
\begin{small}
\begin{description}
<xsl:for-each select="tei:label">
  \item[<xsl:apply-templates/>]
<xsl:apply-templates select="following-sibling::tei:item[1]"/>
</xsl:for-each>
\end{description}
\end{small}
</xsl:template>

<xsl:template match="tei:entity">
<xsl:text>\</xsl:text>
<xsl:value-of select="@name"/>
<xsl:text>{}</xsl:text>
</xsl:template>

<xsl:template match="teix:egXML">
  <xsl:call-template name="verbatim">
    <xsl:with-param name="text">
  <xsl:choose>
    <xsl:when test="@url">
      <xsl:apply-templates select="document(@url)/*" mode="verbatim"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="node()[1]/self::text()">&#10;</xsl:if>
      <xsl:apply-templates mode="verbatim"/>
    </xsl:otherwise>
  </xsl:choose>
    </xsl:with-param>
      <xsl:with-param name="label">
	<xsl:if test="teix:*">
	<xsl:for-each select="ancestor::tei:div[last()]">
	  <xsl:number/>
	</xsl:for-each>
	<xsl:text>.</xsl:text>
	<xsl:number level="any" from="tei:div[last()]" count="teix:egXML"/>
	</xsl:if>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

  <xsl:template name="verbatim">
    <xsl:param name="label"/>
    <xsl:param name="text"/>
    <xsl:param name="startnewline">false</xsl:param>
    <xsl:param name="autowrap">false</xsl:param>

    <xsl:choose>
      <xsl:when test="$label=''">
	<xsl:text>&#10;\begin{XML}[commandchars=\\\{\}]</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>&#10;\begin{XML}[commandchars=\\\{\},label=</xsl:text>
	<xsl:value-of select="$label"/>
	<xsl:text>]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
      <xsl:choose>
	<xsl:when test="$autowrap='false'">
	  <xsl:value-of select="$text"/>
	</xsl:when>
	<xsl:otherwise>           
	  <xsl:variable name="lines" select="estr:tokenize($text,'&#10;')"/>
	  <xsl:apply-templates select="$lines[1]" 
			       mode="normalline"/>
	</xsl:otherwise>
      </xsl:choose>
    <xsl:choose>
      <xsl:when test="$label=''">
	<xsl:text>&#10;\end{XML}&#10;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>&#10;\end{XML}&#10;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<xsl:template name="formatComment">
  <xsl:param name="text"/>
  <xsl:choose>
    <xsl:when test="contains($text,'&#10;')">
      <xsl:text>\textit{</xsl:text>
      <xsl:value-of select="substring-before($text,'&#10;')"/>
      <xsl:text>}&#10;</xsl:text>
      <xsl:call-template name="formatComment">
	<xsl:with-param name="text" select="substring-after($text,'&#10;')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
    <xsl:text>\textit{</xsl:text>
    <xsl:value-of select="$text"/>
    <xsl:text>}</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="comment()" mode="verbatim">
  <xsl:text>&#10;&lt;!--</xsl:text>
  <xsl:call-template name="formatComment">
    <xsl:with-param name="text" select="."/>
  </xsl:call-template>
  <xsl:text>--&gt;&#10;</xsl:text>
</xsl:template>

<xsl:template match="text()" mode="verbatim">
  <xsl:call-template name="wraptext">
    <xsl:with-param name="indent">
      <xsl:for-each select="ancestor::teix:*|ancestor::rng:*">
	<xsl:text> </xsl:text>
      </xsl:for-each>
    </xsl:with-param>
    <xsl:with-param name="text">
      <xsl:value-of select="translate(.,'\{}','&#8421;&#10100;&#10101;')"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="wraptext">
  <xsl:param name="indent"/>
  <xsl:param name="text"/>
  <xsl:choose>
    <xsl:when test="contains($text,'&#10;')">
      <xsl:value-of select="substring-before($text,'&#10;')"/>
      <xsl:text>&#10;</xsl:text>
      <xsl:value-of select="$indent"/>
      <xsl:call-template name="wraptext">
	<xsl:with-param name="indent">
	  <xsl:value-of select="$indent"/>
	</xsl:with-param>
	<xsl:with-param name="text">
	  <xsl:value-of select="substring-after($text,'&#10;')"/>
	</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="*" mode="verbatim">
 <xsl:variable name="Indent">
   <xsl:call-template name="makeIndent"/>
 </xsl:variable>
  <xsl:choose>
    <xsl:when test="preceding-sibling::node()[1]/self::*">
      <xsl:text>&#10;</xsl:text>
      <xsl:value-of select="$Indent"/>
    </xsl:when>
    <xsl:when test="not(preceding-sibling::node())">
      <xsl:text>&#10;</xsl:text>
	<xsl:value-of select="$Indent"/>
    </xsl:when>
  </xsl:choose>
  <xsl:text>&lt;</xsl:text>
  <xsl:text>\textbf{</xsl:text>
  <xsl:choose>
    <xsl:when test="self::dbk:*">db:</xsl:when>
    <xsl:when test="self::XSL:*">xsl:</xsl:when>
    <xsl:when test="self::rng:*">rng:</xsl:when>
  </xsl:choose>
  <xsl:value-of select="local-name(.)"/>
  <xsl:text>}</xsl:text>
  <xsl:for-each select="@*">
    <xsl:choose>
      <xsl:when test="position()=1">
	<xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>&#10;</xsl:text>
	<xsl:value-of select="$Indent"/>
	<xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  <xsl:value-of select="local-name(.)"/>="<xsl:value-of select="."/>"</xsl:for-each>
  <xsl:choose>
    <xsl:when test="child::node()">
      <xsl:text>&gt;</xsl:text>
      <xsl:apply-templates mode="verbatim"/>
      <xsl:choose>
	<xsl:when test="comment() and not(text()) and not(*)">
	  <xsl:value-of select="$Indent"/>
	</xsl:when>
	<xsl:when
	    test="child::node()[last()]/self::text()[normalize-space(.)='']"> 
	  <xsl:text>&#10;</xsl:text>
	  <xsl:value-of select="$Indent"/>
	</xsl:when>
	<xsl:when
	    test="child::node()[last()]/self::comment()"> 
	  <xsl:text>&#10;</xsl:text>
	  <xsl:value-of select="$Indent"/>
	</xsl:when>
	<xsl:when
	    test="child::node()[last()]/self::*"> 
	  <xsl:text>&#10;</xsl:text>
	  <xsl:value-of select="$Indent"/>
	</xsl:when>
      </xsl:choose>
      <xsl:text>&lt;/</xsl:text>
      <xsl:text>\textbf{</xsl:text>
      <xsl:choose>
      <xsl:when test="self::dbk:*">db:</xsl:when>
      <xsl:when test="self::XSL:*">xsl:</xsl:when>
      <xsl:when test="self::rng:*">rng:</xsl:when>
      </xsl:choose>
      <xsl:value-of select="local-name(.)"/>
      <xsl:text>}</xsl:text>
      <xsl:text>&gt;</xsl:text>
    </xsl:when>    
    <xsl:otherwise>
      <xsl:text>/&gt;</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="compositeNumber">
  <xsl:number level="any" from="tei:div"/>
</xsl:template>

  <xsl:template name="makePic">
  <xsl:text>\WideGraphics[</xsl:text>
  <xsl:call-template name="graphicsAttributes">
    <xsl:with-param name="mode">latex</xsl:with-param>
  </xsl:call-template>
  <xsl:text>]{</xsl:text>
  <xsl:value-of select="@url"/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template name="makeIndent">
<xsl:choose>
  <xsl:when test="ancestor::teix:egXML">
    <xsl:for-each select="ancestor::teix:*|ancestor::rng:*|ancestor::XSL:*">
      <xsl:text> </xsl:text>
    </xsl:for-each>
  </xsl:when>
  <xsl:otherwise>
    <xsl:for-each select="ancestor::*">
      <xsl:text> </xsl:text>
    </xsl:for-each>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
