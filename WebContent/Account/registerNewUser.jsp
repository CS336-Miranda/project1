<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.group10.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@include file="../MasterPages/master.html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form on register.jsp 
		String email = request.getParameter("email");   
    	String pwd = request.getParameter("password");

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO users (email, password, role)"
				+ "VALUES (?,?,'gen')";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, email);
		ps.setString(2, pwd);
		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		db.closeConnection(con);
		//out.print("Registration succeeded <a href='login.jsp'>Return to login.</a>");
        session.setAttribute("user", email); // the username will be stored in the session
        response.sendRedirect("../index.jsp");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Registration failed. <a href='register.jsp'>Try again.</a>");
	}
%>
</body>
</html>