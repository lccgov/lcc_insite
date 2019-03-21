<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <div class="carousel slide carousel-display" data-module="carousel">
            <xsl:attribute name="id">
                <xsl:value-of select="PromoWrapper/@UniqueId" />
            </xsl:attribute> 
		    <div class="carousel-title">            
			    <a class="alljobs carousel-font">
                    <xsl:attribute name="href">
                        <xsl:value-of select="PromoWrapper/@NavUrl" />
                    </xsl:attribute> 
                    <xsl:value-of select="PromoWrapper/@CustomTitle" />
                </a>		
		    </div>		
			<div class="carousel-inner" >
                <xsl:for-each select="PromoWrapper/Promos/Promo">
                    <div class="item">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="Properties/PromoProperty[@Key='JobURLOWSTEXT']" />
                            </xsl:attribute> 
                            <div class="carousel-caption white-background">
                                    <p class="font-bold text-padding-left" style="padding-left: 1em"><xsl:value-of select="Properties/PromoProperty[@Key='JobTitle1OWSTEXT']"/></p> 				
                                    <p class="fontsize text-padding-left" style="padding-left: 1em"><xsl:value-of select="concat('Grade : ',Properties/PromoProperty[@Key='GradeOWSTEXT'])" /></p>
                                    <p class="fontsize text-padding-left" style="padding-left: 1em"><xsl:value-of select="concat('Closing date : ',Properties/PromoProperty[@Key='JobClosingDateOWSDATE'])" /></p>
                            </div>
                        </a> 
                    </div>                  
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>