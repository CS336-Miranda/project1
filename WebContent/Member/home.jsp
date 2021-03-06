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
<div class="container">
	  <div class="row">
		    <div class="col-xs-1 col-lg-3">
		         <button id="btnCreateAuction" class="landingPageButton">Create Auction</button>
		    </div>
		    <div class="col-xs-1 col-lg-3">
		     	<button id="btnViewAuctions" class="landingPageButton">View Auctions</button>
		    </div>
		    <div class="col-xs-1 col-lg-3">
		         <button id="btnQuestions" class="landingPageButton">Questions</button>
		    </div>
	   </div>
	   <div class="row">
	   <div class="col-xs-1 col-lg-3 adminsOnly">
		    	<button id="btnAdminCenter" class="landingPageButton">Admin Center</button>
		    </div>
		    <div class="col-xs-1 col-lg-3 customerRepsOnly">
		    	<button id="btnCustomerRepCenter" class="landingPageButton">Customer Rep Center</button>
		    </div>
		    <div class="col-xs-1 col-lg-3">
		         <button id="btnWatchList" class="landingPageButton">Watch List</button>
		    </div>
		</div>
   </div>
   
   
   <script>   
   $.getScript("../js/home.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	 });
   </script>

</body>
</html>