<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%
session.invalidate();
try{
	session.getAttribute("user");
}catch(Exception e){
	response.sendRedirect("login.jsp");
}

%>