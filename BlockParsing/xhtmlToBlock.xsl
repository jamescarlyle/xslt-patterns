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
	<!-- link text -->
	<xsl:variable name="textLinkCount" select="count(descendant::a[descendant::text()])"/>
	<xsl:variable name="linkText"><xsl:for-each select="descendant::a//text()"><xsl:value-of select="concat(.,' ')"/></xsl:for-each></xsl:variable>
	<xsl:variable name="linkTextWordCount"><xsl:call-template name="word-count"><xsl:with-param name="text" select="$linkText"/></xsl:call-template></xsl:variable>
	<xsl:variable name="linkTextLength" select="string-length(normalize-space(translate($linkText,'.,?!-:;)( ','')))"/>
	<!-- non link text -->
	<xsl:variable name="nonLinkText"><xsl:for-each select="descendant-or-self::text()[not(ancestor::a)]"><xsl:value-of select="concat(.,' ')"/></xsl:for-each></xsl:variable>
	<!--<xsl:variable name="nonLinkTextWordCount"><xsl:call-template name="word-count"><xsl:with-param name="text" select="$nonLinkText"/></xsl:call-template></xsl:attribute>-->
	<xsl:variable name="nonLinkTextLength" select="string-length(normalize-space(translate($nonLinkText,'.,?!-:;)( ','')))"/>
	<!-- the block is interesting if the average number of words per link is more than 2
	or the average length of words used in the links is more than 5 (i.e. not navigation) -->
	<xsl:if test="($textLinkCount = 1) or ($linkTextWordCount div $textLinkCount &gt; 3) or ($linkTextLength div $linkTextWordCount &gt; 9) or ($nonLinkTextLength div $linkTextLength &gt; 1 and $linkTextLength &gt; 0)">
	<!-- don't output block if only contains one link and following block contains many -->
		<xsl:choose>
			<!-- don't output block if only a container for another block -->
			<xsl:when test="*[not(html|body|p|table|tr|td|div|dd|dt|dl|ul|ol|li|br|nobr)]/descendant::text() or (count(html|body|p|table|tr|td|div|dd|dt|dl|ul|ol|li|br|nobr) &gt; 1)">
			<block>
			<!--
				<xsl:if test="$textLinkCount = 1"><xsl:attribute name="textLinkCount"><xsl:value-of select="$textLinkCount"/></xsl:attribute></xsl:if>
				<xsl:if test="$linkTextWordCount div $textLinkCount &gt; 3"><xsl:attribute name="averageWordsPerLink"><xsl:value-of select="$linkTextWordCount div $textLinkCount"/></xsl:attribute></xsl:if>
				<xsl:if test="$linkTextLength div $linkTextWordCount &gt; 9"><xsl:attribute name="averageLinkWordsLength"><xsl:value-of select="$linkTextLength div $linkTextWordCount"/></xsl:attribute></xsl:if>
				<xsl:if test="$nonLinkTextLength div $linkTextLength &gt; 1"><xsl:attribute name="ratioNonLinkText"><xsl:value-of select="$nonLinkTextLength div $linkTextLength"/></xsl:attribute></xsl:if>
			-->
				<xsl:attribute name="lc"><xsl:value-of select="$textLinkCount"/></xsl:attribute>
				<xsl:attribute name="awpl"><xsl:value-of select="format-number($linkTextWordCount div $textLinkCount, '##.#')"/></xsl:attribute>
				<xsl:attribute name="alwl"><xsl:value-of select="format-number($linkTextLength div $linkTextWordCount, '##.#')"/></xsl:attribute>
				<xsl:attribute name="nltl"><xsl:value-of select="$nonLinkTextLength"/></xsl:attribute>
				<xsl:attribute name="ltl"><xsl:value-of select="$linkTextLength"/></xsl:attribute>
				<xsl:attribute name="rnlt"><xsl:value-of select="format-number($nonLinkTextLength div $linkTextLength, '#.##')"/></xsl:attribute>
				<xsl:apply-templates/>
			</block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
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