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
			<div class="carousel-inner" data-module="event-carousel" >
                <xsl:for-each select="PromoWrapper/Promos/Promo">
                    <div class="item">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat('/staffroom/calendars/event-details?ID=',Properties/PromoProperty[@Key='ListItemID'],'&amp;ContentTypeId=',Properties/PromoProperty[@Key='ContentTypeId'])" />
                            </xsl:attribute> 
                            <div class="carousel-caption white-background">
                                <div class="row">
                                    <xsl:choose>
                                        <xsl:when test="string-length(Properties/PromoProperty[@Key='EventImageOWSIMGE']/Value) > 0">
                                            <div class="col-sm-5">
                                                <img alt="" style="width: 100%; padding-left: 1em">
                                                    <xsl:attribute name="src">
                                                        <xsl:value-of select="substring-before(substring-after(Properties/PromoProperty[@Key='EventImageOWSIMGE'], 'src=&quot;'), '&quot; style')" />
                                                    </xsl:attribute> 
                                                </img>
                                            </div>                                    
                                            <div class="col-sm-7">
                                                <p class="font-bold"><xsl:value-of select="Title"/></p>
                                                <p class="fontsize">
                                                    <span class="js-event-start"><xsl:value-of select="Properties/PromoProperty[@Key='EventDateOWSDATE']" /></span> - <span class="js-event-end"><xsl:value-of select="Properties/PromoProperty[@Key='EndDateOWSDATE']" /></span>
                                                </p>
                                            </div>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <div class="col-sm-12">
                                                <p class="font-bold" style="padding-left: 1em"><xsl:value-of select="Title"/></p>
                                                <p class="fontsize">
                                                    <span class="js-event-start"><xsl:value-of select="Properties/PromoProperty[@Key='EventDateOWSDATE']" /></span> - <span class="js-event-end"><xsl:value-of select="Properties/PromoProperty[@Key='EndDateOWSDATE']" /></span>
                                                </p>
                                            </div>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </div>
                        </a> 
                    </div>                  
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>