<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.group10.pkg.*"%>
<%@include file="/master.html"%>
<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    
  //Get the database connection
	ApplicationDB db = new ApplicationDB();	
 	Connection con = db.getConnection();

 	//Create a SQL statement
 	Statement st = con.createStatement();
    
    ResultSet rs;
    rs = st.executeQuery("select * from users where email='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        response.sendRedirect("../index.jsp");
    } else {
        out.println("Invalid password <a href='login.jsp'>try again</a>");
    }
%>