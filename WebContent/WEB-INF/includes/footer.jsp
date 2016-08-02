<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>       
      <!-- footer -->
      <div class="navbar navbar-fixed-bottom">
	      <br/>
	      <div class="container content" style="opacity:0.5">
	      		<div class="paddedbox centertext">
	      			&copy;&nbsp;Monitor v1.0
	      		</div>
	      </div>
      </div>