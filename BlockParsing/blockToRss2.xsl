<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="wordCount.xsl"/>
<xsl:output encoding="utf-8"/>
<xsl:template match="/">
	<rss>
	<channel>
	<xsl:apply-templates/>
	</channel>
	</rss>
</xsl:template>

<!-- process block -->
<xsl:template match="block">
	<xsl:variable name="tlc" select="count(link[descendant::text()])"/>
	<xsl:if test="$tlc &gt; 0">
		<xsl:variable name="lt"><xsl:for-each select="link//text()"><xsl:value-of select="concat(.,' ')"/></xsl:for-each></xsl:variable>
		<xsl:variable name="ltwc"><xsl:call-template name="word-count"><xsl:with-param name="text" select="$lt"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ltl" select="string-length(normalize-space(translate($lt,'.,?!-:;)(&lt;&gt;','')))"/>
		<xsl:variable name="nlt"><xsl:for-each select="text()"><xsl:value-of select="concat(.,' ')"/></xsl:for-each></xsl:variable>
		<xsl:variable name="nltl" select="string-length(normalize-space(translate($nlt,'.,?!-:;)( ','')))"/>
		<xsl:variable name="awpl"><xsl:value-of select="$ltwc div $tlc"/></xsl:variable>
		<xsl:variable name="alwl"><xsl:value-of select="$ltl div $ltwc"/></xsl:variable>
		<xsl:variable name="rnlt"><xsl:value-of select="$nltl div $ltl"/></xsl:variable>
		<xsl:if test="($awpl &gt; 3 and $rnlt &gt; 0.4) or ($awpl &gt; 4) or ($alwl &gt; 11) or ($rnlt &gt; 1 and $rnlt != infinity)">
			<xsl:apply-templates select="link[descendant::text()]"/>
		</xsl:if>
	</xsl:if>
	<xsl:apply-templates select="block"/>
</xsl:template>

<!-- process link -->
<xsl:template match="link">
	<!-- weed out links which occur multiple times with the same text (often categories for news items) -->
	<xsl:if test="not((preceding::link|following::link)[@href = current()/@href][. = current()])">
	<item>
		<link><xsl:value-of select="@href"/></link>
		<xsl:variable name="title">
			<xsl:choose>
			<xsl:when test="text()">
				<xsl:value-of select="text()"/>
			</xsl:when>
			<xsl:when test="descendant::*[@alt]">
				<xsl:value-of select="descendant::*[@alt]"/>
			</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="description">
			<xsl:choose>
				<!-- see if there is an ancestor block to this link which contains only this link (maybe repeated)
				and contains text outside this link - if so, use the most separated such ancestor.  -->
				<xsl:when test="(ancestor::block[count(descendant::link[@href != current()/@href]) = 0])[last()]/self::text()|descendant::*[not(current())]/text()">
					<xsl:value-of select="ancestor::block[count(descendant::link[@href != current()/@href]) = 0]/self::text()|descendant::*[not(current())]/text()"/>
				</xsl:when>
				<!-- if the following sibling node is a block contains no different links and does contain text, use that text -->
				<xsl:when test="ancestor::block[count(descendant::link[@href != current()/@href]) = 0][last()]/following-sibling::*[block][1][not(descendant::link[@href != current()/@href])][descendant-or-self::text()]">
					<xsl:value-of select="ancestor::block[count(descendant::link[@href != current()/@href]) = 0][last()]/following-sibling::block[1]"/>
				</xsl:when>
				<xsl:when test="following-sibling::node()[1][string-length(self::text()) &gt; 5]">
					<!-- check the first following node is text and use if so -->
					<xsl:value-of select="following-sibling::node()[1]"/>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<title>
			<xsl:choose>
				<xsl:when test="$title != ''"><xsl:value-of select="$title"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$description"/></xsl:otherwise>
			</xsl:choose>
		</title>
		<description>
			<xsl:choose>
				<xsl:when test="$title != ''"><xsl:value-of select="$description"/></xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</description>
	</item>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>