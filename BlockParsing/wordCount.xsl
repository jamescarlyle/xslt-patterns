<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				version="1.0">

<xsl:template name="word-count">
	<xsl:param name="text"/>
	<xsl:variable name="ntext" select="normalize-space(translate($text,'.,?!-:;)(&lt;&gt;',''))"/>
	<xsl:choose>
		<xsl:when test="$ntext">
			<xsl:variable name="remainder">
				<xsl:call-template name="word-count">
					<xsl:with-param name="text" select="substring-after($ntext, ' ')"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$remainder + 1"/>
		</xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
