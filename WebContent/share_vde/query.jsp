
<sparql:setEndpoint var="vde" sparqlURL="http://services.ld4l.org/fuseki/share_vde_${param.site}/sparql">
</sparql:setEndpoint>

<sparql:construct var="graph" endpoint="${vde}">
	CONSTRUCT { ?s ?p ?o . ?title ?p2 ?o2 . ?contribution ?p3 ?o3 . ?agent ?p3a ?o3a . ?role ?p3b ?o3b . ?expression ?p4 ?o4 . ?content ?p5 ?o5 . ?carrier ?p6 ?o6 . ?media ?p7 ?o7 } WHERE { graph ?g {
		?s ?p ?o .
		OPTIONAL {
			?s <http://id.loc.gov/ontologies/bibframe/title> ?title .
			?title ?p2 ?o2
		}
        OPTIONAL {
            ?s <http://id.loc.gov/ontologies/bibframe/contribution> ?contribution .
            ?contribution ?p3 ?o3
            OPTIONAL {
                ?contribution <http://id.loc.gov/ontologies/bibframe/agent> ?agent .
                ?agent ?p3a ?o3a
            }
            OPTIONAL {
                ?contribution <http://id.loc.gov/ontologies/bibframe/role> ?role .
                ?role ?p3b ?o3b
            }
        OPTIONAL {
            ?s <http://id.loc.gov/ontologies/bibframe/hasExpression> ?expression .
            ?expression ?p4 ?o4
        }
        OPTIONAL {
            ?s <http://id.loc.gov/ontologies/bibframe/content> ?content .
            ?content ?p5 ?o5
        }
        OPTIONAL {
            ?s <http://id.loc.gov/ontologies/bibframe/carrier> ?carrier .
            ?carrier ?p6 ?o6
        }
        OPTIONAL {
            ?s <http://id.loc.gov/ontologies/bibframe/media> ?media .
            ?media ?p7 ?o7
        }
        }
		} }
	<sparql:parameter var="s" value="${param.uri}" type="IRI" />
 </sparql:construct>

