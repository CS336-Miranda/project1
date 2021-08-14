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
<title>Edit Account information</title>
</head>
<body>
<body>
	<form name = "testForm" action = "editaccount.jsp">
	<label>Enter email of account to edit</label><br/>
           <input type="text" name="oldemail"><br/>
            <br>
    <label>Enter new email of account</label><br/>
           <input type="text" name="newemail"><br/>
          <br>
      <label>Enter new password of account</label><br/>
           <input type="text" name="password"><br/>
           <input type="submit">
       
    
	</form>
<%

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	
	String oldemail = request.getParameter("oldemail");
	String newemail = request.getParameter("newemail");
	String password = request.getParameter("password");
	String check = "select count(*) size from users u where u.email = '" + oldemail + "';";
 	Statement stmt = con.createStatement();
	ResultSet result = stmt.executeQuery(check);


	//Make an insert statement for the Sells table:
	String update = "update users u set u.email = '" + newemail + "',u.password = '" + password +"'where u.email = '" + oldemail + "';";
	
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(update);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	
	ps.executeUpdate();

	
	out.print("<br>");
	while(result.next())
	{
	if(!(oldemail.isEmpty()) & result.getString("size").equals("0"))
	{
		out.print("Account does not exist");
	}
	else if(result.getString("size").equals("1"))
	{
		out.print("Account updated successfully");
	}
	}
	

	//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	db.closeConnection(con);

}catch(Exception e){
	
}
%>


</body>
</html>