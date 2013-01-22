<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="getLastSentence.xsl"/>
<xsl:output encoding="utf-8"/>
<xsl:template match="/">
	<rss>
	<channel>
	<xsl:apply-templates/>
	</channel>
	</rss>
</xsl:template>

<!-- process block -->
<xsl:template match="block[not(descendant::block)][link[@href]]">
	<item>
		<description>
			<xsl:value-of select="."/>
		</description>
		<xsl:for-each select="link[@href][1]">
			<link><xsl:value-of select="@href"/></link>
			<title><xsl:value-of select="."/></title>
		</xsl:for-each>
	</item>
</xsl:template>

<!-- process block without link-->
<xsl:template match="text()">
	<item>
		<description>
			<xsl:value-of select="."/>
		</description>
	</item>
</xsl:template>

<!-- process link -->
<!-- <xsl:template match="link">
		<link><xsl:value-of select="@href"/></link>
		<title><xsl:value-of select="."/></title>
		<description>
			<xsl:choose>-->
				<!-- see if there is an ancestor block to this link which contains only one (this) link
				and contains text - if so, use the most separated such ancestor.  -->
				<!-- <xsl:when test="ancestor::block[count(descendant::link)=1][text()]">
					<xsl:value-of select="ancestor::block[count(descendant::link)=1]"/>
				</xsl:when>
				<xsl:otherwise>
					#
					<xsl:call-template name="get-last-sentence">
						<xsl:with-param name="text" select="translate(preceding::text()[1],',!?/','....')"/>
					</xsl:call-template>
					#<xsl:value-of select="."/>
					#<xsl:value-of select="substring-before(concat(translate(following::text()[1],',!?/','....'),'. '),'. ')"/>
				</xsl:otherwise>
			</xsl:choose>
		</description>
</xsl:template>
-->

</xsl:stylesheet>
