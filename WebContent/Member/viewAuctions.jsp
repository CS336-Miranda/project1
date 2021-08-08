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
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

</head>
<body>
<div class="content">
	<div class="row">
		<div class="col-10">
			<h1>View Auctions</h1>
		</div>
	</div>
	
	<div class="row">
		<div class="col-2">
			<div class="input-group mb-3">
			  <input type="text" class="form-control" id="userEmail" placeholder="Enter user's email...">
			  <button class="btn btn-outline-secondary" type="button" id="email-filter">Search</button>
			</div>
		</div>
		
		<div class="col-2">
			<div class="input-group">
			  <select class="form-select" id="inputGroupSelect04" aria-label="Example select with button addon">
			    <option selected>Sort By...</option>
			    <option value="1">Title</option>
			    <option value="2">Bid</option>
			    <option value="3">Date</option>
			  </select>
			  <button class="btn btn-outline-secondary" type="button" id="sorting">Sort</button>
			</div>
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