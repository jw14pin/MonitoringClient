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
        			Authentication
        		</h1>
        	</div>
        </header>
        
        <div class="container">
        
	        <br/>
	        
	        <form id="login" name="login" method="POST">
		        
		        	<input id="username" name="username" type="text" class="input-block-level" placeholder="Username">
		        
			        <input id="password" name="password" type="password" class="input-block-level" placeholder="Password">
			        
			        <br/>
			        <br/>
			        
			        <button class="btn btn-large btn-primary" type="submit">Login</button>
		        
		    </form>
	        
	        <br/>
	        
	        <script type="text/javascript">

	        </script>
        
        </div>