<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/loc_genre/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
    <sparql:prefix prefix="skos" baseURI="http://www.w3.org/2004/02/skos/core#"/>
    <sparql:prefix prefix="loc" baseURI="http://id.loc.gov/vocabulary/identifiers/"/>
</sparql:setEndpoint>

 <sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s ?p ?o . ?o skos:prefLabel ?r . ?o loc:lccn ?ra . ?o2 skos:prefLabel ?r2 . ?o2 loc:lccn ?r2a . ?o3 ?p3 ?r3 . ?o4 ?p4 ?r4 } WHERE {
      ?s ?p ?o .
      OPTIONAL {
      	?s skos:narrower ?o .
        ?o skos:prefLabel ?r .
        OPTIONAL {
        	?o loc:lccn ?ra .
        }
      }
      OPTIONAL {
      	?s skos:broader ?o2 .
        ?o2 skos:prefLabel ?r2 .
        OPTIONAL {
        	?o2 loc:lccn ?r2a .
        }
      }
      OPTIONAL {
      	?s mads:hasSource ?o3 .
        ?o3 ?p3 ?r3 .
      }
      OPTIONAL {
      	?s mads:useInstead ?o4 .
        ?o4 ?p4 ?r4 .
      }
      <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
    }
    <sparql:parameter var="s" value="${param.uri}" type="IRI" />
</sparql:construct>
 