<?xml version="1.0" encoding="utf-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="deu">
  <title>Regeln des DFG-Viwer METS-Anwendungsprofil 2.1 (Entwurf)</title>
  <ns prefix="mets" uri="http://www.loc.gov/METS/"/>
  <ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
  <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
  <ns prefix="dv" uri="http://dfg-viewer.de/"/>
  <ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
  <p>Dieses Dokument befindet sich zur Zeit (Juli 2014) noch in Bearbeitung.</p>
  <pattern>
    <title>Angaben zur logischen Dokumentenstruktur (2.1)</title>
    <rule context="mets:mets">
      <assert test="mets:structMap[@TYPE = 'LOGICAL']">
        Jede METS-Datei muss mindestens ein logisches Strukturelement enthalten. Für die logische Struktur muss das
        Attribute @TYPE mit dem Wert LOGICAL verwendet werden.
      </assert>
    </rule>
    <rule context="mets:structMap[@TYPE = 'LOGICAL'][1]">
      <assert test="mets:div">
        Jede METS-Datei muss mindestens ein logisches Strukturelement enthalten.
      </assert>
      <assert test="mets:div/@ADMID">
        Für das primäre Strukturelement der METS-Datei ist im Attribut @ADMID die ID der für den DFG-Viewer relevanten
        administrativen Metadatensektion anzugeben.
      </assert>
      <report test="mets:div/mets:mptr">
        Das primäre Strukturelement der METS-Datei darf kein mets:mptr enthalten.
      </report>
    </rule>
    <rule context="mets:div[ancestor::mets:structMap[@TYPE = 'LOGICAL']]">
      <assert test="count(mets:mptr) &lt; 2">
        Jedes mets:div darf nur ein mets:mptr enthalten.
      </assert>
      <assert test="@TYPE and document('../util/strukturdatenset.rdf')//skos:Concept[skos:notation = current()/@TYPE]">
        Im Attribut @TYPE muss die Art des Strukturelements näher bezeichnet werden. Es sind nur Werte aus der
        DFG-Viewer-Strukturdatenliste erlaubt.
      </assert>
    </rule>
    <rule context="mets:mptr[not(../../../mets:structMap)]">
      <assert test="(@LOCTYPE = 'URL' or @LOCTYPE = 'PURL')">
        Unerlaubter Wert für das Attribut @LOCTYPE. Es sind nur die Werte URL und PURL zulässig.
      </assert>
    </rule>
  </pattern>
  <pattern>
    <title>Angaben zur physischen Dokumentenstruktur (2.2)</title>
    <rule context="mets:mets">
      <assert test="count(mets:structMap[@TYPE = 'PHYSICAL']) &lt; 2">
        Ein Dokument kann nur eine physische Struktur besitzen.
      </assert>
    </rule>
    <rule context="mets:structMap[@TYPE = 'PHYSICAL']">
      <assert test="mets:div/@TYPE = 'physSequence'">
        Die Sequenz der Seiten muss durch den Wert physSequence im Attribut @TYPE gekennzeichnet werden.
      </assert>
    </rule>
    <rule context="mets:structMap[@TYPE = 'PHYSICAL']/mets:div/mets:div">
      <assert test="(@TYPE = 'page') or (@TYPE = 'doublepage')">
        Einzelseiten müssen mit dem Wert page im Attribute @TYPE gekennzeichnet werden.
      </assert>
      <report test="(@TYPE = 'doublepage')">
        Veralteter Wert für doppelseitig gescannte Digitalisate im Attribut @TYPE. Dieser Wert sollte nicht mehr
        verwendet werden.
      </report>
      <assert test="string(number(@ORDER)) != 'NaN'">
        Das Attribut @ORDER muss einen numerischen Sortierwert enthalten, mit dem sich die Einzelseiten in ihre korrekte
        physische Reihenfolge bringen lassen.
      </assert>
      <assert test="mets:fptr">
        Zu jeder Einzelseite muss es mindestens eine digitale Repräsentation geben, die im DFG-Viewer angezeigt werden
        kann.
      </assert>
    </rule>
    <rule context="mets:fptr[ancestor::mets:structMap[@TYPE = 'PHYSICAL']]">
      <assert test="//mets:file[@ID = current()/@FILEID]">
        Der Verweis auf die digitale Repräsentation einer Einzelseite muss über das Attribute @FILEID erfolgen, das die
        ID des entsprechenden Elements in der Dateisektion enthält.
      </assert>
    </rule>
  </pattern>
  <pattern>
    <title>Verknüpfung von logischer und physischer Struktur (2.3)</title>
    <rule context="mets:mets">
      <report test="mets:structMap[@TYPE = 'LOGICAL'] and mets:structMap[@TYPE = 'PHYSICAL'] and not(mets:structLink)">
        Die METS-Datei enthält sowohl eine logische wie auch eine physische Struktur. Beide Strukturen müssen
        miteinander verknüpft werden.
      </report>
      <report test="mets:structLink and (count(mets:structLink) &gt; 1)">
        Das Element mets:structLink ist nicht wiederholbar.
      </report>
    </rule>
    <rule context="mets:smLink[parent::mets:structLink]">
      <assert test="//mets:div[ancestor::mets:structMap[@TYPE = 'LOGICAL']][@ID = current()/@xlink:from]">
        Das Attribut @xlink:from muss die ID eines logischen Strukturelements enthalten.
      </assert>
      <assert test="//mets:div[ancestor::mets:structMap[@TYPE = 'PHYSICAL']][@ID = current()/@xlink:to]">
        Das Attribut @xlink:to muss die ID eines physischen Strukturelements enthalten.
      </assert>      
    </rule>
  </pattern>
  <pattern>
    <title>Digital Repräsentation (2.4)</title>
    <rule context="mets:mets">
      <assert test="count(mets:fileSec) &lt; 2">
        Das Element mets:fileSec ist nicht wiederholbar.
      </assert>
    </rule>
    <rule context="mets:fileSec">
      <assert test="mets:fileGrp[@USE = 'DEFAULT']">
        Es muss mindestens eine mets:fileGrp gegeben, deren Attribut @USE den Wert DEFAULT besitzt.
      </assert>
    </rule>
    <rule context="mets:fileGrp">
      <assert test="document('../util/filegrp-use.rdf')//skos:Concept[skos:notation = current()/@USE]">
        Der Wert des @USE-Attributs muss aus der Liste der zulässigen Werte stammen.
      </assert>
    </rule>
    <rule context="mets:file">
      <assert test="count(mets:FLocat) = 1">
        Innerhalb eines jeden mets:file muss es genau ein mets:FLocat geben.
      </assert>
    </rule>
    <rule context="mets:FLocat">
      <assert test="(@LOCTYPE = 'URL' or @LOCTYPE = 'PURL')">
        Unerlaubter Wert für das Attribut @LOCTYPE. Es sind nur die Werte URL und PURL zulässig.
      </assert>
    </rule>
  </pattern>
  <pattern>
    <title>Deskriptive Metadaten (2.5)</title>
    <rule context="mets:mets">
      <assert test="mets:dmdSec[@ID = /mets:mets/mets:structMap[@TYPE = 'LOGICAL'][1]/mets:div/@DMDID]">
        Es muss mindestens eine mets:dmdSec für das primäre logische Strukturelement definiert sein.
      </assert>
    </rule>
    <rule context="mets:mdWrap[parent::mets:dmdSec]">
      <assert test="(@MDTYPE = 'MODS') or (@MDTYPE = 'EAD') or (@MDTYPE = 'DC') or (@MDTYPE = 'TEIHDR')">
        Unerlaubter Wert für das Attribut @MDTYPE. Es sind nur die Werte MODS, EAD, DC oder TEIHDR zulässig.
      </assert>
    </rule>
  </pattern>
  <pattern>
    <title>Administrative Metadaten (2.6)</title>
    <rule context="mets:mets">
      <assert test="count(mets:amdSec) = 1">
        Das Element mets:amdSec ist verpflichtend und nicht wiederholbar.
      </assert>
    </rule>
    <rule context="mets:rightsMD">
      <assert test="count(mets:mdWrap) = 1">
        Das Element mets:mdWrap is verpflichtend und nicht wiederholbar.
      </assert>
    </rule>
    <rule context="mets:mdWrap[parent::mets:rightsMD]">
      <assert test="@MDTYPE = 'OTHER' and @OTHERMDTYPE = 'DVRIGHTS'">
        Das Attribut @MDTYPE muss mit dem Wert OTHER und das Attribut OTHERMDTYPE mit dem Wert DVRIGHTS belegt sein.
      </assert>
      <assert test="mets:xmlData/dv:rights">
        Die Angabe von Rechteinformationen nach dem Standard des DFG-Viewer ist verpflichtend.
      </assert>
    </rule>
    <rule context="mets:mdWrap[parent::mets:digiprovMD]">
      <assert test="@MDTYPE = 'OTHER' and @OTHERMDTYPE = 'DVLINKS'">
        Das Attribut @MDTYPE muss mit dem Wert OTHER und das Attribut OTHERMDTYPE mit dem Wert DVLINKS belegt sein.
      </assert>
      <assert test="mets:xmlData/dv:links">
        Die Angabe von Verweisen zu Katalognachweisen und lokaler Präsentation nach dem Standard des DFG-Viewer ist
        verpflichtend.
      </assert>
    </rule>
  </pattern>
</schema>
