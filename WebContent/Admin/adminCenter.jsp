<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/adminMaster.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<div class="container">
	  <div class="row">
		    <div class="col-xs-1 col-lg-3">
		         <button id="btnRegisterrep" class="landingPageButton">Create Customer Rep Account</button>
		     </div>
		     
	<script>   
   $.getScript("../js/adminCenter.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	   // this is your callback.
	 });
   </script>
<a href='/BuyMe/Account/logout.jsp'>Log out</a> - Admin Center
</body>
</html>