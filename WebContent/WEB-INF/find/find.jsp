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
        			Manage Tests
        		</h1>
        	</div>
        </header>
        
        <div class="container">
	        
	        <br/>
	        
	        <form id="find" name="find" method="POST">
		        
		        <div class="control-group">
		       		<label class="control-label" for="test">Test Name:</label>
			       	<div class="controls">
				         <select id="test_id" name="test_id">
				            <option value="">None</option>
				         </select>
			     	</div>
		    	</div>
		        
		        <button class="btn btn-large btn-primary" type="submit">Search</button>
	        
	        </form>
	        
	        <br/>
        
        </div>
        
        <script type="text/javascript">
        	var testNames = ${testNames};
        	
        	$.each(testNames, function() {
        		$("#test_id").append("<option value='"+this.TEST_ID+"'>"+this.NAME+"</option>");
        	});
        	
        	$("#find").bind('submit',function() {
        		if($("#test_id :selected").val() == "") {
        			alert("Please pick a test.");
        			return false;
        		}
        	});
        </script>