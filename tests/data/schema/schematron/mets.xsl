<?xml version="1.0" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:mets="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:dv="http://dfg-viewer.de/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" version="1.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<axsl:param name="archiveDirParameter"/><axsl:param name="archiveNameParameter"/><axsl:param name="fileNameParameter"/><axsl:param name="fileDirParameter"/>

<!--PHASES-->


<!--PROLOG-->
<axsl:output xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml" omit-xml-declaration="no" standalone="yes" indent="yes"/>

<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template match="*" mode="schematron-select-full-path"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template match="*" mode="schematron-get-full-path"><axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><axsl:text>/</axsl:text><axsl:choose><axsl:when test="namespace-uri()=''"><axsl:value-of select="name()"/><axsl:variable name="p_1" select="1+    count(preceding-sibling::*[name()=name(current())])"/><axsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p_1"/>]</axsl:if></axsl:when><axsl:otherwise><axsl:text>*[local-name()='</axsl:text><axsl:value-of select="local-name()"/><axsl:text>' and namespace-uri()='</axsl:text><axsl:value-of select="namespace-uri()"/><axsl:text>']</axsl:text><axsl:variable name="p_2" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/><axsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of select="$p_2"/>]</axsl:if></axsl:otherwise></axsl:choose></axsl:template><axsl:template match="@*" mode="schematron-get-full-path"><axsl:text>/</axsl:text><axsl:choose><axsl:when test="namespace-uri()=''">@<axsl:value-of select="name()"/></axsl:when><axsl:otherwise><axsl:text>@*[local-name()='</axsl:text><axsl:value-of select="local-name()"/><axsl:text>' and namespace-uri()='</axsl:text><axsl:value-of select="namespace-uri()"/><axsl:text>']</axsl:text></axsl:otherwise></axsl:choose></axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<axsl:template match="node() | @*" mode="schematron-get-full-path-2"><axsl:for-each select="ancestor-or-self::*"><axsl:text>/</axsl:text><axsl:value-of select="name(.)"/><axsl:if test="preceding-sibling::*[name(.)=name(current())]"><axsl:text>[</axsl:text><axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><axsl:text>]</axsl:text></axsl:if></axsl:for-each><axsl:if test="not(self::*)"><axsl:text/>/@<axsl:value-of select="name(.)"/></axsl:if></axsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<axsl:template match="/" mode="generate-id-from-path"/><axsl:template match="text()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/></axsl:template><axsl:template match="comment()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/></axsl:template><axsl:template match="processing-instruction()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/></axsl:template><axsl:template match="@*" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.@', name())"/></axsl:template><axsl:template match="*" mode="generate-id-from-path" priority="-0.5"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:text>.</axsl:text><axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/></axsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<axsl:template match="node() | @*" mode="schematron-get-full-path-3"><axsl:for-each select="ancestor-or-self::*"><axsl:text>/</axsl:text><axsl:value-of select="name(.)"/><axsl:if test="parent::*"><axsl:text>[</axsl:text><axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><axsl:text>]</axsl:text></axsl:if></axsl:for-each><axsl:if test="not(self::*)"><axsl:text/>/@<axsl:value-of select="name(.)"/></axsl:if></axsl:template>

<!--MODE: GENERATE-ID-2 -->
<axsl:template match="/" mode="generate-id-2">U</axsl:template><axsl:template match="*" mode="generate-id-2" priority="2"><axsl:text>U</axsl:text><axsl:number level="multiple" count="*"/></axsl:template><axsl:template match="node()" mode="generate-id-2"><axsl:text>U.</axsl:text><axsl:number level="multiple" count="*"/><axsl:text>n</axsl:text><axsl:number count="node()"/></axsl:template><axsl:template match="@*" mode="generate-id-2"><axsl:text>U.</axsl:text><axsl:number level="multiple" count="*"/><axsl:text>_</axsl:text><axsl:value-of select="string-length(local-name(.))"/><axsl:text>_</axsl:text><axsl:value-of select="translate(name(),':','.')"/></axsl:template><!--Strip characters--><axsl:template match="text()" priority="-1"/>

<!--SCHEMA METADATA-->
<axsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" title="Regeln des DFG-Viwer METS-Anwendungsprofil 2.1 (Entwurf)" schemaVersion=""><axsl:comment><axsl:value-of select="$archiveDirParameter"/>   
		 <axsl:value-of select="$archiveNameParameter"/>  
		 <axsl:value-of select="$fileNameParameter"/>  
		 <axsl:value-of select="$fileDirParameter"/></axsl:comment><svrl:text>Dieses Dokument befindet sich zur Zeit (Juli 2014) noch in Bearbeitung.</svrl:text><svrl:ns-prefix-in-attribute-values uri="http://www.loc.gov/METS/" prefix="mets"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/xlink" prefix="xlink"/><svrl:ns-prefix-in-attribute-values uri="http://www.tei-c.org/ns/1.0" prefix="tei"/><svrl:ns-prefix-in-attribute-values uri="http://dfg-viewer.de/" prefix="dv"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2004/02/skos/core#" prefix="skos"/><svrl:active-pattern><axsl:attribute name="name">Angaben zur logischen Dokumentenstruktur (2.1)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M7"/><svrl:active-pattern><axsl:attribute name="name">Angaben zur physischen Dokumentenstruktur (2.2)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M8"/><svrl:active-pattern><axsl:attribute name="name">Verknüpfung von logischer und physischer Struktur (2.3)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M9"/><svrl:active-pattern><axsl:attribute name="name">Digital Repräsentation (2.4)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M10"/><svrl:active-pattern><axsl:attribute name="name">Deskriptive Metadaten (2.5)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M11"/><svrl:active-pattern><axsl:attribute name="name">Administrative Metadaten (2.6)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M12"/></svrl:schematron-output></axsl:template>

<!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Regeln des DFG-Viwer METS-Anwendungsprofil 2.1 (Entwurf)</svrl:text>

<!--PATTERN Angaben zur logischen Dokumentenstruktur (2.1)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Angaben zur logischen Dokumentenstruktur (2.1)</svrl:text>

	<!--RULE -->
<axsl:template match="mets:mets" priority="1003" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mets"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:structMap[@TYPE = 'LOGICAL']"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:structMap[@TYPE = 'LOGICAL']"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Jede METS-Datei muss mindestens ein logisches Strukturelement enthalten. Für die logische Struktur muss das
        Attribute @TYPE mit dem Wert LOGICAL verwendet werden.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M7"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:structMap[@TYPE = 'LOGICAL'][1]" priority="1002" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:structMap[@TYPE = 'LOGICAL'][1]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:div"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:div"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Jede METS-Datei muss mindestens ein logisches Strukturelement enthalten.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:div/@ADMID"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:div/@ADMID"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Für das primäre Strukturelement der METS-Datei ist im Attribut @ADMID die ID der für den DFG-Viewer relevanten
        administrativen Metadatensektion anzugeben.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="mets:div/mets:mptr"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:div/mets:mptr"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das primäre Strukturelement der METS-Datei darf kein mets:mptr enthalten.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*" mode="M7"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:div[ancestor::mets:structMap[@TYPE = 'LOGICAL']]" priority="1001" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:div[ancestor::mets:structMap[@TYPE = 'LOGICAL']]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(mets:mptr) &lt; 2"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(mets:mptr) &lt; 2"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Jedes mets:div darf nur ein mets:mptr enthalten.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@TYPE and document('../util/strukturdatenset.rdf')//skos:Concept[skos:notation = current()/@TYPE]"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@TYPE and document('../util/strukturdatenset.rdf')//skos:Concept[skos:notation = current()/@TYPE]"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Im Attribut @TYPE muss die Art des Strukturelements näher bezeichnet werden. Es sind nur Werte aus der
        DFG-Viewer-Strukturdatenliste erlaubt.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M7"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:mptr[not(../../../mets:structMap)]" priority="1000" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mptr[not(../../../mets:structMap)]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="(@LOCTYPE = 'URL' or @LOCTYPE = 'PURL')"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="(@LOCTYPE = 'URL' or @LOCTYPE = 'PURL')"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Unerlaubter Wert für das Attribut @LOCTYPE. Es sind nur die Werte URL und PURL zulässig.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M7"/></axsl:template><axsl:template match="text()" priority="-1" mode="M7"/><axsl:template match="@*|node()" priority="-2" mode="M7"><axsl:apply-templates select="@*|*" mode="M7"/></axsl:template>

<!--PATTERN Angaben zur physischen Dokumentenstruktur (2.2)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Angaben zur physischen Dokumentenstruktur (2.2)</svrl:text>

	<!--RULE -->
<axsl:template match="mets:mets" priority="1003" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mets"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(mets:structMap[@TYPE = 'PHYSICAL']) &lt; 2"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(mets:structMap[@TYPE = 'PHYSICAL']) &lt; 2"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Ein Dokument kann nur eine physische Struktur besitzen.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M8"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:structMap[@TYPE = 'PHYSICAL']" priority="1002" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:structMap[@TYPE = 'PHYSICAL']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:div/@TYPE = 'physSequence'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:div/@TYPE = 'physSequence'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Die Sequenz der Seiten muss durch den Wert physSequence im Attribut @TYPE gekennzeichnet werden.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M8"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:structMap[@TYPE = 'PHYSICAL']/mets:div/mets:div" priority="1001" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:structMap[@TYPE = 'PHYSICAL']/mets:div/mets:div"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="(@TYPE = 'page') or (@TYPE = 'doublepage')"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="(@TYPE = 'page') or (@TYPE = 'doublepage')"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Einzelseiten müssen mit dem Wert page im Attribute @TYPE gekennzeichnet werden.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="(@TYPE = 'doublepage')"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="(@TYPE = 'doublepage')"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Veralteter Wert für doppelseitig gescannte Digitalisate im Attribut @TYPE. Dieser Wert sollte nicht mehr
        verwendet werden.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--ASSERT -->
<axsl:choose><axsl:when test="string(number(@ORDER)) != 'NaN'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="string(number(@ORDER)) != 'NaN'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Attribut @ORDER muss einen numerischen Sortierwert enthalten, mit dem sich die Einzelseiten in ihre korrekte
        physische Reihenfolge bringen lassen.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:fptr"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:fptr"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Zu jeder Einzelseite muss es mindestens eine digitale Repräsentation geben, die im DFG-Viewer angezeigt werden
        kann.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M8"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:fptr[ancestor::mets:structMap[@TYPE = 'PHYSICAL']]" priority="1000" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:fptr[ancestor::mets:structMap[@TYPE = 'PHYSICAL']]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="//mets:file[@ID = current()/@FILEID]"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="//mets:file[@ID = current()/@FILEID]"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Der Verweis auf die digitale Repräsentation einer Einzelseite muss über das Attribute @FILEID erfolgen, das die
        ID des entsprechenden Elements in der Dateisektion enthält.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M8"/></axsl:template><axsl:template match="text()" priority="-1" mode="M8"/><axsl:template match="@*|node()" priority="-2" mode="M8"><axsl:apply-templates select="@*|*" mode="M8"/></axsl:template>

<!--PATTERN Verknüpfung von logischer und physischer Struktur (2.3)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Verknüpfung von logischer und physischer Struktur (2.3)</svrl:text>

	<!--RULE -->
<axsl:template match="mets:mets" priority="1001" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mets"/>

		<!--REPORT -->
<axsl:if test="mets:structMap[@TYPE = 'LOGICAL'] and mets:structMap[@TYPE = 'PHYSICAL'] and not(mets:structLink)"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:structMap[@TYPE = 'LOGICAL'] and mets:structMap[@TYPE = 'PHYSICAL'] and not(mets:structLink)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Die METS-Datei enthält sowohl eine logische wie auch eine physische Struktur. Beide Strukturen müssen
        miteinander verknüpft werden.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="mets:structLink and (count(mets:structLink) &gt; 1)"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:structLink and (count(mets:structLink) &gt; 1)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Element mets:structLink ist nicht wiederholbar.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*" mode="M9"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:smLink[parent::mets:structLink]" priority="1000" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:smLink[parent::mets:structLink]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="//mets:div[ancestor::mets:structMap[@TYPE = 'LOGICAL']][@ID = current()/@xlink:from]"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="//mets:div[ancestor::mets:structMap[@TYPE = 'LOGICAL']][@ID = current()/@xlink:from]"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Attribut @xlink:from muss die ID eines logischen Strukturelements enthalten.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="//mets:div[ancestor::mets:structMap[@TYPE = 'PHYSICAL']][@ID = current()/@xlink:to]"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="//mets:div[ancestor::mets:structMap[@TYPE = 'PHYSICAL']][@ID = current()/@xlink:to]"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Attribut @xlink:to muss die ID eines physischen Strukturelements enthalten.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M9"/></axsl:template><axsl:template match="text()" priority="-1" mode="M9"/><axsl:template match="@*|node()" priority="-2" mode="M9"><axsl:apply-templates select="@*|*" mode="M9"/></axsl:template>

<!--PATTERN Digital Repräsentation (2.4)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Digital Repräsentation (2.4)</svrl:text>

	<!--RULE -->
<axsl:template match="mets:mets" priority="1004" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mets"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(mets:fileSec) &lt; 2"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(mets:fileSec) &lt; 2"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Element mets:fileSec ist nicht wiederholbar.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M10"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:fileSec" priority="1003" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:fileSec"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:fileGrp[@USE = 'DEFAULT']"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:fileGrp[@USE = 'DEFAULT']"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Es muss mindestens eine mets:fileGrp gegeben, deren Attribut @USE den Wert DEFAULT besitzt.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M10"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:fileGrp" priority="1002" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:fileGrp"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="document('../util/filegrp-use.rdf')//skos:Concept[skos:notation = current()/@USE]"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="document('../util/filegrp-use.rdf')//skos:Concept[skos:notation = current()/@USE]"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Der Wert des @USE-Attributs muss aus der Liste der zulässigen Werte stammen.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M10"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:file" priority="1001" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:file"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(mets:FLocat) = 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(mets:FLocat) = 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Innerhalb eines jeden mets:file muss es genau ein mets:FLocat geben.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M10"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:FLocat" priority="1000" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:FLocat"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="(@LOCTYPE = 'URL' or @LOCTYPE = 'PURL')"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="(@LOCTYPE = 'URL' or @LOCTYPE = 'PURL')"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Unerlaubter Wert für das Attribut @LOCTYPE. Es sind nur die Werte URL und PURL zulässig.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M10"/></axsl:template><axsl:template match="text()" priority="-1" mode="M10"/><axsl:template match="@*|node()" priority="-2" mode="M10"><axsl:apply-templates select="@*|*" mode="M10"/></axsl:template>

<!--PATTERN Deskriptive Metadaten (2.5)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Deskriptive Metadaten (2.5)</svrl:text>

	<!--RULE -->
<axsl:template match="mets:mets" priority="1001" mode="M11"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mets"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:dmdSec[@ID = /mets:mets/mets:structMap[@TYPE = 'LOGICAL'][1]/mets:div/@DMDID]"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:dmdSec[@ID = /mets:mets/mets:structMap[@TYPE = 'LOGICAL'][1]/mets:div/@DMDID]"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Es muss mindestens eine mets:dmdSec für das primäre logische Strukturelement definiert sein.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M11"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:mdWrap[parent::mets:dmdSec]" priority="1000" mode="M11"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mdWrap[parent::mets:dmdSec]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="(@MDTYPE = 'MODS') or (@MDTYPE = 'EAD') or (@MDTYPE = 'DC') or (@MDTYPE = 'TEIHDR')"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="(@MDTYPE = 'MODS') or (@MDTYPE = 'EAD') or (@MDTYPE = 'DC') or (@MDTYPE = 'TEIHDR')"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Unerlaubter Wert für das Attribut @MDTYPE. Es sind nur die Werte MODS, EAD, DC oder TEIHDR zulässig.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M11"/></axsl:template><axsl:template match="text()" priority="-1" mode="M11"/><axsl:template match="@*|node()" priority="-2" mode="M11"><axsl:apply-templates select="@*|*" mode="M11"/></axsl:template>

<!--PATTERN Administrative Metadaten (2.6)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Administrative Metadaten (2.6)</svrl:text>

	<!--RULE -->
<axsl:template match="mets:mets" priority="1003" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mets"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(mets:amdSec) = 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(mets:amdSec) = 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Element mets:amdSec ist verpflichtend und nicht wiederholbar.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M12"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:rightsMD" priority="1002" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:rightsMD"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(mets:mdWrap) = 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(mets:mdWrap) = 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Element mets:mdWrap is verpflichtend und nicht wiederholbar.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M12"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:mdWrap[parent::mets:rightsMD]" priority="1001" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mdWrap[parent::mets:rightsMD]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@MDTYPE = 'OTHER' and @OTHERMDTYPE = 'DVRIGHTS'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@MDTYPE = 'OTHER' and @OTHERMDTYPE = 'DVRIGHTS'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Attribut @MDTYPE muss mit dem Wert OTHER und das Attribut OTHERMDTYPE mit dem Wert DVRIGHTS belegt sein.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:xmlData/dv:rights"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:xmlData/dv:rights"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Die Angabe von Rechteinformationen nach dem Standard des DFG-Viewer ist verpflichtend.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M12"/></axsl:template>

	<!--RULE -->
<axsl:template match="mets:mdWrap[parent::mets:digiprovMD]" priority="1000" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="mets:mdWrap[parent::mets:digiprovMD]"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@MDTYPE = 'OTHER' and @OTHERMDTYPE = 'DVLINKS'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@MDTYPE = 'OTHER' and @OTHERMDTYPE = 'DVLINKS'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Das Attribut @MDTYPE muss mit dem Wert OTHER und das Attribut OTHERMDTYPE mit dem Wert DVLINKS belegt sein.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="mets:xmlData/dv:links"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="mets:xmlData/dv:links"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Die Angabe von Verweisen zu Katalognachweisen und lokaler Präsentation nach dem Standard des DFG-Viewer ist
        verpflichtend.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*" mode="M12"/></axsl:template><axsl:template match="text()" priority="-1" mode="M12"/><axsl:template match="@*|node()" priority="-2" mode="M12"><axsl:apply-templates select="@*|*" mode="M12"/></axsl:template></axsl:stylesheet>
