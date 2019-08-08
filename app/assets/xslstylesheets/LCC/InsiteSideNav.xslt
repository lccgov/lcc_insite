<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:attribute-set name="link-set">
  <xsl:attribute name="href"><xsl:value-of select="Properties/PromoProperty[@Key='Path']" /></xsl:attribute>
  <xsl:attribute name="title"><xsl:value-of select="Properties/PromoProperty[@Key='LCCBasicDisplayTitle']" /></xsl:attribute>
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
                    <div>
                        <a class="item" xsl:use-attribute-sets="link-set">
                            <xsl:choose>
                                <xsl:when test="string-length(Properties/PromoProperty[@Key='customPostTitle']/Value) > 0">
                                    <xsl:value-of select="Properties/PromoProperty[@Key='customPostTitle']"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="Properties/PromoProperty[@Key='LCCBasicDisplayTitle']"/>
                                </xsl:otherwise>
                            </xsl:choose>       
                        </a> 
                        <xsl:if test="string-length(Properties/PromoProperty[@Key='customPostComment']/Value) > 0"> 
                            <br/>
                            <span>
                                <xsl:call-template name="trimComment">
                                        <xsl:with-param name="commentStr" select="Properties/PromoProperty[@Key='customPostComment']"/>
                                </xsl:call-template>                            
                            </span>
                        </xsl:if>
                        <br/>
                        <span>
                            <small>
                                <xsl:value-of select="Properties/PromoProperty[@Key='CreatedOWSDATE']"/>
                            </small>
                        </span>
                    </div>
                </li>                                      
                </xsl:for-each>
            </ul> 
            <br/>
            <a style="right:0.3em; bottom:1em; padding-right:30px; padding-bottom: 30px; position: absolute;">
                <xsl:attribute name="href">
                    <xsl:value-of select="PromoWrapper/@NavUrl" />
                </xsl:attribute>
                ...more
            </a>
        </div>
    </xsl:template>

</xsl:stylesheet>