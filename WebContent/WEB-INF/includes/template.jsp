<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Monitor v1.0</title>
<link href="/MonitoringClient/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<style>
    html { overflow-y: scroll; }
    /* Special class on .container surrounding .navbar, used for positioning it into place. */
    .navbar-wrapper {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      z-index: 10;
      margin-top: 20px;
      margin-bottom: -90px; /* Negative margin to pull up carousel. 90px is roughly margins and height of navbar. */
    }
    .navbar-wrapper .navbar {

    }

    /* Remove border and change up box shadow for more contrast */
    .navbar .navbar-inner {
      border: 0;
      -webkit-box-shadow: 0 2px 10px rgba(0,0,0,.25);
         -moz-box-shadow: 0 2px 10px rgba(0,0,0,.25);
              box-shadow: 0 2px 10px rgba(0,0,0,.25);
    }

    /* Downsize the brand/project name a bit */
    .navbar .brand {
      padding: 14px 20px 16px; /* Increase vertical padding to match navbar links */
      font-size: 16px;
      font-weight: bold;
      text-shadow: 0 -1px 0 rgba(0,0,0,.5);
    }

    /* Navbar links: increase padding for taller navbar */
    .navbar .nav > li > a {
      padding: 15px 20px;
    }

    /* Offset the responsive button for proper vertical alignment */
    .navbar .btn-navbar {
      margin-top: 10px;
    }
    .right {
    	text-align:right;
    }
    .left {
    	text-align:left;
    }
    .content {
    	background-color:white;
    	border-radius:4px;
    	border:1px solid #e5e5e5;
    	
    }
    .background {
    	padding-top:60px;
    	background-color:#f5f5f5;
    }
    .paddedbox{
    	padding-left:10px;
    	padding-right:10px;
    	padding-top:10px;
    	padding-bottom:10px;
    }
    .alert{
    	margin-bottom:5px;
    }
    .centertext{
    	text-align:center;
    }
    .wordwrap { 
	   white-space: pre-wrap;      /* CSS3 */   
	   white-space: -moz-pre-wrap; /* Firefox */    
	   white-space: -pre-wrap;     /* Opera <7 */   
	   white-space: -o-pre-wrap;   /* Opera 7 */    
	   word-wrap: break-word;      /* IE */
	}
	.greenAlert {
		border-color: #71BF78 !important;
		color:#006400 !important;
		background-color:#71BC78 !important;
	}
</style>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="/MonitoringClient/bootstrap/js/bootstrap.min.js"></script>
<script src="/MonitoringClient/js/prettyprint.js"></script>
<script src="/MonitoringClient/js/alerts.js"></script>
<script type="text/javascript">
	function NumberObject() {
		this.value = 0;
	}
	$(document).ready(function(){
		var count = new NumberObject();
		var items = Number('${fn:length(machine)}');
		
		//initiate load icon
		showLoadIcon();
		
		<c:forEach var="machine1" items="${machine}">
			getAlerts('${machine1}', count, items);
		</c:forEach>
	});
</script>
</head>
<body class="background" data-spy="scroll" data-target=".bs-docs-sidebar" data-twttr-rendered="true">

		<!-- place header -->
		<jsp:include page="/WEB-INF/includes/menu.jsp" />

		<div class="container">
		<a id="showHistory" href="#" style="opacity:0.3">[&nbsp;+&nbsp;] Show Service Call History</a><div id="history" style="display:none;">${serviceCall}</div>
		</div>

        <jsp:include page="${body}" /> 
        
        
       <!-- place footer -->
       <jsp:include page="/WEB-INF/includes/footer.jsp" />
       
       <script type="text/javascript">
       		var historyState = false;
       		$element = null;
       		$("#showHistory").click(function(e){
       			if(historyState) {
       				$(this).text("[ + ] Show Service Call History");
       				$("#history").hide();
       				historyState = false;
       			} else {
       				$(this).text("[ - ] Hide Service Call History");
       				$("#history").show();
       				historyState = true;
       			}
       		});
       </script>
</body>
</html>