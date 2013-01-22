<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				version="1.0">
<xsl:include href="wordCount.xsl"/>
<xsl:output encoding="utf-8"/>

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<!-- only process block elements which have interior text or links -->
<xsl:template match="(html|body|p|table|tr|td|div|dd|dt|dl|ul|ol|li|br|nobr)[descendant::text()]">
	<!-- 
	<xsl:variable name="tlc" select="count(descendant::a[descendant::text()])"/>
	<xsl:variable name="lt"><xsl:for-each select="descendant::a//text()"><xsl:value-of select="concat(.,' ')"/></xsl:for-each></xsl:variable>
	<xsl:variable name="ltwc"><xsl:call-template name="word-count"><xsl:with-param name="text" select="$linkText"/></xsl:call-template></xsl:variable>
	<xsl:variable name="ltl" select="string-length(normalize-space(translate($linkText,'.,?!-:;)(&lt;&gt;','')))"/>
	<xsl:variable name="nlt"><xsl:for-each select="descendant-or-self::text()[not(ancestor::a)]"><xsl:value-of select="concat(.,' ')"/></xsl:for-each></xsl:variable>
	<xsl:variable name="nltl" select="string-length(normalize-space(translate($nonLinkText,'.,?!-:;)( ','')))"/>
	-->
	<!--<xsl:variable name="nltwc"><xsl:call-template name="word-count"><xsl:with-param name="text" select="$nonLinkText"/></xsl:call-template></xsl:attribute>-->
 	<xsl:choose>
		<!-- don't output block if only a container for another block -->
		<xsl:when test="*[not(html|body|p|table|tr|td|div|dd|dt|dl|ul|ol|li|br|nobr)]/descendant::text() or (count(html|body|p|table|tr|td|div|dd|dt|dl|ul|ol|li|br|nobr) &gt; 1)">
		<block>
			<!--
			<xsl:attribute name="tlc"><xsl:value-of select="$tlc"/></xsl:attribute>
			<xsl:attribute name="awpl"><xsl:value-of select="format-number($ltwc div $tlc, '##.#')"/></xsl:attribute>
			<xsl:attribute name="alwl"><xsl:value-of select="format-number($ltl div $ltwc, '##.#')"/></xsl:attribute>
			<xsl:attribute name="rnlt"><xsl:value-of select="format-number($nltl div $ltl, '#.##')"/></xsl:attribute>
			-->
			<xsl:apply-templates/>
		</block>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="a[@href]">
	<xsl:if test="not(starts-with(translate(@href,'ACIJPRSTV','acijprstv'),'javascript:'))">
	<link>
		<xsl:copy-of select="@href"/>
		<xsl:value-of select="."/>
	</link>
	</xsl:if>
</xsl:template>

<xsl:template match="script">
</xsl:template>

<xsl:template match="text()">
	<xsl:value-of select="concat(.,' ')"/>
</xsl:template>

</xsl:stylesheet>