<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterFiles/master.html"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
   <%
try{
	String sessionUser = session.getAttribute("user").toString();
	String sessionUserRole = session.getAttribute("role").toString();

	if(!sessionUserRole.trim().equals("admin")){
		throw new Exception("This page requires admin permissions.");
	}
	%>
	Welcome <%=sessionUser%>
	<a href='/BuyMe/Account/logout.jsp'>Log out</a> - Admin Center
	<%
	
	
}catch(Exception e){
	response.sendRedirect("/BuyMe/Account/login.jsp");
}

%>
</body>
</html>