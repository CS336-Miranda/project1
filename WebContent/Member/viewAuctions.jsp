<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.group10.pkg.*"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/member.html"%>
<%@include file="../MasterPages/navBar.html"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<div class="content">
	<div class="row">
		<div class="col-10">
			<h1>View Auctions</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-10">
			<div id="auctions"></div>
		</div>
	</div>
</div>

   <script>   
   $.getScript("../js/viewAuctions.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	 });
   </script>
</body>
</html>