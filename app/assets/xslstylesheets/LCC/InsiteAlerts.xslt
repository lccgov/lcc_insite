<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <ul class="cbs-List" style="padding:0px">
                <xsl:for-each select="PromoWrapper/Promos/Promo">
                    <li id="Alerts">
                        <div class="alert-wrapper">
                            <div role="alert">
                                <xsl:attribute name="class">
                                    <xsl:value-of select="concat('alert ',Properties/PromoProperty[@Key='AlertCSSOWSTEXT'],' alert-dismissible')" />
                                </xsl:attribute>   
                                <div class="container-fluid">
                                    <div class="alertInner">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                        </button>
                                        <h2>
                                            <xsl:value-of select="Title"/>
                                        </h2>
                                        <p>
                                            <xsl:value-of select="Properties/PromoProperty[@Key='AlertContentOWSHTML']" disable-output-escaping="yes"/>
                                        </p>
                                        <xsl:if test="string-length(Properties/PromoProperty[@Key='AlertLinkOWSURLH']/Value) > 0">
                                            <a class="btn btn-default">
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="substring-before(Properties/PromoProperty[@Key='AlertLinkOWSURLH'],',')"/> 
                                                </xsl:attribute> 
                                                <xsl:value-of select="substring-after(Properties/PromoProperty[@Key='AlertLinkOWSURLH'],', ')"/> 
                                            </a>
                                        </xsl:if>                                                                             
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>                                     
                </xsl:for-each>
        </ul>
    </xsl:template>

</xsl:stylesheet>