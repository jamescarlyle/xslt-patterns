<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				version="1.0">
<xsl:output encoding="utf-8" method="xml" omit-xml-declaration="no"/>

<!-- this seems to work well with test.xml input just processing divs and text nodes -->
<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="div">
	<block>
		<text>
			<!-- any descendant text, but such text nodes not with a preceding finished block as a descendant of the current block,
			and such text nodes with the closest block ancestor being the current block
			and the text not belonging inside an anchor element -->
			<xsl:for-each select="descendant::text()[not(ancestor::a)][not((preceding::div|preceding::a)[ancestor::* = current()])][count(ancestor::div[1]|current())=1]">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</text>
		<xsl:apply-templates/>
	</block>
	<!-- don't output a following text element for the root block element like <html> -->
	<xsl:if test="not(current() = /)">
	<text>
		<!-- any following text, but such text nodes with the nearest preceding block being the current block
		and the closest block ancestor being the same element as the current closing block's closest block ancestor
		and the text not belonging inside an anchor element -->
		<xsl:for-each select="following::text()[not(ancestor::a)][ancestor::div[1]=current()/ancestor::div[1]][count((preceding::a|preceding::div)[last()]|current())=1]">
			<xsl:value-of select="."/>
		</xsl:for-each>
	</text>
	</xsl:if>
</xsl:template>

<xsl:template match="a">
	<link>
		<href><xsl:value-of select="@href"/></href>
		<text><xsl:value-of select="."/></text>
	</link>
	<!-- following text nodes, such text having the preceding finished block or anchor element being the current one
	and having the closest ancestor block element the same as the current anchor's closest block ancestor -->
	<text>
		<xsl:for-each select="following::text()[not(ancestor::a)][(preceding::a|preceding::div)[last()] = current()][ancestor::div[1]=current()/ancestor::div[1]]">
			<xsl:value-of select="."/>
		</xsl:for-each>
	</text>
</xsl:template>

<!-- don't process any text nodes outside <text> elements -->
<xsl:template match="text()">
</xsl:template>

</xsl:stylesheet>
