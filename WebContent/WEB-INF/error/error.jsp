<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        
        <header class="jumbotron subhead">
        	<div class="container">
        		<h1>
        			Error
        		</h1>
        	</div>
        </header>
        
        <br/>
        
        <div class="container content">
        	<div class="paddedbox">
        		<h2>
        			${errormessage}
        		</h2>
        	</div>
        </div>