<?xml version="1.0" encoding="UTF-8"?>
<!--  Restructurer l'élément client et suppressions de certains contrats qui dépassent la date 09/02/2021  -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8"/>
	<xsl:template match='@* | node()'>
		<xsl:copy>
            <!-- Copie les éléments et les attributs de chaque nœud-->
			<xsl:apply-templates select='@* | node()'/>
		</xsl:copy>
	</xsl:template>
    <!-- Restructuration de l'élément clients-->
	<xsl:template match="CLIENTS">
		<xsl:element name="CLIENTS">
            <xsl:element name="Jeune">
                <xsl:for-each select="Client">
					<xsl:if test="Age &lt;= '25'">
                        <!-- Copie des client qui ont un âge moins de 25 ans inclus-->
                            <xsl:copy> 
                                <xsl:apply-templates select='@* | node()'/>
                            </xsl:copy>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
            <xsl:element name="Adulte">
                <xsl:for-each select="Client">
					<xsl:if test="Age &lt;'70' ">
                        <xsl:if test="Age &gt; '25'">
                            <!-- Copie des client qui ont un âge entre 25 et 70 ans -->

                            <xsl:copy>
                                <xsl:apply-templates select='@* | node()'/>
                            </xsl:copy>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
            <xsl:element name="Senior">
                <xsl:for-each select="Client">
					<xsl:if test="Age &gt;= '70'">
                            <!-- Copie des client qui ont un âge plus de 70 ans inclus-->
                            <xsl:copy>
                                <xsl:apply-templates select='@* | node()'/>
                            </xsl:copy>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
		</xsl:element>
    </xsl:template>
    <!-- Suppression des contrats-->
    <xsl:template match="CONTRATS">
        <xsl:element name="CONTRATS">
            <xsl:for-each select="Contrat">
                <!-- Récupération du jour, mois, année de la fin de contrat-->
                <xsl:variable name="Annee" select="number(substring(DateFin, 7, 4))"/>
                <xsl:variable name="Mois" select="number(substring(DateFin, 4, 2))"/>
                <xsl:variable name="Jour" select="number(substring(DateFin, 1, 2))"/>
                <xsl:choose><!-- Test si la date ne dépasse pas le 09/02/2021 et l'a recopié -->
                    <xsl:when test="$Annee > 2021"/>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$Annee = 2021">
                                <xsl:choose>
                                    <xsl:when test="$Mois > 2"/>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="$Mois = 2">
                                                <xsl:choose>
                                                    <xsl:when test="$Jour > 9"/>
                                                    <xsl:otherwise>
                                                        <xsl:copy><xsl:apply-templates select='@* | node()'/></xsl:copy>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:copy><xsl:apply-templates select='@* | node()'/></xsl:copy>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy><xsl:apply-templates select='@* | node()'/></xsl:copy>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>