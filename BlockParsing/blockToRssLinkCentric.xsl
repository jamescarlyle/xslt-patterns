<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="getLastSentence.xsl"/>
<xsl:output encoding="utf-8"/>
<xsl:template match="/">
	<rss>
	<channel>
	<xsl:apply-templates select="//link"/>
	</channel>
	</rss>
</xsl:template>

<!-- process link -->
<xsl:template match="link">
	<xsl:if test="text()|ancestor::block[count(descendant::link[@href != current()/@href]) = 0][text()]">
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
				and contains text - if so, use the most separated such ancestor.  -->
				<xsl:when test="(ancestor::block[count(descendant::link[@href != current()/@href]) = 0])[last()][descendant-or-self::text()]">
					<xsl:value-of select="ancestor::block[count(descendant::link[@href != current()/@href]) = 0][descendant-or-self::text()]"/>
				</xsl:when>
				<!-- if the following sibling node is a block contains no different links and does contain text, use that text -->
				<xsl:when test="ancestor::block[count(descendant::link[@href != current()/@href]) = 0][last()]/following-sibling::*[block][1][not(descendant::link[@href != current()/@href])][descendant-or-self::text()]">
					<xsl:value-of select="ancestor::block[count(descendant::link[@href != current()/@href]) = 0][last()]/following-sibling::block[1]"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- check the first following node is text and use if so -->
					<xsl:value-of select="following-sibling::node()[1][self::text()]"/>
				</xsl:otherwise>
				<!--<xsl:otherwise>
					check the first following node is text and use if so
					<xsl:value-of select="ancestor::block[count(descendant::link[@href != current()/@href]) = 0]/following-sibling::*[text()][1]"/>
				</xsl:otherwise> -->
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
<!--#
	<xsl:call-template name="get-last-sentence">
	<xsl:with-param name="text" select="translate(preceding::text()[1],',!?/','....')"/>
	</xsl:call-template>#
	#<xsl:value-of select="substring-before(concat(translate(following::text()[1],',!?/','....'),'. '),'. ')"/>
-->

</xsl:stylesheet>