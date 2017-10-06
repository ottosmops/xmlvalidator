# Validierung von Metadaten für den DFG-Viewer

Dieses Repository versammelt verschiedene Schemata für die Validierung
von Metadaten für den DFG-Viewer.

Alle Dateien sind noch als *work in progress* zu betrachten.

## Rechteangaben (<dv:rights>)

- [RelaxNG Compact Syntax](relaxng/dvrights.rnc "Rechteangaben, RNC")
- [RelaxNG](relaxng/dvrights.rng "Rechteangaben, RNG")

## Verweise (<dv:links>)

- [RelaxNG Compact Syntax](relaxng/dvlinks.rnc "Verweise, RNC")
- [RelaxNG](relaxng/dvlinks.rng "Verweise, RNG")

## METS

- [ISO Schematron](schematron/mets.sch "METS, ISO-Schematron")
- [XSLT 1.0 Stylesheet](schematron/mets.xsl "METS, XSLT 1.0 Stylesheet")
- [NVDL Skript](nvdl/mets.nvdl "METS, NVDL Skript")

## Hilfsdaten

- [RDF/XML des Strukturdatensets](util/strukturdatenset.rdf "Strukturdatenset, RDF/XML")
- [RDF/XML der zulässigen METS Dateigruppen](util/filegrp-use.rdf "METS Dateigruppen, RDF/XML")
