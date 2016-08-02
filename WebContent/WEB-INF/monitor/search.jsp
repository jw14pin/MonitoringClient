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
        			Search Tests
        		</h1>
        	</div>
        </header>
        
        <div class="container">
        
	        <br/>
	        
	        <a href="monitor">Run All Tests</a>
	        
	        <br/>
	        <br/>
	        
	        <form id="search" name="search" method="POST">
	        
	        	<div>
	        
	        	Search By...
	        	<br/>
	        	<br/>
	        	</div>
	        
		        <div class="control-group">
		       		<label class="control-label" for="machine">Machine:</label>
			       	<div class="controls">
				         <select id="machine" name="machine">
				            <option value="">None</option>
				         </select>
			     	</div>
		    	</div>
		        
		        <div>
		        
		        Or
		        <br/>
	        	<br/>
		        </div>
		        
		        <div class="control-group">
		       		<label class="control-label" for="test">Test Name:</label>
			       	<div class="controls">
				         <select id="test" name="test">
				            <option value="">None</option>
				         </select>
			     	</div>
		    	</div>
		        
		        <button class="btn btn-large btn-primary" type="submit">Search</button>
	        
	        </form>
	        
	        <br/>
        
        </div>
        
        <script type="text/javascript">
        	var machineNames = ${machineNames};
        	var testNames = ${testNames};
        	
        	$.each(machineNames, function() {
        		$("#machine").append("<option value='"+this+"'>"+this+"</option>");
        	});
        	
        	$.each(testNames, function() {
        		$("#test").append("<option value='"+this.TEST_ID+"'>"+this.NAME+"</option>");
        	});
        	
        	$("#search").bind('submit',function() {
        		if($("#machine :selected").val() == "" && $("#test :selected").val() == "") {
        			alert("Please pick a machine or test.");
        			return false;
        		}
        	});
        </script>