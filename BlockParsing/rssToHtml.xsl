<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="utf-8"/>
<xsl:template match="/">
<html>
<head>
<title>MyWebFeed View News Items by Filter</title>
<style type="text/css">
body {
	font-family: verdana;
	background-color: #FFCC66;
	color: #000000;
	margin-top: 2%;
	margin-bottom: 2%;
	margin-left: 2%;
	margin-right: 0%;
}
div.navigation {
	padding: 0.25em;
	font-size: 0.9em;
	border-style: groove;
	border-width: thin;
	background-color: #FFFFFF;
	margin-bottom: 1%;
	margin-right: 2%;
}
div.group {
	border-width: thin;
	border-style: groove;
	background-color: #FFFFFF;
	float: left;
	width: 48.4%;
	margin-right: 1%;
}
h1 {
	margin: 0em;
	valign: top;
}
h2 {
	margin: 0em;
	valign: top;
}
div.groupHead {
	padding: 0.25em;
	background-color: #CCCCCC;
}
dl {
	padding: 0.25em;
	font-size: 0.9em;
}
</style>
</head>
<body>
<div class="navigation">
	<h1>New Items by Filter</h1>
	<a href="">MyWebFeed Home</a> |
	<a href="">New Items by Date</a> |
	<a href="">Personalise</a>
</div>
<xsl:apply-templates select="//channel"/>
</body>
</html>
</xsl:template>

<!-- process channels -->
<xsl:template match="channel">
<div class="group">
	<div class="groupHead">
	<h2>
		<xsl:value-of select="title"/>
	</h2>
	<a href="">Modify Filter</a>
	</div>
	<dl>
		<xsl:apply-templates select="item"/>
	</dl>
</div>
</xsl:template>

<!-- process items -->
<xsl:template match="item">
	<dt>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
			<xsl:value-of select="title"/>
		</a>
	</dt>                       	
	<dd><xsl:value-of select="description"/></dd>
</xsl:template>

<xsl:variable name="navigation">
</xsl:variable>
</xsl:stylesheet>
