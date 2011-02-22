<!--

 XSL stylesheet to format EETS TEI XML documents to HTML

 Copyright 2003 Lou Burnard and Sebastian Rahtz/Text Encoding Initiative
 <sebastian.rahtz@oucs.ox.ac.uk>

 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and any associated documentation files (the
 ``Software''), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:
 
 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.
--> 
<xsl:stylesheet
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:exsl="http://exslt.org/common"
    exclude-result-prefixes="exsl" 
    extension-element-prefixes="exsl tei"
    version="1.0">


  <xsl:import href="/usr/share/xml/tei/stylesheet/base/p5/html/tei.xsl"/>
  <xsl:param name="inputName">index</xsl:param>
  <xsl:param name="numberBackHeadings"></xsl:param>
  <xsl:param name="pageLayout">Table</xsl:param>
  <xsl:param name="splitLevel">0</xsl:param>
  <xsl:param name="STDOUT">false</xsl:param>
  <xsl:param name="cssFile">eets.css</xsl:param>
  <xsl:param name="bottomNavigationPanel"></xsl:param>
  <xsl:param name="feedbackURL"></xsl:param>
  <xsl:param name="homeLabel">EETS</xsl:param>
  <xsl:param name="subTocDepth">0</xsl:param>
  <xsl:param name="verbose"></xsl:param>
  <xsl:param name="homeURL">http://www.soton.ox.ac.uk/eets/</xsl:param>

  <xsl:param name="Width">760</xsl:param>

  <xsl:template name="logoFramePicture"/>

<xsl:key name="NOTES" match="tei:note" use="substring-after(@target,'#')"/>
<xsl:key name="PPS" match="tei:list[@type='appcrit']/tei:pp" use="substring-after(@target,'#')"/>
<xsl:key name="TRANS-N" match="tei:text[@type='translated']//tei:p[@n]" use="@n"/>
<xsl:key name="TRANS-TEXT" match="tei:text[@type='text-trans']" use="@xml:id"/>

<xsl:template name="unknownRendBlock">
 <xsl:param name="rend"/>
 <xsl:param name="rest"/>
 <xsl:attribute name="class">
	<xsl:value-of select="$rend"/>
 </xsl:attribute>
     <xsl:call-template name="applyRend">
      <xsl:with-param name="parms" select="$rest"/>
     </xsl:call-template>
 </xsl:template>

<xsl:template name="unknownRendInline">
 <xsl:param name="rend"/>
 <xsl:param name="rest"/>
 <span class="{$rend}">
     <xsl:call-template name="applyRend">
      <xsl:with-param name="parms" select="$rest"/>
     </xsl:call-template>
   </span>
 </xsl:template>

<xsl:template match="/">

  <!-- the top-level TEI itself -->
    <xsl:for-each select="tei:TEI">
        <xsl:call-template name="doPageTable">
           <xsl:with-param name="currentID" select="$ID"/>
        </xsl:call-template>
    </xsl:for-each>

  <!-- separate file for each subgroup text -->
  <xsl:for-each select="tei:TEI/tei:text/tei:group/tei:text">
    <xsl:message>Top-level text <xsl:value-of select="@xml:id"/></xsl:message>
    <xsl:choose>
    <xsl:when test="tei:group/tei:text">
      <xsl:variable name="i">
       <xsl:apply-templates select="." mode="ident"/>
      </xsl:variable>
      <xsl:call-template name="doPageTable">       
        <xsl:with-param name="currentID" select="$i"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="i">
       <xsl:apply-templates select="." mode="ident"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="@type='text-trans'">
           <xsl:call-template name="doPageTable">
             <xsl:with-param name="currentID" select="$i"/>
           </xsl:call-template>                 
         </xsl:when>
         <xsl:otherwise>
           <xsl:call-template name="doPageTable">
             <xsl:with-param name="currentID" select="$i"/>
           </xsl:call-template>      
         </xsl:otherwise>
       </xsl:choose>
     </xsl:otherwise>
   </xsl:choose>
    </xsl:for-each>

</xsl:template>

<xsl:template match="tei:text" mode="generateLink">
  <xsl:variable name="ident">
   <xsl:apply-templates select="." mode="ident"/>
  </xsl:variable>
  <xsl:variable name="Hash">
   <xsl:text>#</xsl:text>
  </xsl:variable>
  <xsl:value-of select="concat($ident,$standardSuffix)"/>
</xsl:template>


<xsl:template match="tei:divGen[@type='text+trans']">
  <table cellspacing="20">
    <tr>
      <td width="50%" class="tablehead">Text</td>
      <td width="50%" class="tablehead">Translation</td>
    </tr>
    <xsl:for-each select="//tei:text[@type='edited']/tei:body">
      <xsl:for-each select="tei:p">
        <tr><td colspan="2"><hr/></td></tr>
       <tr>
        <td valign="top">
        <xsl:if test="@xml:id">
         <a name="TEXTTRANS{@xml:id}"/>
         [<a>
         <xsl:attribute name="href">
          <xsl:apply-templates mode="generateLink" 
            select="key('IDS',@xml:id)"/>
          </xsl:attribute>
          <span class="paraid"><xsl:value-of select="substring-after(@xml:id,'P')"/></span>]
        </a>
         </xsl:if>
         <xsl:apply-templates/>
         </td>
         <td valign="top">    
	   <a name="TOP"/>
	   <xsl:variable name="TO">
	     <xsl:value-of select="substring-after(@xml:id,'P')"/>
	   </xsl:variable>
	   <xsl:choose>
	     <xsl:when test="$TO=''">             
	       <xsl:apply-templates mode="simple"
				    select="key('TRANS-N',substring-after(following-sibling::tei:p/@xml:id,'P'))/preceding-sibling::tei:p"/>             
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:apply-templates mode="simple"
				    select="key('TRANS-N',$TO)"/>             
	     </xsl:otherwise>
	   </xsl:choose>
	 </td>
       </tr>
      </xsl:for-each>
    </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="tei:divGen[@type='mslist']">
  <xsl:for-each select="ancestor::tei:group/tei:text[@type='repro']/tei:body/tei:div">
  <p>
    <xsl:for-each select="tei:head">
      <xsl:apply-templates/>
     </xsl:for-each>
  </p>
  <p>  <xsl:for-each select="tei:p/tei:figure">
  <xsl:if test="preceding-sibling::tei:figure">  | </xsl:if>
   <a class="crosslink">
     <xsl:attribute name="href">
       <xsl:apply-templates select="key('IDS',substring-after(@corresp,'#'))" mode="generateLink"/>
     </xsl:attribute>
     <xsl:value-of select="@n"/>
   </a>
 </xsl:for-each>
</p>
</xsl:for-each>
</xsl:template>

<xsl:template match="tei:divGen[@type='mstxtList']"/>

<xsl:template match="tei:text" mode="msname">
  <xsl:variable name="idroot">
    <xsl:value-of select="substring-before(@xml:id,'-trans')"/>
  </xsl:variable>
  <xsl:for-each select="key('IDS',concat($idroot,'-desc'))">
    <xsl:value-of select="tei:head"/>
  </xsl:for-each>
</xsl:template>
 
<xsl:template name="stdfooter">
  <xsl:param name="date"/>
  <xsl:param name="author"/>
  <xsl:param name="style" select="'plain'"/>
     <xsl:choose>
       <xsl:when test="ancestor::tei:text[@type='mss']/tei:group/tei:text">
        <ul>
          <xsl:for-each select="ancestor::tei:text[@type='mss']/tei:group/tei:text">      
         <xsl:variable name="i">
          <xsl:apply-templates select="." mode="ident"/>
         </xsl:variable>
         <xsl:variable name="msname">
          <xsl:apply-templates select="." mode="msname"/>
         </xsl:variable>
         <xsl:if test="preceding-sibling::tei:text"> | </xsl:if>
         <a class="crosslink" 
           href="{$i}.html"><xsl:value-of select="$msname"/></a> 
         </xsl:for-each>
        </ul>
       </xsl:when>
       <!--
       <xsl:when test="group/text">
         <xsl:call-template name="transcrTop">
           <xsl:with-param name="which">0</xsl:with-param>
         </xsl:call-template>
       </xsl:when>
-->
     </xsl:choose>

     <hr/>
    <div class="inlinetoc">
           <xsl:call-template name="eetstoc">
             <xsl:with-param name="inline">true</xsl:with-param>
             <xsl:with-param name="unit">span</xsl:with-param>
             <xsl:with-param name="class">inlinetoc</xsl:with-param>
           </xsl:call-template>
    </div>

<address>

 <xsl:comment><xsl:text>
Generated </xsl:text>
 <xsl:if test="not($masterFile='index')">
   <xsl:text>from </xsl:text>
   <xsl:value-of select="$masterFile"/>
</xsl:if>
<xsl:text> using an XSLT version </xsl:text>
<xsl:value-of select="system-property('xsl:version')"/> stylesheet
based on <xsl:value-of select="$teixslHome"/>teihtml.xsl
processed using <xsl:value-of select="system-property('xsl:vendor')"/>
on <xsl:call-template name="whatsTheDate"/>
</xsl:comment>
</address>
</xsl:template>


<xsl:template name="transcrTop">
  <xsl:param name="which"/>
  <xsl:for-each select="tei:group/tei:text">      
         <xsl:variable name="i">
          <xsl:apply-templates select="." mode="ident"/>
         </xsl:variable>
         <xsl:variable name="msname">
          <xsl:apply-templates select="." mode="msname"/>
         </xsl:variable>
         <xsl:if test="preceding-sibling::tei:text"> | </xsl:if>
         <a href="{$i}.html" class="crosslink">
           <xsl:attribute name="class">
             <xsl:choose>
               <xsl:when test="position()=$which">
                 <xsl:text>thisTranscription</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                 <xsl:text>Transcription</xsl:text>
               </xsl:otherwise>
             </xsl:choose>
           </xsl:attribute>
           <xsl:value-of select="$msname"/>
         </a> 
  </xsl:for-each>
</xsl:template>

<xsl:template name="copyrightStatement">
  <div class="copyright">&#169; EETS 2003.
Alfred Jewel reproduced by kind permission of the Ashmolean Museum, Oxford.
</div>
</xsl:template>


<xsl:template name="mainFrame">
 <xsl:param name="currentID"/>
 <xsl:param name="force">0</xsl:param>
 <xsl:comment>ID <xsl:value-of select="$currentID"/></xsl:comment>
 <xsl:choose>
    <!-- a) We are processing a TEI element.
            ie the top-level.

            Do everything except the groups inside the text

      -->
   <xsl:when test="self::tei:TEI">
     <xsl:comment>case 1</xsl:comment>     
     <!-- generate files for each of the divs in the front and back-->
     <xsl:for-each select="tei:text/tei:front/tei:div">
       <xsl:variable name="i">
          <xsl:apply-templates select="." mode="ident"/>
       </xsl:variable>
       <xsl:call-template name="doPageTable">
         <xsl:with-param name="currentID" select="$i"/>
       </xsl:call-template>
    </xsl:for-each>
    <xsl:for-each select="tei:text/tei:back/tei:div">
       <xsl:variable name="i">
          <xsl:apply-templates select="." mode="ident"/>
       </xsl:variable>
       <xsl:call-template name="doPageTable">
         <xsl:with-param name="currentID" select="$i"/>
       </xsl:call-template>
    </xsl:for-each>
    <!-- and now a TOC, just covering the front, in a silly style -->
     <xsl:for-each select="tei:text/tei:front">
      <xsl:choose>
      <xsl:when test="tei:div">
        <table cellspacing="10">
          <tr>
            <td colspan="2">
         <xsl:for-each select="tei:div[1]">
           <xsl:variable name="where">
             <xsl:apply-templates select="." mode="generateLink"/>
           </xsl:variable>
           <xsl:call-template name="toptitle"/>
           <p><xsl:apply-templates select="tei:argument" mode="ok"/></p>
         </xsl:for-each>
       </td>
     </tr>
     <tr>
       <td valign="top">
         <xsl:for-each select="tei:div[2]">
           <xsl:variable name="where">
             <xsl:apply-templates select="." mode="generateLink"/>
           </xsl:variable>
           <xsl:call-template name="toptitle"/>
           <p><img align="left" width="77" height="93"
           src="cartouche.jpg"/>
           <xsl:apply-templates select="tei:argument" mode="ok"/></p>
           <p align="right">
             <a href="{$where}" class="morebutton">read more</a></p>
         </xsl:for-each>
       </td>
       <td valign="top">
         <xsl:for-each select="tei:div[3]">
           <xsl:variable name="where">
             <xsl:apply-templates select="." mode="generateLink"/>
           </xsl:variable>
           <xsl:call-template name="toptitle"/>
           <p><img align="left" width="69" height="62"
           src="alfredjewel.jpg"/>
           <xsl:apply-templates select="tei:argument" mode="ok"/></p>
           <p align="right">
             <a href="{$where}" class="morebutton">read more</a></p>
         </xsl:for-each>
       </td>
</tr>
</table>
     </xsl:when>
     <xsl:when test="tei:text">
       <ul class="toc{$force}">
        <xsl:apply-templates select="tei:text" mode="maketoc">
         <xsl:with-param name="forcedepth" select="$force"/>
        </xsl:apply-templates>
       </ul>    
     </xsl:when>
     </xsl:choose>
    </xsl:for-each>
   </xsl:when>

   <!-- b) we are <text> which contains a <group> of <text>s. 
            process everything but subgroups -->
   <xsl:when test="tei:group/tei:text">
     <xsl:comment>case 2</xsl:comment>     

      <xsl:call-template name="toptitle"/>
      <xsl:apply-templates select="*[not(local-name(.)='group')]"/>
      <!-- and now dump each text in a file of its own -->
      <xsl:for-each select="group/text">      
       <xsl:variable name="i">
          <xsl:apply-templates select="." mode="ident"/>
       </xsl:variable>
       <xsl:call-template name="doPageTable">
         <xsl:with-param name="currentID" select="$i"/>
       </xsl:call-template>
      </xsl:for-each>
   </xsl:when>

   <!-- none of the above, but we have no ID to home in on -->
   <xsl:when test="$currentID=''">
     <xsl:comment>case 3</xsl:comment>     

   <!-- we need to locate the first interesting object in the file -->
      <xsl:for-each select=".">
        <xsl:apply-templates select="."/>
        <xsl:if test="tei:div/tei:head">
          <p><b>Sections in this document:</b></p>
          <ul>
              <xsl:apply-templates select="tei:div" mode="maketoc">
                <xsl:with-param name="forcedepth" select="'0'"/>
              </xsl:apply-templates>
          </ul>
        </xsl:if>
      </xsl:for-each>
   </xsl:when>

   <!-- we have a specific ID to locate -->
   <xsl:otherwise>
     <xsl:comment>case 4, <xsl:value-of select="@xml:id"/></xsl:comment>     
        <xsl:choose>
          <xsl:when test="count(key('IDS',$currentID))&gt;0">
             <xsl:for-each select="key('IDS',$currentID)">  
             <xsl:choose>
               <!-- we are at the top of a transcription text -->
               <xsl:when test="ancestor::tei:text[@type='transcr']">
               <div class="docTitle">
              <img align="top" src="rightarrow.jpg" width="25" height="31" alt=""/>
               <xsl:apply-templates select="ancestor::tei:text[1]" mode="topheader"/>
              </div>
               <xsl:variable name="this">
                 <xsl:number/>
               </xsl:variable>
               <xsl:for-each select="ancestor::tei:text[@type='transcr']">
                <xsl:call-template name="transcrTop">
                 <xsl:with-param name="which">
                  <xsl:value-of select="$this"/>
                 </xsl:with-param>
               </xsl:call-template>
               </xsl:for-each>

              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="toptitle"/>                 
              </xsl:otherwise>
            </xsl:choose>

            <xsl:call-template name="doDivBody"/>


          </xsl:for-each>
        </xsl:when>
       <xsl:otherwise>
           <!-- the passed ID is a pseudo-XPath expression
            which starts below TEI/text.
            The real XPath syntax is changed to avoid problems
            -->
     <xsl:apply-templates select="ancestor-or-self::tei:TEI[1]/text" mode="xpath">
               <xsl:with-param name="xpath" select="$currentID" />
           </xsl:apply-templates>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:otherwise>
     </xsl:choose>
      <xsl:call-template name="stdfooter">
          <xsl:with-param name="date">
           <xsl:call-template name="generateDate"/>
          </xsl:with-param>
          <xsl:with-param name="author">
            <xsl:call-template name="generateAuthorList"/>
          </xsl:with-param>
          <xsl:with-param name="style" select="'framestdlink'"/>
      </xsl:call-template>
</xsl:template>


<!-- the left-hand menu -->
<xsl:template name="linkListContents">
 <xsl:param name="style" select="'toc'"/>
  <xsl:call-template name="searchBox"/>
  <xsl:call-template name="eetstoc">
    <xsl:with-param name="inline"></xsl:with-param>
    <xsl:with-param name="unit">p</xsl:with-param>
    <xsl:with-param name="class">frametoc</xsl:with-param>
  </xsl:call-template>
</xsl:template>


<xsl:template name="subtoceets">
    <xsl:for-each select="tei:div">
         <p class="frametoc-sub">
                <a class="frametoc-sub">
                  <xsl:attribute name="href">
                    <xsl:apply-templates mode="generateLink" select="." />
                  </xsl:attribute>
                  <xsl:text>&#8211; </xsl:text>
                  <xsl:apply-templates mode="xref" select="." />
                </a>
              </p>
    </xsl:for-each>
</xsl:template>

<xsl:template name="doDivBody">
<xsl:param name="Type"/>
<!--
<xsl:message>  div body [<xsl:value-of select="@xml:id"/>] = <xsl:value-of select="name(.)"/></xsl:message>
-->
<xsl:call-template name="startDivHook"/>
<xsl:variable name="ident">
   <xsl:apply-templates select="." mode="ident"/>
</xsl:variable>
      <xsl:if test="not($Type = '')">
       <xsl:element name="h{$Type + $divOffset}">
        <a name="{$ident}"></a><xsl:call-template name="header"/>
       </xsl:element>
      </xsl:if>  
      <xsl:choose>
        <xsl:when test="self::tei:text[@type='repro']">
          <xsl:apply-templates select="tei:body/tei:div"/>
        </xsl:when>
        <xsl:otherwise>
         <xsl:apply-templates/>          
        </xsl:otherwise>
      </xsl:choose>
  
</xsl:template>

<xsl:template match="tei:group">
  
</xsl:template>

<xsl:template match="tei:front|tei:body|tei:back">
  <xsl:comment>
   Process  <xsl:value-of select="local-name(.)"/> from text <xsl:value-of select="ancestor::tei:text[1]/@xml:id"/>
  </xsl:comment>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:p" mode="simple">
<span>
<xsl:if test="@rend">
   <xsl:attribute name="class"><xsl:value-of select="@rend"/></xsl:attribute>
</xsl:if>
<xsl:apply-templates/>
</span>
</xsl:template>

<xsl:template match="tei:p">
<p>
<xsl:if test="@rend">
   <xsl:attribute name="class"><xsl:value-of select="@rend"/></xsl:attribute>
</xsl:if>
<xsl:choose>
<xsl:when test="@xml:id">
 [<a name="{@xml:id}"/><span class="paraid">
     <xsl:value-of select="substring-after(@xml:id,'P')"/>
  </span>]
</xsl:when>
<xsl:when test="@n">
  <xsl:variable name="i">
    <xsl:apply-templates mode="ident" select="."/>
  </xsl:variable>
 [<a name="{$i}"/>
<span class="paraid">
     <xsl:value-of select="@n"/>
  </span>]
</xsl:when>
</xsl:choose>
<xsl:apply-templates/>
</p>
<xsl:choose>
  <xsl:when test="ancestor::tei:text[@type='translated'] and @n">
    <p>
 <a class="crosslink">
  <xsl:attribute name="href">
    <xsl:apply-templates mode="generateLink" select="key('IDS',concat('P',@n))"/>
  </xsl:attribute>Edited text</a>
  | <a class="crosslink">  
  <xsl:attribute name="href">
    <xsl:apply-templates mode="generateLink" 
      select="/tei:TEI/tei:text/tei:group/tei:text[@type='text-trans']"/>
    <xsl:text>#TEXTTRANS</xsl:text>
    <xsl:value-of select="@n"/>
  </xsl:attribute>Text + Translation</a>
 | <a class="crosslink">
    <xsl:attribute name="href">
      <xsl:for-each select="key('PPS',concat('P',@n))">
        <xsl:apply-templates mode="generateLink" 
             select="ancestor::tei:div[1]"/>
      </xsl:for-each>
      <xsl:text>#appcrit_</xsl:text><xsl:value-of select="concat('P',@n)"/>
  </xsl:attribute>
 Apparatus Criticus</a>
    | <a class="crosslink">
    <xsl:attribute name="href">
      <xsl:apply-templates select="key('NOTES',concat('P',@n))[1]" mode="generateLink"/>
  </xsl:attribute>Textual Commentary</a>
 </p>
 <hr/>
  </xsl:when>
  <xsl:when test="ancestor::tei:text[@type='edited'] and @xml:id">
  <p><a class="crosslink">
    <xsl:attribute name="href">
    <xsl:apply-templates mode="generateLink" 
      select="key('TRANS-N',substring-after(@xml:id,'P'))"/>
 </xsl:attribute>
 Translation</a>
 | <a class="crosslink">
    <xsl:attribute name="href">
    <xsl:apply-templates mode="generateLink" 
      select="/tei:TEI/tei:text/tei:group/tei:text[@type='text-trans']"/>
    <xsl:text>#TEXTTRANS</xsl:text>
    <xsl:value-of select="@xml:id"/>
 </xsl:attribute>
 Text + Translation</a>
 | <a class="crosslink">
    <xsl:attribute name="href">
      <xsl:for-each select="key('PPS',@xml:id)">
        <xsl:apply-templates mode="generateLink" 
             select="ancestor::tei:div[1]"/>
      </xsl:for-each>
      <xsl:text>#appcrit_</xsl:text><xsl:value-of select="@xml:id"/>
  </xsl:attribute>
 Apparatus Criticus</a>
    | <a class="crosslink">
    <xsl:attribute name="href">
      <xsl:apply-templates select="key('NOTES',@xml:id)[1]" mode="generateLink"/>
  </xsl:attribute>Textual Commentary</a>
</p>
 <hr/>
  </xsl:when>
</xsl:choose>
</xsl:template>


<xsl:template name="searchBox">
<form method="get" action="/tei-bin/fluffysearch.pl">
      <label for="words"></label>
      <input type="text" size="15" name="words" id="words" value=" "/>
                  <input type="submit" value="Search"/>
</form>
<hr/>
</xsl:template>


<xsl:template match="tei:text" mode="maketoc">
 <li class="toc">
   <a>
     <xsl:attribute name="href">
        <xsl:apply-templates mode="generateLink" select="."/>  
     </xsl:attribute>
              <xsl:apply-templates
              select="tei:front/tei:titlePage/tei:docTitle/tei:titlePart" />
    </a>
 </li>
</xsl:template>

<xsl:template match="tei:div[@type='notes']" mode="xref">
  <xsl:text>Notes</xsl:text>
</xsl:template>

<xsl:template match="tei:div[@type='notes']" mode="maketoc">
 <li class="toc">
   <a>
     <xsl:attribute name="href">
        <xsl:apply-templates mode="generateLink" select="."/>  
     </xsl:attribute>
     Notes
    </a>
 </li>
</xsl:template>

<xsl:template match="tei:text[@type='mss']/tei:group/tei:text/tei:body/tei:div[@n]" mode="maketoc">
 <li class="toc">
   <a>
     <xsl:attribute name="href">
        <xsl:apply-templates mode="generateLink" select="."/>  
     </xsl:attribute>
     <xsl:value-of select="@n"/>
    </a>
 </li>
</xsl:template>

<xsl:template match="tei:div">  
<!-- establish section depth -->
  <xsl:variable name="depth">
   <xsl:apply-templates select="." mode="depth"/>
 </xsl:variable>
<xsl:variable name="myname">
  <xsl:value-of select="local-name(.)"/>
</xsl:variable>
<xsl:choose>
<!-- 1. our section depth is below the splitting level -->
 <xsl:when test="$depth &gt; $splitLevel or @rend='nosplit'">
   <div  class="teidiv">
   <xsl:call-template name="doDivBody">
      <xsl:with-param name="Type" select="$depth"/>
   </xsl:call-template>
  </div>
 </xsl:when>

<!-- 2. we are at or above splitting level, 
        so start a new file
-->
 <xsl:when test="$depth &lt;= $splitLevel">
   <xsl:call-template name="doPageTable">
           <xsl:with-param name="currentID">
             <xsl:apply-templates select="." mode="ident"/>
           </xsl:with-param>
    </xsl:call-template>
 </xsl:when>
 <xsl:otherwise>
 </xsl:otherwise>
 </xsl:choose>
</xsl:template>


<xsl:template match="tei:list[@type='appcrit']/tei:item">
   <p class="note"><xsl:if test="@xml:id"><a name="#{@xml:id}"/></xsl:if>
   <xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="tei:list[@type='appcrit']">

  <a name="appcrit_{substring-after(tei:pp/@target,'#')}"/>
  <p>
  <xsl:if test="tei:pp">
    <span class="hi-bo">[<xsl:value-of select="substring-after(tei:pp/@target,'P')"/>]</span>
  </xsl:if>
  <xsl:apply-templates/>
  <xsl:if test="tei:pp">
    <a class="crosslink">
    <xsl:attribute name="href">
      <xsl:apply-templates mode="generateLink" select="key('IDS',substring-after(tei:pp/@target,'#'))"/>
    </xsl:attribute>
    Edited text</a> | </xsl:if>
 <a class="crosslink" href="#TOP">Top</a></p>
 <hr/>
</xsl:template>


<xsl:template name="toptitle">
   <div class="docTitle">
    <img align="top" src="rightarrow.jpg" width="25" height="31" alt=""/>
     <xsl:apply-templates select="." mode="topheader"/>
   </div>
</xsl:template>

<xsl:template match="tei:*" mode="topheader">
  <xsl:comment><xsl:value-of select="name(.)"/> </xsl:comment>
  <xsl:choose>
  <xsl:when test="tei:front/tei:titlePage">
    <xsl:apply-templates select="tei:front/tei:titlePage/tei:docTitle" mode="print"/>
  </xsl:when>
  <xsl:when test="tei:head">
    <xsl:apply-templates select="tei:head" mode="plain"/>
  </xsl:when>
  <xsl:when test="name(.)='text'">
    <xsl:apply-templates select="." mode="msname"/>
  </xsl:when>
</xsl:choose>
</xsl:template>


<xsl:template match="tei:note|tei:page" mode="generateLink">
  <xsl:variable name="ident">
   <xsl:apply-templates select="." mode="ident"/>
  </xsl:variable>
 <xsl:variable name="file">
   <xsl:choose>
     <xsl:when test="ancestor::tei:div">
      <xsl:apply-templates select="ancestor::tei:div[1]"  mode="generateLink"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates select="ancestor::tei:text[1]" mode="generateLink"/>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:variable>
 <xsl:choose>
  <xsl:when test="starts-with($file,'#')">
    <xsl:text>#</xsl:text><xsl:value-of select="$ident"/>
  </xsl:when>
  <xsl:when test="contains($file,'#')">
    <xsl:value-of select="substring-before($file,'#')"/>
    <xsl:text>#</xsl:text><xsl:value-of select="$ident"/>
  </xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="$file"/>
    <xsl:text>#</xsl:text><xsl:value-of select="$ident"/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="tei:p" mode="generateLink">
  <xsl:variable name="ident">
   <xsl:apply-templates select="." mode="ident"/>
  </xsl:variable>
 <xsl:variable name="file">
 <xsl:apply-templates   select="ancestor::tei:text[1]" mode="generateLink"/>
 </xsl:variable>
 <xsl:choose>
  <xsl:when test="starts-with($file,'#')">
    <xsl:text>#</xsl:text><xsl:value-of select="$ident"/>
  </xsl:when>
  <xsl:when test="contains($file,'#')">
    <xsl:value-of select="substring-before($file,'#')"/>
    <xsl:text>#</xsl:text><xsl:value-of select="$ident"/>
  </xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="$file"/>
    <xsl:text>#</xsl:text><xsl:value-of select="$ident"/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>


<xsl:template name="pageLayoutTable">
<xsl:param name="currentID"/>
<xsl:param name="content"/>
<html><xsl:call-template name="addLangAtt"/>
 <xsl:comment>THIS FILE IS GENERATED FROM AN XML MASTER. 
              DO NOT EDIT</xsl:comment>
 <head>
   <xsl:variable name="pagetitle">
          <xsl:call-template name="generateTitle"/>
   </xsl:variable>
     <title><xsl:value-of select="$pagetitle"/></title>
 <xsl:call-template name="includeCSS"/>
 <xsl:call-template name="metaHTML">
   <xsl:with-param name="title" select="$pagetitle"/>
 </xsl:call-template>
 <xsl:call-template name="javaScript"/>
 </head>

 <body  class="pagetable" >
  <xsl:call-template name="bodyHook"/>
  <xsl:call-template name="bodyJavaScriptHook"/>

<xsl:call-template name="startHeader"/>
   <xsl:choose>
     <xsl:when test="local-name(.)='TEI'">
        <img src="header1.jpg" width="{$Width - 1}" height="167" 
          alt="EETS Ancrene Wisse banner"/>
     </xsl:when>
     <xsl:otherwise>
        <img src="header2.jpg" width="{$Width} -1" height="121" 
          alt="EETS Ancrene Wisse banner"/>
     </xsl:otherwise>
   </xsl:choose>
<table width="{$Width}" border="0">
<xsl:choose>
  <xsl:when test="ancestor-or-self::tei:text/@rend='wide'">
  <tr>
  <td width="100%" colspan="2" class="linktext">
    <div class="inlinetoc">
      <xsl:call-template name="eetstoc">
       <xsl:with-param name="inline">true</xsl:with-param>
       <xsl:with-param name="unit">span</xsl:with-param>
       <xsl:with-param name="class">inlinetoc</xsl:with-param>
      </xsl:call-template>
    </div>
  </td>
  </tr>
   <tr>
    <td  valign="top" width="100%" class="maintext">
     <xsl:choose>
         <xsl:when test="$currentID='#'">
            <xsl:copy-of select="$content"/>
          </xsl:when>
          <xsl:otherwise>
           <xsl:call-template name="mainFrame">
            <xsl:with-param name="currentID" select="$currentID"/>
           </xsl:call-template>
          </xsl:otherwise>
      </xsl:choose>
     </td>
   </tr>
</xsl:when>
 <xsl:otherwise>
    <tr>
     <td align="left" valign="top" rowspan="2" width="15%" class="linktext">
       <xsl:call-template name="leftHandFrame">
         <xsl:with-param name="currentID" select="$ID"/>
       </xsl:call-template>
     </td>
   </tr>
   <tr>
    <td  valign="top" class="maintext" width="85%">
     <xsl:choose>
         <xsl:when test="$currentID='#'">
            <xsl:copy-of select="$content"/>
          </xsl:when>
          <xsl:otherwise>
           <xsl:call-template name="mainFrame">
            <xsl:with-param name="currentID" select="$currentID"/>
           </xsl:call-template>
          </xsl:otherwise>
      </xsl:choose>
     </td>
   </tr>
</xsl:otherwise>
</xsl:choose>

<tr>
<xsl:choose>
  <xsl:when test="ancestor-or-self::tei:text/@rend='wide'">
  </xsl:when>
  <xsl:otherwise>
    <td>&#160;</td>
  </xsl:otherwise>
</xsl:choose>
 <td><xsl:call-template name="copyrightStatement"/></td>
  </tr>
  </table>
  <xsl:call-template name="endFooter"/>
 </body>
</html>
</xsl:template>

<xsl:template name="leftHandFrame">
  <xsl:param name="currentID"/>
     <xsl:choose>
      <xsl:when test="$currentID=''">
         <xsl:call-template name="linkListContents">
           <xsl:with-param name="style" select="'frametoc'"/>
         </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="count(key('IDS',$currentID))&gt;0">
             <xsl:for-each select="key('IDS',$currentID)">  
               <xsl:call-template name="linkListContents">
                 <xsl:with-param name="style" select="'frametoc'"/>
                 <xsl:with-param name="ID" select="$currentID"/>
               </xsl:call-template>
             </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
           <xsl:apply-templates select="descendant::tei:text" mode="xpath">
               <xsl:with-param name="xpath" select="$currentID" />
               <xsl:with-param name="action" select="'toclist'" />
           </xsl:apply-templates>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:otherwise>
     </xsl:choose>
</xsl:template>



<xsl:template match="tei:titlePage"/>

<xsl:template match="tei:title[@rend='rubric']">
  <span class="rubric"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:text[@type='repro']/tei:body/tei:div">
  <p>
    <xsl:for-each select="tei:head">
      <xsl:apply-templates/>
    </xsl:for-each>
  </p>
  <p>  
    <xsl:for-each select="tei:p/tei:figure">
      <xsl:variable name="ID">
	<xsl:value-of select="substring-after(@corresp,'#')"/>
      </xsl:variable>
      <xsl:if test="preceding-sibling::tei:figure">  | </xsl:if>
      <a class="crosslink" href="Picture{$ID}.html">
	<xsl:value-of select="@n"/>
      </a>

   <!-- make a file with the picture in -->
   <xsl:call-template name="outputChunk">
   <xsl:with-param name="ident">Picture<xsl:value-of select="$ID"/></xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="pageLayoutTable">       
    <xsl:with-param name="currentID">#</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:variable name="back">
        <xsl:for-each select="key('IDS',$ID)">
          <xsl:apply-templates select="." mode="generateLink"/>
        </xsl:for-each>
      </xsl:variable>
      <p>
        <xsl:call-template name="msMenu">
          <xsl:with-param name="ID" select="$ID"/>
          <xsl:with-param name="prefix"/>
        </xsl:call-template>
      </p>
      <p>      <xsl:call-template name="folioMenu">
      <xsl:with-param name="prefix"/></xsl:call-template>
    </p>
      <p><a class="crosslink"  href="{$back}">Transcription  of this page</a> 
      |     <a class="crosslink" 
      href="TextPicture{$ID}.html">Image and Transcription  of this page</a> 
      </p>
      <img src="{$ID}.jpg"/> 
    </xsl:with-param>
    </xsl:call-template>
  </xsl:with-param>
 </xsl:call-template>
 <!-- now the same thing again with text -->
   <xsl:call-template name="outputChunk">
   <xsl:with-param name="ident">TextPicture<xsl:value-of select="$ID"/></xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="pageLayoutTable">       
    <xsl:with-param name="currentID">#</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:variable name="back">
        <xsl:for-each select="key('IDS',$ID)">
          <xsl:apply-templates select="." mode="generateLink"/>
        </xsl:for-each>
      </xsl:variable>
      <p>
        <xsl:call-template name="msMenu">
          <xsl:with-param name="ID" select="$ID"/>
          <xsl:with-param name="prefix">Text</xsl:with-param>
        </xsl:call-template>
      </p>
      <p>      <xsl:call-template name="folioMenu">
      <xsl:with-param name="prefix">Text</xsl:with-param>
      </xsl:call-template></p>
     <table width="100%">
     <tr valign="top">
       <td width="100%">
    <a class="crosslink">
       <xsl:attribute name="href">
         <xsl:apply-templates mode="generateLink" select="key('IDS',$ID)"/>
       </xsl:attribute>
       [Transcribed text]
     </a>
   </td></tr>
   <tr><td>
     <iframe height="250" width="100%" frameborder="no" 
       src="{$ID}.html">transcribed text of MS</iframe>
       <exsl:document href="{$ID}.html">
        <html><head>
        <xsl:variable name="pagetitle">
          <xsl:call-template name="generateDivtitle"/>
        </xsl:variable>
        <title><xsl:value-of select="$pagetitle"/></title>
        <xsl:call-template name="headHook"/>
        <xsl:call-template name="includeCSS"/>
        <xsl:call-template name="metaHTML">
         <xsl:with-param name="title" select="$pagetitle"/>
        </xsl:call-template>
          </head>
        <body><p>
          <xsl:apply-templates
            select="key('IDS',$ID)" mode="splitscreen"/></p>
        </body></html>
      </exsl:document>
        </td>
      </tr>
      <tr>
        <td><iframe  height="250" width="100%" frameborder="no" 
src="{$ID}.jpg">Picture of MS page</iframe> </td>
     </tr>
     </table>
    </xsl:with-param>
    </xsl:call-template>
  </xsl:with-param>
 </xsl:call-template>

 </xsl:for-each>
</p>
</xsl:template>

<xsl:template name="eetstoc">
  <xsl:param name="inline"></xsl:param>
  <xsl:param name="unit">p</xsl:param>
  <xsl:param name="class"/>
  
  <a target="_top" class="{$class}" href="{$inputName}.html">Home</a>
  
  
  <xsl:choose>
    <xsl:when test="$inline='true'"> | </xsl:when>
    <xsl:otherwise><hr/></xsl:otherwise>
  </xsl:choose>
  
  <xsl:variable name="i">
    <xsl:value-of select="generate-id()"/>
  </xsl:variable>
  <xsl:for-each select="/tei:TEI">
    
    <!-- 1. div in top-level text (introductory matter) -->
    <xsl:for-each select="tei:text/tei:front/tei:div[not(@rend='notoc')]">
      <xsl:if test="$inline='true' and preceding-sibling::tei:div[not(@rend='notoc')]"> | </xsl:if>
      <xsl:element name="{$unit}">
	<xsl:attribute name="class">
	  <xsl:value-of	select="$class"/>
	</xsl:attribute>
	<a class="{$class}">
	  <xsl:attribute name="href">
	    <xsl:apply-templates mode="generateLink" select="."/>
	  </xsl:attribute>
	  <xsl:apply-templates mode="xref" select="."/>
      </a></xsl:element>
      <xsl:if test="$inline='' and $i=generate-id()">
	<xsl:call-template name="subtoceets"/>
      </xsl:if>
      <xsl:text>&#10;</xsl:text>
    </xsl:for-each>
  </xsl:for-each>
  
  <xsl:choose>
    <xsl:when test="$inline=''"><hr/></xsl:when>
    <xsl:otherwise> | </xsl:otherwise>
  </xsl:choose>
  
  <xsl:variable name="thisone">
    <xsl:for-each select="ancestor-or-self::tei:text[1]">      
      <xsl:value-of select="generate-id()" />
    </xsl:for-each>
  </xsl:variable>
  
  <!-- 2. the texts within top-level group -->
  <xsl:for-each select="/tei:TEI">
    <xsl:for-each select="tei:text/tei:group/tei:text">
      <xsl:variable name="pointer">
	<xsl:apply-templates mode="generateLink" select="." />
      </xsl:variable>
      
      <xsl:variable name="current">
	<xsl:value-of select="generate-id()" />
      </xsl:variable>
      
      <xsl:choose>
	<!-- if this is our current text -->
	<xsl:when test="$current=$thisone">
	  <xsl:if test="$inline='true' and preceding-sibling::tei:text"> | </xsl:if>
	  <xsl:element name="{$unit}">      
	    <xsl:attribute name="class">
	      <xsl:value-of select="$class"/>
	    </xsl:attribute>
	    <a class="{$class}-this">
	      <xsl:attribute name="href">
		<xsl:apply-templates mode="generateLink" select="." />
	      </xsl:attribute>
	      <xsl:apply-templates
		  select="tei:front/tei:titlePage/tei:docTitle/tei:titlePart" />
	    </a>
	  </xsl:element>
	  <xsl:text>&#10;</xsl:text>
	  
	  <xsl:if test="$inline=''">
	    <!-- ... and any div children it has -->
	    <xsl:for-each select="tei:front|tei:body|tei:back">
	      <xsl:for-each select="tei:div[not(@rend='notoc')]">
		<xsl:if test="$inline='true' and preceding-sibling::tei:div"> | </xsl:if>
		<xsl:element name="{$unit}">
		  <xsl:attribute name="class">
		  <xsl:value-of	select="$class"/>-sub</xsl:attribute>
		  <a class="{$class}-sub">
		    <xsl:attribute name="href">
		      <xsl:apply-templates mode="generateLink" select="."/>
		    </xsl:attribute>
		    <xsl:text>&#8211; </xsl:text>
		    <xsl:apply-templates mode="xref" select="." />
		  </a>
		</xsl:element>
		<xsl:text>&#10;</xsl:text>
	      </xsl:for-each>
	    </xsl:for-each>
	  </xsl:if>
	</xsl:when>
	
	<xsl:otherwise>
	  <xsl:if test="$inline='true' and preceding-sibling::tei:text"> | </xsl:if>
	  <xsl:element name="{$unit}"> 
	    <xsl:attribute name="class">
	      <xsl:value-of  select="$class"/>
	    </xsl:attribute>
	    <a class="{$class}" href="{$pointer}">
	      <xsl:apply-templates
		  select="tei:front/tei:titlePage/tei:docTitle/tei:titlePart" />
	    </a>
	    </xsl:element>
	    <xsl:text>&#10;</xsl:text>
	</xsl:otherwise>
      </xsl:choose>
      <!-- or any MSS children -->
      <xsl:if test="ancestor-or-self::tei:text[@type='mss']">
	<xsl:for-each select="ancestor-or-self::tei:text[@type='mss']/tei:group/tei:text">
	  <xsl:if test="$inline='true' and preceding-sibling::tei:text"> | </xsl:if>
	  <xsl:element name="{$unit}">
	    <xsl:attribute name="class">
	      <xsl:value-of  select="$class"/>-sub</xsl:attribute>
	      <a class="{$class}-sub">
		<xsl:attribute name="href">
		  <xsl:apply-templates mode="generateLink" select="."/>
		</xsl:attribute>
		
		<xsl:text>&#8211; </xsl:text>
		<xsl:apply-templates select="." mode="msname" />
	      </a>
	      </xsl:element><xsl:text>&#10;</xsl:text>
	</xsl:for-each>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>
  
  <xsl:choose>
    <xsl:when test="$inline=''"><hr/></xsl:when>
    <xsl:otherwise> | </xsl:otherwise>
  </xsl:choose>
  
  <!-- 3. finally, the div elements in the back matter -->
  <xsl:for-each select="/tei:TEI">
    <xsl:for-each select="tei:text/tei:back/tei:div">
      <xsl:if test="$inline='true' and preceding-sibling::tei:div"> | </xsl:if>
      <xsl:element name="{$unit}">
	<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
	<a class="{$class}">
	  <xsl:attribute name="href">
	    <xsl:apply-templates mode="generateLink" select="."/>
	  </xsl:attribute>
	  <xsl:apply-templates mode="xref" select="."/>
	</a>
      </xsl:element>
      <xsl:if test="$inline='' and $i=generate-id()">
	<xsl:call-template name="subtoceets"/>
      </xsl:if>
      <xsl:text>&#10;</xsl:text>
    </xsl:for-each> 
    
    <xsl:if test="tei:text/tei:front/tei:div">
      <xsl:choose>
	<xsl:when test="$inline=''"><hr/>  </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:for-each>
</xsl:template>


<xsl:template name="msMenu">
  <xsl:param name="ID"/>
  <xsl:param name="prefix"/>
  <xsl:variable name="myhead">
    <xsl:value-of select="ancestor::tei:div/tei:head"/>          
  </xsl:variable>
  <xsl:for-each select="key('IDS',$ID)">
    <xsl:variable name="mypic">
      <xsl:value-of select="substring-after(@corresp,'#')"/>
    </xsl:variable>
    <xsl:for-each select="ancestor::tei:text[1]">
      <xsl:variable name="me">
	<xsl:value-of select="generate-id()"/>
      </xsl:variable>
      <xsl:for-each select="../text">
	<xsl:if test="preceding-sibling::tei:text"> | </xsl:if>
	<xsl:choose>
	  <xsl:when test="generate-id()=$me">
	    <span>
	      <xsl:attribute name="class">thisMS</xsl:attribute>
	      <xsl:apply-templates select="." mode="msname"/>
	      <xsl:text>: </xsl:text>
	      <xsl:value-of select="$myhead"/>
	    </span>
	  </xsl:when>
	  <xsl:otherwise>
	    <a href="{$prefix}Picture{.//tei:page[1]/@xml:id}.html">
	      <xsl:attribute name="class">MS</xsl:attribute>
	      <xsl:apply-templates select="." mode="msname"/>
	    </a>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>

<xsl:template name="folioMenu">
  <xsl:param name="prefix"/>
  <xsl:variable name="me">
    <xsl:value-of select="generate-id()"/>
  </xsl:variable>
  <xsl:for-each select="../tei:figure">          
  <xsl:if test="preceding-sibling::tei:figure"> | </xsl:if>
  <a href="{$prefix}Picture{substring-after(@corresp,'#')}.html">
    <xsl:attribute name="class">
    <xsl:choose>
      <xsl:when test="generate-id()=$me">
        <xsl:text>folio-this</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>folio</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:attribute>
    <xsl:value-of select="@n"/></a>
  </xsl:for-each>
</xsl:template>

<xsl:template name="generateTitle">
    <xsl:choose>
      <xsl:when test="self::tei:div and tei:head">
        <xsl:value-of select="tei:head"/>
      </xsl:when>
      <xsl:when test="self::tei:text and tei:front/tei:titlePage/tei:docTitle">
        <xsl:value-of select="tei:front/tei:titlePage/tei:docTitle/tei:titlePart"/>
      </xsl:when>
      <xsl:when test="ancestor::tei:text[1]/tei:front/tei:titlePage/tei:docTitle">
	<xsl:value-of select="ancestor::tei:text[1]/tei:front/tei:titlePage/tei:docTitle/tei:titlePart"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:for-each select="ancestor::tei:text[1]">
         <xsl:call-template name="generateTitle"/>        
       </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="tei:titlePart">
  <xsl:apply-templates/>
</xsl:template>



<!-- all the inline messy stuff -->
<xsl:template match="tei:q|tei:soCalled">
  <xsl:text>&#8216;</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>&#8217;</xsl:text>
</xsl:template>

<xsl:template match="tei:quote">
  <xsl:text>&#8220;</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>&#8221;</xsl:text>
</xsl:template>

<xsl:template match="tei:abbr">
  <span class="abbr"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:unclear|tei:term|tei:foreign|tei:fr|tei:hi|tei:lat|tei:me|tei:oe|tei:expan">
  <span class="{name(.)}"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:name">
  <span class="name"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:hi[@rend='BOLD']">
  <b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="tei:hi[@rend='it']">
  <span class="hi-it"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:hi[@rend='ul']">
  <span class="hi-ul"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:hi[@rend='bi']">
  <span class="hi-bi"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:hi[@rend='rubricated']">
  <span class="rubricated"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:add[@hand='later']">
  <span class="addlater"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:add">\<xsl:apply-templates/>/</xsl:template>

<xsl:template match="tei:add[@place='margin']">
  <p class="addfloat"><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="tei:del">
  <xsl:text>&lt;</xsl:text>
  <span class="del"><xsl:apply-templates/></span>
  <xsl:text>&gt;</xsl:text>
</xsl:template>

<xsl:template match="tei:ed">
  <xsl:text>[</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="tei:note" mode="xref">
  <xsl:choose>
   <xsl:when test="@n">
    <xsl:value-of select="@n"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:number level="any" count="tei:note" from="tei:div"/>
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="tei:note/tei:label">
  <span class="hi"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="tei:p/tei:label">
  <span class="hi-bo"><xsl:apply-templates/></span>
  <xsl:text>  </xsl:text>
</xsl:template>


<xsl:template name="noteID">
  <xsl:choose>
   <xsl:when test="@n">
    <xsl:value-of select="@n"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:number level="any" count="tei:note" from="tei:div"/>
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template match="tei:note">
 <xsl:choose>
 <xsl:when test="tei:label or parent::tei:div[@type='notes']">
   <p><xsl:if test="@xml:id"><a name="{@xml:id}"/></xsl:if>
   <xsl:if test="not(@target=preceding-sibling::tei:note/@target) and @target">
      <span class="hi-bo">[<xsl:value-of select="substring-after(@target,'P')"/>]</span>
    </xsl:if></p>
    <p class="note">
   <b><xsl:call-template name="noteID"/></b>.
   <xsl:apply-templates/>
  </p>
  <xsl:if test="not(@target=following-sibling::tei:note/@target) and @target">
    <p>
      <a class="crosslink">
	<xsl:attribute name="href">
	  <xsl:apply-templates select="key('IDS',substring-after(@target,'#'))" mode="generateLink"/>
	</xsl:attribute> 
      [Edited text]</a>
   </p>
  </xsl:if>
 </xsl:when>
 <xsl:otherwise>
   <a href="#Note{@n}">
   <span class="fnmark"><xsl:value-of select="@n"/></span></a>   
 </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="tei:note" mode="printnotes">
  <a name="Note{@n}"/> 
  <span class="fnanchor"><xsl:value-of select="@n"/></span>
  <xsl:apply-templates/>
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="tei:lb">
  <xsl:if test="@rend='iw'">
    <span class='iw'>=</span>
  </xsl:if>
  <xsl:choose>
    <xsl:when test="ancestor::tei:page">
      <br/> <span class="lbbr">
      <xsl:number level="any" from="tei:page"/>
      <xsl:text> </xsl:text></span>
    </xsl:when>
    <xsl:otherwise>
      <span class="lb">
      <xsl:text> </xsl:text>
       <xsl:value-of select="@n"/>
      <xsl:text> </xsl:text>     </span>
     </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:page" mode="splitscreen">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:page">
  <p><a name="{@xml:id}"/>
  MS image: <a class="crosslink" href="Picture{@xml:id}.html"><xsl:value-of select="@xml:id"/></a></p>
  <xsl:apply-templates/>
 <xsl:if test=".//note">
     <p><b>Notes: </b>
      <xsl:apply-templates select=".//tei:note" mode="printnotes"/>  
     </p>
   </xsl:if>

</xsl:template>

<xsl:template match="tei:np">
  <xsl:variable name="i">
    <xsl:apply-templates select="key('IDS',substring-after(@target,'#'))" mode="generateLink"/>
  </xsl:variable>
  <a href="{$i}"><span class="fnmark">N</span></a>
</xsl:template>

<xsl:template match="tei:list[@type='appcrit']/tei:pp"/>

<xsl:template match="tei:pp">
[<a class="parapointer">
 <xsl:attribute name="href">
      <xsl:apply-templates mode="generateLink" select="key('IDS',substring-after(@target,'#'))"/>
 </xsl:attribute>
 <xsl:value-of select="substring-after(@target,'P')"/>
 </a>]
</xsl:template>

<xsl:template match="tei:list[@type='mslist']">
  <table>
    <xsl:apply-templates select="tei:item" mode="mslist"/>
  </table>
</xsl:template>

<xsl:template match="tei:list[@type='gloss']">
  <xsl:if test="@n">
    <hr/><xsl:call-template name="glossMenu"/><hr/>
  </xsl:if>
  <dl>
    <xsl:apply-templates select="tei:item" mode="gloss"/>
  </dl>  
</xsl:template>

<xsl:template name="glossMenu">
  <xsl:variable name="me">
    <xsl:value-of select="generate-id()"/>
  </xsl:variable>
  <a name="Section{@n}"/>
  <xsl:for-each select="../tei:list[@type='gloss']">
    <xsl:if test="preceding-sibling::tei:list"> | </xsl:if>
    <a href="#Section{@n}">
    <xsl:attribute name="class">
    <xsl:choose>
      <xsl:when test="generate-id()=$me">
        <xsl:text>folio-this</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>folio</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:attribute>
    <xsl:value-of select="@n"/></a>
  </xsl:for-each>
</xsl:template>

<xsl:template match="tei:listBibl">
<dl>
    <xsl:for-each select="bibl">
      <dt>
        <xsl:choose>
          <xsl:when test="@n">
            <xsl:value-of select="@n"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="translate(@xml:id,'-',' ')"/>
          </xsl:otherwise>
        </xsl:choose>
      </dt>
      <dd><xsl:apply-templates select="."/></dd>
    </xsl:for-each>
</dl>
</xsl:template>

<xsl:template match="tei:bibl">
   <xsl:variable name="ident">
    <xsl:apply-templates select="." mode="ident"/>
   </xsl:variable>
   <a name="{$ident}"/>
   <xsl:apply-templates/>
</xsl:template>

<!--
<xsl:template match="tei:*">
  <xsl:message> [pass by <xsl:value-of select="name(.)"/>]</xsl:message>
  <xsl:apply-templates/>
</xsl:template>
-->

<!-- dont do anything with arguments except the ones we specially want on the front page -->

<xsl:template match="tei:argument"/>

<xsl:template match="tei:argument" mode="ok">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:head[@type='sub']">
  <div class="subhead"><xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="tei:item" mode="mslist">
   <tr>
     <td>
     <xsl:if test="@xml:id">
       <a name="{@xml:id}"/>
     </xsl:if>
     <strong>
     <xsl:apply-templates mode="print" select="preceding-sibling::tei:label[1]"/>
   </strong>
 </td>
   <td><xsl:apply-templates/></td>
   </tr>
</xsl:template>


<xsl:template match="tei:div" mode="generateLink">
  <xsl:variable name="ident">
   <xsl:apply-templates select="." mode="ident"/>
  </xsl:variable>
  <xsl:variable name="depth">
   <xsl:apply-templates select="." mode="depth"/>
  </xsl:variable>
  <xsl:variable name="Hash">
   <xsl:text>#</xsl:text>
  </xsl:variable>
  <xsl:variable name="parent">
    <xsl:choose>
      <xsl:when test="ancestor::tei:div">
    <xsl:apply-templates
      select="ancestor::tei:div[last()]" mode="ident"/>
      </xsl:when>
      <xsl:otherwise>
            <xsl:apply-templates
      select="ancestor::tei:text[1]" mode="ident"/>
      </xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
  <xsl:choose>
   <xsl:when test="ancestor::tei:back and not($splitBackmatter)">
       <xsl:value-of select="concat($Hash,$ident)"/>
   </xsl:when>
   <xsl:when test="ancestor::tei:front and not($splitFrontmatter)">
       <xsl:value-of select="concat($Hash,$ident)"/>
   </xsl:when>
  <xsl:when test="@rend='nosplit' or ancestor::tei:div">
      <xsl:value-of select="$parent"/>
      <xsl:value-of select="concat($standardSuffix,'#')"/>
      <xsl:value-of select="$ident"/>
   </xsl:when>
   <xsl:otherwise>
     <xsl:value-of select="concat($ident,$standardSuffix)"/>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

  <xsl:template name="pageLayoutTableBody">
    <xsl:param name="currentID"/>
    <table>
      <tr>
	<td class="hdr" colspan="2">
	  <xsl:call-template name="hdr"/>
	</td>
      </tr>
      <tr>
	<td align="left" valign="top" rowspan="2" width="{$linksWidth}" class="sidetext">
	  <xsl:call-template name="searchbox"/>
	  <xsl:call-template name="leftHandFrame">
	    <xsl:with-param name="currentID" select="$ID"/>
	  </xsl:call-template>
	  <hr/>
	</td>
      </tr>
      <tr>
	<td valign="top" class="maintext" colspan="2">
	  <xsl:call-template name="mainFrame">
	    <xsl:with-param name="currentID" select="$currentID"/>
	  </xsl:call-template>
	</td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>
