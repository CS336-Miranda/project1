<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@include file="MasterPages/master.html"%>

<html>
   <head>
   </head>
   <body>
<%
try{
	String sessionUser = session.getAttribute("user").toString();
	response.sendRedirect("/BuyMe/Member/home.jsp");
}catch(Exception e){
	response.sendRedirect("/BuyMe/Account/login.jsp");
}
%>

   </body>
</html>