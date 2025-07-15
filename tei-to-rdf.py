import xml.etree.ElementTree as ET
from rdflib import Graph, Literal, Namespace, RDF, URIRef
from rdflib.namespace import DC, DCTERMS, RDFS, XSD

=
SCHEMA = Namespace("http://schema.org/")
SCHEMA1 = Namespace("http://example.org/schema1/")
EX = Namespace("http://example.org/tei/")
WD = Namespace("https://www.wikidata.org/wiki/")

#  leggi xml 
tree = ET.parse("OfFear.xml")
root = tree.getroot()
NS = {'tei': 'http://www.tei-c.org/ns/1.0'}

#  grafo 
g = Graph()
g.bind("dc", DC)
g.bind("dcterms", DCTERMS)
g.bind("schema", SCHEMA)
g.bind("schema1", SCHEMA1)
g.bind("ex", EX)
g.bind("wd", WD)
g.bind("rdfs", RDFS)

#  Dati opera  
doc_uri = EX["OfFear"]
g.add((doc_uri, RDF.type, SCHEMA.CreativeWork))

# titolotitolo
title = root.find(".//tei:titleStmt/tei:title", NS)
if title is not None:
    g.add((doc_uri, DC.title, Literal(title.text.strip())))

# autore
author = root.find(".//tei:titleStmt/tei:author/tei:persName", NS)
if author is not None:
    g.add((doc_uri, DC.creator, Literal(author.text.strip())))

# editore
publisher = root.find(".//tei:publicationStmt/tei:distributor/tei:orgName", NS)
if publisher is not None:
    g.add((doc_uri, DC.publisher, Literal(publisher.text.strip())))

# varie edizione 
contributors = root.findall(".//tei:titleStmt/tei:editor", NS)
for c in contributors:
    name = c.find("tei:persName", NS)
    if name is not None:
        g.add((doc_uri, DCTERMS.contributor, Literal(name.text.strip())))

# data
date = root.find(".//tei:publicationStmt/tei:date", NS)
if date is not None and "when" in date.attrib:
    g.add((doc_uri, DCTERMS.issued, Literal(date.attrib["when"], datatype=XSD.date)))

#  citte 
for author_el in root.findall(".//tei:bibl/tei:author", NS):
    ref = author_el.attrib.get("ref")
    name = author_el.text.strip() if author_el.text else None
    if ref and name:
        author_uri = URIRef(ref)
        g.add((author_uri, RDF.type, SCHEMA1.CreativeWork))
        g.add((author_uri, SCHEMA1.author, author_uri))
        g.add((author_uri, SCHEMA1.name, Literal(name)))
        g.add((author_uri, SCHEMA1.citation, doc_uri))

#  persone luoghi cose
for rs in root.findall(".//tei:rs", NS):
    ref = rs.attrib.get("ref")
    xml_id = rs.attrib.get("{http://www.w3.org/XML/1998/namespace}id")
    rs_type = rs.attrib.get("type")

    if ref and xml_id and rs_type:
        entity_uri = URIRef(ref)
        label = Literal(xml_id)
        g.add((entity_uri, RDFS.label, label))
        g.add((entity_uri, SCHEMA.name, label))

        if rs_type == "person":
            g.add((entity_uri, RDF.type, SCHEMA.Person))
        elif rs_type == "place":
            g.add((entity_uri, RDF.type, SCHEMA.Place))
        elif rs_type == "event":
            g.add((entity_uri, RDF.type, SCHEMA.Event))

#fine ...
g.serialize(destination="OfFear.ttl", format="turtle")


