<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/member.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<div class="content">
	<div class="row">
		<div class="col-10">
			<h1>My Alerts</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-10">
			<div id="grdAlerts"></div>
		</div>
	</div>
</div>

   <script>   
   $.getScript("../js/myalerts.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	 });
   </script>
</body>
</html>