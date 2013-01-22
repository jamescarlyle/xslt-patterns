<?xml version="1.0"?>
<!-- this version takes the message as a parameter and rules are embedded into the stylesheet -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cbr="urn:schemas-calaba-com:xml-ruleProcessing:cbr">
<xsl:output encoding="utf-8"/>
<xsl:template match="/">
<matches>
	<xsl:apply-templates select="*"/>
</matches>
</xsl:template>

<!-- example of naive matching -->
<xsl:template match="/rss/channel/item/description">
<naiveMatch>
<xsl:copy-of select="."/>
</naiveMatch>
</xsl:template>
<xsl:template match="/rss/channel/item/link[.='http://abc.com']">
<naiveMatch>
<xsl:copy-of select="."/>
</naiveMatch>
</xsl:template>

<xsl:template match="text()"/>



<!-- better grouped matching -->
<xsl:template match="/rss/channel/item">
	<xsl:apply-templates select="title[.='abc']" mode="matched"/>
	<xsl:apply-templates select="description" mode="matched"/>
	<xsl:apply-templates select="link[.='http://abc.com']" mode="matched"/>
</xsl:template>

<xsl:template match="*" mode="matched">
<sequentialMatch>
	<xsl:copy-of select="."/>
</sequentialMatch>
</xsl:template>













</xsl:stylesheet>