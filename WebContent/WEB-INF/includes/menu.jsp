<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
	<!-- menu -->
	<div class="container">

        <div class="navbar navbar-inverse navbar-fixed-top">
          <div class="navbar-inner">
          	<div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="brand" href="/MonitoringClient/client/about">Monitor v1.0</a>
            <div class="nav-collapse collapse">
              <ul class="nav">
              	<li ><a href="/MonitoringClient/login">Login</a></li>
              	<li ><a href="/MonitoringClient/client/register">Register</a></li>
                <li ><a href="/MonitoringClient/client/monitor">Monitor</a></li>
                <li ><a href="/MonitoringClient/client/search">Search</a></li>
                <li ><a href="/MonitoringClient/client/manage">Manage</a></li>
              </ul>
            </div><!--/.nav-collapse -->
            </div>
          </div><!-- /.navbar-inner -->
        </div><!-- /.navbar -->
        
	</div>