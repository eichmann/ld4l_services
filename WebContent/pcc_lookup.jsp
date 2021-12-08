<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/ckb_2_0_stage_A/sparql">
	<sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/" />
	<sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/" />
	<sparql:prefix prefix="rdf"	baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#" />
	<sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#" />
	<sparql:prefix prefix="schema" baseURI="http://schema.org/" />
	<sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#" />
	<sparql:prefix prefix="bf" baseURI="http://id.loc.gov/ontologies/bibframe/" />
	<sparql:prefix prefix="skos" baseURI="http://www.w3.org/2004/02/skos/core#" />
</sparql:setEndpoint>

<c:choose>
	<c:when test="${fn:startsWith(param.uri,'https://svde.org/works')}">
		<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s bf:expressionOf ?o . ?o bf:title ?o1 . ?o1 rdfs:label ?o2 .
    			?s rdf:type ?t .
    			?s bf:content ?c . ?c skos:prefLabel ?p .
    			?s bf:content ?c2 . ?c2 rdfs:label ?p2 .
    			?s bf:contribution ?con . ?con bf:agent ?ag . ?ag rdfs:label ?cl .
    			?s bf:contribution ?con2 . ?con2 bf:agent ?ag2 . ?ag2 bf:role ?r . ?r rdfs:label ?cl2 .
    			?s bf:orginDate ?d .
    			?s bf:language ?l . ?l rdfs:label ?ll .
    			?s bf:language ?l2 . ?l2 skos:prefLabel ?ll2 .
    			} WHERE {
      ?s bf:expressionOf ?o .
      ?o bf:title ?o1 .
      ?o1 rdfs:label ?o2 .
      OPTIONAL {
      	?s rdf:type ?t .
	  }
      OPTIONAL {
      	?s bf:content ?c .
		?c skos:prefLabel ?p
	  }
      OPTIONAL {
      	?s bf:content ?c2 .
		?c2 rdfs:label ?p2
	  }
      OPTIONAL {
      	?s  bf:contribution ?con .
		?con bf:agent ?ag .
		?ag rdfs:label ?cl .
	  }
      OPTIONAL {
      	?s  bf:contribution ?con2 .
		?con2 bf:agent ?ag2 .
		?ag2 bf:role ?r .
		?r rdfs:label ?cl2 .
	  }
      OPTIONAL {
      	?s bf:orginDate ?d .
	  }
      OPTIONAL {
      	?s bf:language ?l .
		?l rdfs:label ?ll
	  }
      OPTIONAL {
      	?s bf:language ?l2 .
		?l2 skos:prefLabel ?ll2
	  }
	}
			<sparql:parameter var="s" value="${param.uri}" type="IRI" />
		</sparql:construct>
	</c:when>
	<c:when test="${fn:startsWith(param.uri,'https://svde.org/opuses')}">
		<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s bf:title ?o1 . ?o1 rdfs:label ?o2 .
    			?s rdf:type ?t .
    			?s bf:contribution ?con . ?con bf:agent ?ag . ?ag rdfs:label ?cl .
    			?s bf:contribution ?con2 . ?con2 bf:agent ?ag2 . ?ag2 bf:role ?r . ?r rdfs:label ?cl2 .
    			?s bf:orginDate ?d .
    			} WHERE {
      ?s bf:title ?o1 .
      ?o1 rdfs:label ?o2 .
      OPTIONAL {
      	?s rdf:type ?t .
	  }
      OPTIONAL {
      	?s  bf:contribution ?con .
		?con bf:agent ?ag .
		?ag rdfs:label ?cl .
	  }
      OPTIONAL {
      	?s  bf:contribution ?con2 .
		?con2 bf:agent ?ag2 .
		?ag2 bf:role ?r .
		?r rdfs:label ?cl2 .
	  }
      OPTIONAL {
      	?s bf:orginDate ?d .
	  }
	}
			<sparql:parameter var="s" value="${param.uri}" type="IRI" />
		</sparql:construct>
	</c:when>
	<c:when test="${fn:startsWith(param.uri,'https://svde.org/instances')}">
		<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s bf:title ?o1 . ?o1 rdfs:label ?o2 .
    			?s rdfs:label ?o3 .
 	  			?s rdf:type ?t .
     			?s bf:carrier ?car . ?car rdfs:label ?carl .
     			?s bf:carrier ?car2 . ?car2 skos:preflabel ?carl2 .
    			?s bf:media ?med . ?med rdfs:label ?medl .
     			?s bf:media ?med2 . ?med2 skos:preflabel ?medl2 .
     			?s bf:responsibilityStatement ?rs .
    			?s bf:provisionActivityStatement ?pas .
    			?s bf:dimensions ?dim .
    			?s bf:instanceOf ?io . ?io bf:language ?lang . ?lang rdfs:label ?langl .
    			?s bf:instanceOf ?io2 . ?io2 bf:language ?lang2 . ?lang2 skos:preflabel ?langl2 .
    			} WHERE {
      ?s bf:title ?o1 .
      ?o1 rdfs:label ?o2 .
      OPTIONAL {
      	?s rdfs:label ?o3 .
	  }
      OPTIONAL {
      	?s rdf:type ?t .
	  }
      OPTIONAL {
      	?s  bf:carrier ?car .
		?car rdfs:label ?carl .
	  }
      OPTIONAL {
      	?s  bf:carrier ?car2 .
		?car2 skos:preflabel ?carl2 .
	  }
      OPTIONAL {
      	?s  bf:media ?med .
		?med rdfs:label ?medl .
	  }
      OPTIONAL {
      	?s  bf:media ?med2 .
		?med2 skos:preflabel ?mdel2 .
	  }
      OPTIONAL {
      	?s bf:responsibilityStatement ?rs .
	  }
      OPTIONAL {
      	?s bf:provisionActivityStatement ?pas .
	  }
      OPTIONAL {
      	?s bf:dimensions ?dim .
	  }
      OPTIONAL {
      	?s  bf:instanceOf ?io .
		?io bf:language ?lang .
		?lang rdfs:label ?langl .
	  }
      OPTIONAL {
      	?s  bf:instanceOf ?io2 .
		?io2 bf:language ?lang2 .
		?lang2 skos:preflabel ?langl2 .
	  }
	}
			<sparql:parameter var="s" value="${param.uri}" type="IRI" />
		</sparql:construct>
	</c:when>
</c:choose>


<jsp:include page="emit_graph.jsp" />
