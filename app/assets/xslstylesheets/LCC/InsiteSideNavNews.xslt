<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:attribute-set name="link-set">
  <xsl:attribute name="href"><xsl:value-of select="Properties/PromoProperty[@Key='Path']" /></xsl:attribute>
  <xsl:attribute name="title"><xsl:value-of select="Title" /></xsl:attribute>
</xsl:attribute-set>

<xsl:template name="trimComment">
    <xsl:param name="commentStr" />
        <xsl:choose>
            <xsl:when test="string-length($commentStr) > 80">
                <xsl:value-of select="concat(substring($commentStr,1,80),'...')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$commentStr" />
            </xsl:otherwise>
        </xsl:choose>   
</xsl:template>

    <xsl:template match="/">
        <div>
            <xsl:choose>
                <xsl:when test="string-length(PromoWrapper/@CssClass) > 0">          
                        <xsl:attribute name="class">
                            <xsl:value-of select="PromoWrapper/@CssClass" />
                        </xsl:attribute>    
                </xsl:when>
                <xsl:otherwise>    
                    <xsl:attribute name="class">
                        <xsl:value-of select="'relatedPages'" />
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <h3><xsl:value-of select="PromoWrapper/@CustomTitle" /></h3>
            <ul class="nav ShowHide">
                <xsl:for-each select="PromoWrapper/Promos/Promo">
                <li>
                    <div class="col-md-12" style="padding-top:2px;padding-right:2px;padding-left:2px;padding-bottom:30px; margin:2px"> 
                        <div class="col-md-3">
                            <xsl:if test="string-length(Properties/PromoProperty[@Key='PublishingImage']/Value) > 0">
                                <img class="img-content" alt="">
                                    <xsl:attribute name="src">
                                        <xsl:value-of select="substring-before(substring-after(Properties/PromoProperty[@Key='PublishingImage'], 'src=&quot;'), '&quot; style')" />
                                    </xsl:attribute> 
                                </img>
                            </xsl:if>
                        </div>
                        <div class="col-md-9">
                            <h4 style="border-bottom:0px !important; margin:0px;">
                                <a class="item" xsl:use-attribute-sets="link-set">
                                    <xsl:value-of select="Title"/>     
                                </a>
                            </h4>
                            <small>
                                <xsl:value-of select="Properties/PromoProperty[@Key='NewsReleaseDateOWSDATE']"/>
                            </small>
                            <br/>
                            <xsl:if test="string-length(Properties/PromoProperty[@Key='NewsPageOverviewOWSMTXT']/Value) > 0"> 
                                <xsl:call-template name="trimComment">
                                        <xsl:with-param name="commentStr" select="Properties/PromoProperty[@Key='NewsPageOverviewOWSMTXT']"/>
                                </xsl:call-template>                            
                            </xsl:if>
                        </div>  
                    </div>
                </li>
                </xsl:for-each>
            </ul>
            <div style="padding:2px; margin:2px; text-align:right">
                <a class="text-color">
                    <xsl:attribute name="href">
                        <xsl:value-of select="PromoWrapper/@NavUrl" />
                    </xsl:attribute>
                    more news...
                </a>
            </div>

        </div>

    </xsl:template>

</xsl:stylesheet>