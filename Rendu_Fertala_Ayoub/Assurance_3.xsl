<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8"/>
  <!-- L'affichage de tous les contrats id et leurs dates de début -->
  <!-- En affichant en gras les dates qui dépassent le 18/08/2019-->
  <xsl:template match="/">
    <html>
      <head>
	<title>
	  L'année et les identifiants des contrats
	</title>
      </head>
      <body>
  <!-- Affichage du nombre total des contrats-->
	<h1>Voici la liste des <xsl:value-of select="count(//CONTRATS/Contrat)" /> contrats </h1>
	<blockquote>
      <xsl:apply-templates select="//CONTRATS/Contrat">
      <xsl:sort select="@ContratId" order="descending" />
	  </xsl:apply-templates>
	</blockquote>
      </body>
    </html>
  </xsl:template>
  <!-- l'affichage d'un contrat-->
  <xsl:template match="CONTRATS/Contrat">
    <p>
      <!-- Récupération des données suivantes d'un contrat-->
      <!-- Le jour , le mois et l'année de début -->
    <xsl:variable name="Annee" select="number(substring(DateDebut, 7, 4))"/>
    <xsl:variable name="Mois" select="number(substring(DateDebut, 4, 2))"/>
    <xsl:variable name="Jour" select="number(substring(DateDebut, 1, 2))"/>
    <xsl:choose> <!-- Test si l'année dépasse le 18/08/2019-->
        <xsl:when test="$Annee > 2019">
            <xsl:choose>
              <xsl:when test="$Mois > 5">
                <xsl:choose>
                  <xsl:when test="$Jour > 18">
                      <strong>
                      <xsl:value-of select="@ContratId"/> : <xsl:value-of select="concat($Jour,'/',$Mois,'/',$Annee)"/>
                      </strong>
                  </xsl:when>
                  <xsl:otherwise>
                          <em>
                      <xsl:value-of select="@ContratId"/> : <xsl:value-of select="concat($Jour,'/',$Mois,'/',$Annee)"/>
                          </em>
                  </xsl:otherwise>
                  </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                      <em>
                  <xsl:value-of select="@ContratId"/> : <xsl:value-of select="concat($Jour,'/',$Mois,'/',$Annee)"/>
                      </em>
              </xsl:otherwise>
              </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
            <em>
            <xsl:value-of select="@ContratId"/> : <xsl:value-of select="concat($Jour,'/',$Mois,'/',$Annee)"/>
            </em>
        </xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:template>

  
</xsl:stylesheet>
