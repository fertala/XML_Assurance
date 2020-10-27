<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<!-- Afficher sous format d'un table les types  d'assurances d'une et leurs prix respictivent  -->
	<html>
		<head>
		<title>formules voitures</title>
		</head>
		<body> 
            <h2>Tableau des formules pour les voitures</h2>
			<table border="1" style="width: max-content;">
			<tr bgcolor="#9acd32">
			<th align="left">Type</th>
			<th align="left">Prix</th>
			</tr>
			<!-- On récupère dans voitId l'id de la catégorie Voiture-->
			<xsl:variable name="VoitId" select="//CATEGORIES/Categorie[NAME='Voiture']/@CategorieName"></xsl:variable>
			<!-- L'affichage de façon récursive des options dont la catégorie est une voiture  -->
            <xsl:apply-templates select="/ASSURANCE/OPTIONS/Option/Categorie[@CategorieName= $VoitId]/.." />
			</table>
		</body>
	</html>
</xsl:template>
<xsl:template match="//Option">
	<!-- On récupère le multiplicateur correspondant au risque élevée. -->
	<xsl:variable name="mul" select="//RISQUES/Risque[Niveau='Elevée']/Multiplicateur"></xsl:variable>
	<xsl:variable name="final" select="Prix * $mul"></xsl:variable> <!-- calcule du prix final -->
		<xsl:choose>
			<!-- Comparaison pour savoir le type d'écriture-->
			<xsl:when test="$final &lt;'1000'">
				<tr>
					<td>
						<strong>
							<xsl:value-of select="Type"/>
						</strong>  
					</td>
					<td>
						<strong>
							<xsl:value-of select="$final"/>
						</strong>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<xsl:value-of select="Type"/>
					</td>
					<td>
						<xsl:value-of select="$final"/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>

		
</xsl:template>
</xsl:stylesheet>