<?xml version="1.0"?>
<!-- this version takes the message as a parameter and the rules as the document to be transformed -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cbr="urn:schemas-calaba-com:xml-ruleProcessing:cbr">
<xsl:output encoding="utf-8"/>
<xsl:variable name="message" select="'message1.xml'"/>

<xsl:template match="/rules">
<match>
<xsl:apply-templates select="*">
	<xsl:with-param name="messageContext" select="document($message)" />
</xsl:apply-templates>
</match>
</xsl:template>

<xsl:template match="*">
	<xsl:param name="messageContext" />
	<xsl:variable name="matchingMessage" select="$messageContext/*[name() = name(current())][not(current()/text()) or text()=current()/text()]"/>
	<xsl:if test="$matchingMessage">
		<xsl:if test="@cbr:id">
			<match><xsl:value-of select="@cbr:id"/></match>
		</xsl:if>
		<xsl:apply-templates select="*">
			<xsl:with-param name="messageContext" select="$matchingMessage" />
		</xsl:apply-templates>
	</xsl:if>
</xsl:template>


















</xsl:stylesheet>