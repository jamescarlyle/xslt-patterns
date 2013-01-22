<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
	<xsl:if test="@lc &gt; 0 and ((@awpl &gt; 3 and @rnlt &gt; 0.4) or (@awpl &gt; 4) or (@alwl &gt; 11) or (@rnlt &gt; 1 and @rnlt != infinity))">
		<xsl:apply-templates select="link[descendant::text()]"/>
	</xsl:if>
	<xsl:apply-templates select="block"/>
</xsl:template>

<!-- process link -->
<xsl:template match="link">
	<!-- weed out links which occur multiple times with the same text (often categories for news items) -->
	<xsl:if test="not((preceding::link|following::link)[@href = current()/@href][. = current()])">
	<item>
		<link><xsl:value-of select="@href"/></link>
		<title><xsl:value-of select="."/></title>
		<description>
		</description>
	</item>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>