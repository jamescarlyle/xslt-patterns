<?xml version="1.0"?>
<!-- this version takes the rules as a parameter and the message as the document to be transformed -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="utf-8"/>
<xsl:variable name="rules" select="'rules1.xml'"/>

<xsl:template match="/">
<match>
<xsl:apply-templates select="*">
	<xsl:with-param name="rulesContext" select="document($rules)/rules" />
</xsl:apply-templates>
</match>
</xsl:template>

<xsl:template match="*">
	<xsl:param name="rulesContext" />
	<xsl:variable name="matchingRules" select="$rulesContext/*[name() = name(current())][not(text()) or text()=current()/text()]"/>
	<xsl:if test="$matchingRules">
		<xsl:if test="$matchingRules/@ruleID">
			<xsl:for-each select="$matchingRules"><match><xsl:value-of select="@ruleID"/></match></xsl:for-each>
		</xsl:if>
		<xsl:apply-templates select="*">
			<xsl:with-param name="rulesContext" select="$matchingRules" />
		</xsl:apply-templates>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
