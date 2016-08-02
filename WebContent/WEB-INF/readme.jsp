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
        			About!
        		</h1>
        	</div>
        	<div class="container content">
	        	<div class="paddedbox">
	        		<h2>
	        			Register a new test
	        		</h2>
		        		<p>
		        			Click on the menu link labeled "Register" and select the type of test to create.  Proceed to fill in the test information and then click the button labeled "Register".
		        			<br/>
		        			<br/>
		        			<b>Requested information:</b>
		        			<br/>
		        			<br/>
		        			Machine - the machine that this test refers to.
		        			<br/>
		        			Name - the unique name of this test.
		        			<br/>
		        			URL/DB Connection String - the full URL or the string for connecting to the DB.  (URL and DB options only and only Oracle DB supported currently)
		        			<br/>
		        			Click-Through Commands - Type a list of commands to be executed sequentially. (Click-Through option only)
		        			<br/>
		        			<br/>
		        			Commands available (parameters typed in order of occurrence):
		        				<br/>
		        				open [url]
		        				<br/>
		        				click [element id]
		        				<br/>
		        				type [element id] [characters]
		        				<br/>
		        				verify [characters] (no space allowed currently)
		        				<br/>
		        			<br/>
		        			Example:	
		        						<br/>
		        						&nbsp;&nbsp;&nbsp; open http://telausb2b2115.telcustomer.test:8082/telhome/logon.do
		        						<br/>
		        						&nbsp;&nbsp;&nbsp; verify Spare
		        			<br/>
		        			<br/>
		        			Verify Phrase - a phrase that is long enough to verify that the page loaded correctly.  (URL option only)
		        			<br/>
		        			Timeout - roughly the delay before the test must return a success or failure.  (not being used by test system currently)
		        		</p>
		        	<h2>
	        			Monitor tests
	        		</h2>
	        			<p>
		        			Clicking on the menu link labeled "Monitor" will run all tests and return all alerts.  There is another menu link labeled "Search" which gives the option to run all tests referring to a machine or run a single test chosen by name.
		        			
		        		</p>
		        	<h2>
	        			Manage tests
	        		</h2>
	        			<p>
		        			Click on the menu link labeled "Manage" to update or delete a test.
		        			
		        		</p>
	        		<h2>
	        			Notes
	        		</h2>
		        		<p>
		        			-All available service calls are documented at:  <a href="/MonitoringService/rest/application.wadl">Service Calls</a>
		        			<br/>
		        			-A key can be obtained by contacting the administrator of the Monitoring Service.
		        			<br/>
		        			-Each test requires a unique name to be registered.  Otherwise an error will occur.
		        			<br/>
		        			-A green alert means a passed test and a red alert means a failed test.
		        			<br/>
		        			<br/>
		        			
		        		</p>
	        	</div>
        	</div>
        </header>