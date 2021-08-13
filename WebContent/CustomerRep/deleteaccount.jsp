<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="com.cs336.group10.pkg.*"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/customerRepMaster.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

</head>
<body>
	<form name = "testForm" action = "deleteaccount.jsp">
	<label>Enter email of account to delete</label><br/>
           <input type="text" name="email"><br/>
           <input type="submit">
	</form>
<%

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	
	String email = request.getParameter("email");
	
	String count = "select count(*) size from users u;";
	Statement stmt = con.createStatement();
	ResultSet result1 = stmt.executeQuery(count);



	//Make an insert statement for the Sells table:
	String delete = "DELETE FROM users WHERE email = '" + email + "';";
	
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(delete);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	
	ps.executeUpdate();
	
	Statement stmt1 = con.createStatement();
	ResultSet result2 = stmt1.executeQuery(count);
	out.print("<br>");
	
	while(result1.next() && result2.next() && !(email.isEmpty()))
	{
	
	if(!(result1.getString("size").equals(result2.getString("size"))))
	{
	out.print("Account successfully deleted");
	}
	else
	{
		out.print("Account does not exist");
	}
	}
	//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	db.closeConnection(con);

}catch(Exception e){
	
}
%>

</body>
</html>