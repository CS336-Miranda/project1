<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/customerRepMaster.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
   <h1>Customer Rep Center</h1>
   <div class="container">
	  <div class="row">
		    <div class="col-xs-1 col-lg-3">
		         <button id="btnRemovebids" class="landingPageButton">Remove Bids</button>
		     </div>
		     <div class="col-xs-1 col-lg-3">
		         <button id="btnDeleteauction" class="landingPageButton">Remove Auctions</button>
		         
		     </div>
		      <div class="col-xs-1 col-lg-3">
		         <button id="btnAnswerquestions" class="landingPageButton">Answer Questions</button>
		         
		         
		     </div>
		   
		       <div class="col-xs-1 col-lg-3">
		         <button id="btnViewaccounts" class="landingPageButton">View Accounts </button>
		      
		     
		</div>
	</div>
	</div>

<script>
$.getScript("../js/customerRepCenter.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	   // this is your callback.
	 });
</script>
</body>


</html>