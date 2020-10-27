<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- affichage de tous les contrats d'un client -->
<xsl:template match="/">
<!--Récupération du clientId de Dubois Nicolas -->
<xsl:variable name='clientIdSelected' select="/ASSURANCE/CLIENTS/Client[Nom='Dubois' and Prenom='Nicolas']/@ClientId"/>
	<html>
		<head>
		<title>Contrats</title>
		</head>
		<body> 
			<h1>Les Contrats de Dubois Nicolas </h1>
		</body>
		<!-- Affichage de façon récursive de tous ses contrats-->
		<xsl:apply-templates select="//CONTRATS/Contrat/Client[@ClientId=$clientIdSelected]/.." />
	</html>
</xsl:template>
<!-- Affichage d'un contrat-->
<xsl:template match="//Contrat">
	<h1><strong>CONTRAT</strong></h1>
	<h1>Date debut : <xsl:value-of select="DateDebut"></xsl:value-of> </h1>
	<h1> Date fin  : <xsl:value-of select="DateFin"></xsl:value-of> </h1>
	<!--Récupération de l'identifiant du conseiller de ce contrat -->
	<xsl:variable name="conseillerIdSelect" select="Conseiller/@ConseillerId"/>
	<!--Appelle de l'affichage du conseiller avec son identifiant. -->
	<xsl:apply-templates select="//CONSEILLERS/Conseiller[@ConseillerId=$conseillerIdSelect]"/>
	<!--Récupération de l'identifiant du client de ce contrat -->
	<xsl:variable name="clientIdSelected2" select="Client/@ClientId"/>
	<!--Appelle de l'affichage du client avec son identifiant. -->
	<xsl:apply-templates select="//CLIENTS/Client[@ClientId=$clientIdSelected2]"/>	
	<!--Récupération de l'identifiant de l'option de ce contrat -->
	<xsl:variable name="OptionIdSelected" select="Option/@OptionId"/>
	<!--Appelle de l'affichage de l'option avec son identifiant. -->
	<xsl:apply-templates select="//OPTIONS/Option[@OptionId=$OptionIdSelected]"/>
	<!--Récupération de l'identifiant du risque de ce contrat -->
	<xsl:variable name="RisqueIdSelected" select="Risque/@RisqueId"/>
	<!--Appelle de l'affichage du risque avec son identifiant. -->
	<xsl:apply-templates select="//RISQUES/Risque[@RisqueId=$RisqueIdSelected]"/>
	<!--Récupération du prix de l'option et du multiplicateur de ce contrat -->
	<xsl:variable name="OptionPrix" select="//OPTIONS/Option[@OptionId=$OptionIdSelected]/Prix"/>
	<xsl:variable name="RisqueMulti" select="//RISQUES/Risque[@RisqueId=$RisqueIdSelected]/Multiplicateur"/>
	<!-- affichage du prix final -->
	<h2>Prix final : <xsl:value-of select="$OptionPrix * $RisqueMulti"/> </h2>
	<hr style="width:80%;text-align:center ;padding: 0 4px;;margin-left:0"/>
​
</xsl:template>
<!-- affichage d'un client-->
<xsl:template match="Client">
	<h1>Client </h1>
	<h4>nom du Client : <xsl:value-of select="Nom"/> </h4>
	<h4>Prenom du client : <xsl:value-of select="Prenom"/> </h4>
	<h4>Numéro de telephone : <xsl:value-of select="Telephone"/> </h4>
	<h4>Email : <xsl:value-of select="EMAIL"/></h4>
</xsl:template>
<!-- affichage d'un conseiller -->
<xsl:template match="Conseiller">
	<h1>Conseiller</h1>
	<h4>Nom conseiller : <xsl:value-of select="Nom"/> </h4>
	<h4>Prenom conseilleir : <xsl:value-of select="Prenom"/> </h4>
</xsl:template>
<!-- affichage d'une option-->
<xsl:template match="Option">
	<h1>Type d'assurance  </h1>
	<h4> Assurance de : <xsl:value-of select="Categorie/@CategorieName"></xsl:value-of></h4>
	<h4> Type : <xsl:value-of select="Type"/></h4>
	<h4>prix de base : <xsl:value-of select="Prix"/></h4>
</xsl:template>
<!-- affichage d'un risque-->
<xsl:template match="Risque">
	<h1> Risque </h1>
	<h4>Niveau : <xsl:value-of select="Niveau"/></h4>
	<h4>Multiplicateur  : <xsl:value-of select="Multiplicateur"/></h4>
</xsl:template>
</xsl:stylesheet>
