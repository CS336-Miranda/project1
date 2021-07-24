<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="MasterFiles/master.html"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
   <%
try{
	String sessionUser = session.getAttribute("user").toString();%>
	Welcome <%=sessionUser%>
	<a href='Account/logout.jsp'>Log out</a> - View Auctions
<%
}catch(Exception e){
	response.sendRedirect("Account/login.jsp");
}

%>
</body>
</html>