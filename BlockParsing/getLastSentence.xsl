<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="get-last-sentence">
	<xsl:param name="text"/>
	<xsl:choose>
		<xsl:when test="contains($text,'. ')">
			<xsl:call-template name="get-last-sentence">
				<xsl:with-param name="text" select="substring-after($text,'. ')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$text"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
