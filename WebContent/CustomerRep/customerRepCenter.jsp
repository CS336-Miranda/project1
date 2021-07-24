<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="/master.html"%>

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

	if(!sessionUserRole.trim().equals("rep")){
		throw new Exception("This page requires customer representative permissions.");
	}
	%>
	Welcome <%=sessionUser%>
	<a href='/BuyMe/Account/logout.jsp'>Log out</a> - Customer Rep Center
	<%
	
	
}catch(Exception e){
	response.sendRedirect("/BuyMe/Account/login.jsp");
}

%>
</body>
</html>