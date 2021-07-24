<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@include file="MasterFiles/master.html"%>

<html>
   <head>
   
   </head>
   
   <body>
   <%
try{
	String sessionUser = session.getAttribute("user").toString();%>
	Welcome <%=sessionUser%>
	<a href='Account/logout.jsp'>Log out</a>
<%
}catch(Exception e){
	response.sendRedirect("Account/login.jsp");
}

%>
   
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
		</div>
   </div>
   
   
   <script>   
   $.getScript("js/index.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	   // this is your callback.
	 });
   </script>
   

   </body>
</html>