<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:attribute-set name="link-set">
    <xsl:attribute name="href">
        <xsl:choose>
            <xsl:when test="contains(Properties/PromoProperty[@Key='PromoLinkOWSURLH'], ',')">
                <xsl:value-of select="substring-before(Properties/PromoProperty[@Key='PromoLinkOWSURLH'], ',')" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="Properties/PromoProperty[@Key='PromoLinkOWSURLH']" />
            </xsl:otherwise>
        </xsl:choose>                   
    </xsl:attribute>
    <xsl:attribute name="rel"><xsl:value-of select="Properties/PromoProperty[@Key='PromoIconOWSTEXT']" /></xsl:attribute>
</xsl:attribute-set>

    <xsl:template match="/">
        <div class="mega-promo">
            <xsl:for-each select="PromoWrapper/Promos/Promo">
                <div>
                    <xsl:attribute name="class">
                        <xsl:value-of select="Properties/PromoProperty[@Key='PromoCSSClassOWSTEXT']" />
                    </xsl:attribute>
                    <a xsl:use-attribute-sets="link-set">
                        <div class="mega-promo__img-wrapper">
                            <div class="mega-promo__img">
                                <xsl:attribute name="style">
                                    <xsl:value-of select="concat('background-image:url(',substring-before(substring-after(Properties/PromoProperty[@Key='PromoImageOWSIMGE'], 'src=&quot;'), '&quot; style'),');')" />
                                </xsl:attribute>
                                <xsl:value-of select="' '"/>
                            </div>
                        </div>
                        <div class="mega-promo__content">
                            <h3 class="mega-promo__header">
                                <xsl:value-of select="Title"/>
								<xsl:value-of select="Properties/PromoProperty[@Key='PromoIconOWSTEXT']" />
                            </h3>
                            <p class="mega-promo__secondary">
                                <xsl:value-of select="Properties/PromoProperty[@Key='PromoDescriptionOWSMTXT']" />
                            </p>
                        </div>
                        <xsl:if test="string-length(Properties/PromoProperty[@Key='PromoDescriptionTwoOWSMTXT']/Value) > 0">
                            <span class="mega-promo__highlight">
                                <xsl:value-of select="Properties/PromoProperty[@Key='PromoDescriptionTwoOWSMTXT']" />
                            </span>
                        </xsl:if> 
                    </a>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

</xsl:stylesheet>