<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- partenza -->
  <xsl:template match="/tei:TEI">
    <html>
      
      <head>
        <title>
          <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
        </title>
        <link rel="stylesheet" type="text/css" href="style.css"/>
      </head>

      <body>
        
        
        
 <!-- organizzare metadata -->
        
        <!-- 1. titolo -->
        <xsl:apply-templates select="tei:text/tei:body/tei:head[@type='mainTitle']"/>
        
        <!-- 2.  testo no titolo-->
        <xsl:apply-templates select="tei:text/tei:body/*[not(self::tei:head[@type='mainTitle'])]"/>
        
        <!-- 3. META tutti insieme -->
        <xsl:call-template name="dati-bibliografici"/>
        
        
        
      </body>
    </html>
  </xsl:template>

  

  

  <!-- p -->
  <xsl:template match="tei:p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- gente -->
  <xsl:template match="tei:rs[@type='person']">
    <span class="person" data-ref="{@ref}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- luoghu -->
  <xsl:template match="tei:rs[@type='place']">
    <span class="place" data-ref="{@ref}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Eventi -->
  <xsl:template match="tei:rs[@type='event']">
    <span class="event" data-ref="{@ref}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  
  <!-- titolo iniziale -->
  <xsl:template match="tei:head[@type='mainTitle']">
    <h1>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>

  <!-- Citte -->
  <xsl:template match="tei:cit">
    <blockquote>
      <xsl:apply-templates/>
    </blockquote>
  </xsl:template>
  
  <!-- citte letterale -->
  <xsl:template match="tei:quote">
    <q>
      <xsl:apply-templates/>
    </q>
  </xsl:template>
  
  <!-- citte biblio -->
  <xsl:template match="tei:bibl">
    <span class="biblio">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <!-- render <lb/>  -->
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <!-- Default fallback -->
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>
  
   
  
  <!-- rs con @ref -->
  <xsl:template match="tei:rs[@ref]">
    <xsl:variable name="tipo" select="@type"/>
    <a href="{@ref}" class="{@type}" target="_blank" rel="noopener noreferrer">
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
  <!--  rs senza @ref -->
  <xsl:template match="tei:rs[not(@ref)]">
    <span class="{@type}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  
  
  <!-- quasi tabella alla fine per meta  -->
  <xsl:template name="dati-bibliografici">
    <div id="metadata">
      <h2>Dati bibliografici</h2>
      <p><strong>Titolo:</strong>
        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
      </p>
      <p><strong>Autore:</strong>
        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName"/>
      </p>
      <p><strong>Editore:</strong>
        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:editor[@role='editor']/tei:persName"/>
      </p>
      <p><strong>Traduttore:</strong>
        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:editor[@role='translator']/tei:persName"/>
      </p>
      <p><strong>Sponsor:</strong>
        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:sponsor/tei:orgName"/>
      </p>
      <p><strong>Data di pubblicazione:</strong>
        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/>
      </p>
      <p><strong>Licenza / Disponibilità:</strong>
        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/tei:p"/>
      </p>
    </div>
  </xsl:template>

</xsl:stylesheet>
