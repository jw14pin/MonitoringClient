<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <header class="jumbotron subhead">
        	<div class="container">
        		<h1>
        			Monitor Tests
        		</h1>
        	</div>
        </header>
        
        <br/>
        
        <div id="alert-results" class="container"></div>
        
        <br/>
        <br/>
        <br/>
        
        <script type="text/javascript">
        	var data = ${raw};
        	
        	if(data.length == 0) {
        		showNoAlerts();
        	} else {
        		$('#alert-results').append(getHeaderRow()+"<br/>");
        		
	        	for(var h = 0; h < data.length; h++) {
	        		var machine = data[h];
	        		for(var i = 0; i < machine.resources.length; i++) {
						var resource = machine.resources[i];
	
						if(resource.status == 'true') {
							$('#alert-results').append(formatOkAlert(resource));
						} else {
							$('#alert-results').append(formatAlert(resource));
						}
					}
	        	}
        	}
        </script>