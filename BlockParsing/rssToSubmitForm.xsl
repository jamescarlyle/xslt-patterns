<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" encoding="utf-8"/>
<xsl:strip-space elements="*"/>
<xsl:template match="/">
<body>
<form action="http://oak/xml" method="POST">
	<input type="hidden" name="contenttype" value="text/xml"/>
	<textarea rows="30" cols="100" name="template">
		<ROOT xmlns:updg="urn:schemas-microsoft-com:xml-updategram">
			<xsl:apply-templates select="//item"/>
		</ROOT>
	</textarea>
	<input type="submit"/>
</form>
</body>
<!--<html>
</body>
</html>-->
</xsl:template>

<!-- process item-->
<xsl:template match="item">
	<updg:sync xmlns:updg="urn:schemas-microsoft-com:xml-updategram">
	<updg:before>
	</updg:before>
	<updg:after>
   	<testData testNumber="2" sourceUrl="http://www.scriptingnews.com">
   		<xsl:attribute name="itemLink"><xsl:value-of select="link"/></xsl:attribute>
   		<!--<xsl:attribute name="itemTitle"><xsl:value-of select="title"/></xsl:attribute>
   		<xsl:attribute name="itemDescription"><xsl:value-of select="description"/></xsl:attribute>-->
	</testData>
	</updg:after>
	</updg:sync>
</xsl:template>


</xsl:stylesheet>