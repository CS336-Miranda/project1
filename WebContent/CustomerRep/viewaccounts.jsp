<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="com.cs336.group10.pkg.*"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Scanner" %>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/customerRepMaster.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Account(s)</title>
</head>
<body>
<div class="container">
	  <div class="row">
		    <div class="col-xs-1 col-lg-3">
				<button id="btnDeleteaccount" class="landingPageButton">Delete An Account</button>
				</div>
				  <div class="col-xs-1 col-lg-3">
		         <button id="" class="landingPageButton">Edit Account Information</button>
		         
		      </div>
				</div>
				</div>
	
<%
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		Statement stmt = con.createStatement();
		String sqlquery = "select email, password,role from users u";
	
		ResultSet result = stmt.executeQuery(sqlquery);
		
		
		
		out.print("<table>");
		out.print("<tr>");
		
		out.print("<td>");
		
		out.print("email");
		out.print("</td>");
		out.print("<td>");
		
		out.print("password");
		out.print("</td>");
		out.print("<td>");
		
		out.print("role");
		out.print("</td>");
		out.print("<td>");
		out.print(" ");
		out.print("</td>");

		out.print("</tr>");
		

	
		while (result.next()) {
		
			out.print("<tr>");
		
			out.print("<td>");
			String e = result.getString("email");
			out.print(e);
			
			out.print("</td>");
			
			out.print("<td>");
			
			out.print(result.getString("password"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("role"));
			out.print("</td>");
			out.print("<td>");
		
	
		
			
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");
		con.close();
	}catch(Exception e){
}
%>
<script>


$(document).ready(function(){
	
		
		
		InitializeEventHandlers();

});


function InitializeEventHandlers(){
	$('#btnDeleteaccount').on('click', function(e){
		e.preventDefault();
		window.location.href='../CustomerRep/deleteaccount.jsp';
		
	});
	
}

</script>
</body>
</html>