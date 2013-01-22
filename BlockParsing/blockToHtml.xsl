<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	<html>
	<body>
	<table border="1">
	<xsl:apply-templates select="//link"/>
	</table>
	</body>
	</html>
</xsl:template>

<!-- process link -->
<xsl:template match="link">
	<tr>
		<td><xsl:value-of select="href"/></td>
		<td><xsl:value-of select="text"/></td>
		<td>
			<xsl:choose>
				<xsl:when test="name(following-sibling::*[1])='text'">
					<xsl:value-of select="following-sibling::*[1]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="parent::block"/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
</xsl:template>

<!-- get containing blocks of a link until text retreived -->
<xsl:template match="block">
	<xsl:choose>
		<xsl:when test="text and count(link)=1">
			<xsl:value-of select="text"/>
		</xsl:when>
		<xsl:when test="count(link)=1">
			<xsl:apply-templates select="parent::block"/>
		</xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
