<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@include file="/master.html"%>

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
   </body>
</html>