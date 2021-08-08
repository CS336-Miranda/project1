<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.group10.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/adminMaster.html"%>
<%@include file="../MasterPages/navBar.html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<div class="content">
	<div class="row">
		<div class="col-10">
			<h1>Sales Report</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-10">
			<div id="salesreport"></div>
		</div>
	</div>
<script>   
   $.getScript("../js/salesreport.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	 });
   </script>
</body>
</html>