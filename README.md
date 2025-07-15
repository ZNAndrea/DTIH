 # DTIH
 ## "Digital Text in the Humanities"  
The material present in this folder represent the requested file and script for the evaluation of the  "Digital Text in the Humanities" exam held by UNIBO in the " Digital Humanities and Digital Knowledge" master degree course.
This material describe a working example of the data processing of a  digital text from its starting point  through the  knowmledge graph extraction via XML annotation . 

The  pourpouse and description of files are  as follows :
1. "Essay of Michel de Montaign- Of Fear.pdf" -  Is the original text we took as imput for the XML/ TEI  annotation and  trasformation.
2. "OfFear.xml" -  Is the xml annotation of th essay based on the TEI standards.
3. "tei-to-html-5.1.xsl"- is the style sheet created for XSLT transformation int .html file.
4. "OfFear.html"-Is the .html output from XSLT transformation.
5. "style.css"- Minimalistic style sheet for .html visualisation.
6. "tei-to-rdf.py"- is the python script for the cration of an  RDF graph based on the xml annotation in the main .xml file 
7. "OfFear.ttl"- Is the output file from the .py script that represent the RDF graph serialized in .ttl format. 
