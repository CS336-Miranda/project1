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
<title>Remove Bids</title>
</head>
<body>
<body>
	<form name = "testForm" action = "removebids.jsp">
	<label>Enter id of bid to delete</label><br/>
           <input type="text" name="bidId"><br/>
           <input type="submit">
	</form>
	<%

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	
	String bidId = request.getParameter("bidId");
	
	String count = "select count(*) size from bids b;";
	Statement stmt = con.createStatement();
	ResultSet result1 = stmt.executeQuery(count);

	


	//Make an insert statement for the Sells table:
	String delete = "DELETE FROM bids WHERE bidId = '" + bidId + "';";
	//out.print(delete);
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(delete);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	
	ps.executeUpdate();
	
	Statement stmt1 = con.createStatement();
	ResultSet result2 = stmt1.executeQuery(count);
	out.print("<br>");
	
	while(result1.next() && result2.next() && !(bidId.isEmpty()))
	{
	
	if(!(result1.getString("size").equals(result2.getString("size"))))
	{
	out.print("bid successfully deleted");
	}
	else
	{
		out.print("bid does not exist");
	}
	}
	//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	db.closeConnection(con);

}catch(Exception e){
	
}
%>
<%
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	 
		Statement stmt = con.createStatement();
		String sqlquery = "SELECT bidId,email,bidAmount,date from bids b;";
		ResultSet result = stmt.executeQuery(sqlquery);
		
		
		out.print("<br><br>");
		out.print("<table>");
		out.print("<tr>");
		
		out.print("<td>");
		
		out.print("bidId");
		out.print("</td>");
		out.print("<td>");
		
		out.print("email");
		out.print("</td>");
		out.print("<td>");
		
		out.print("bidAmount");
		out.print("</td>");
		out.print("<td>");
		out.print("date");
		out.print("</td>");
		;
		out.print("</tr>");
		

	
		while (result.next()) {
		
			out.print("<tr>");
		
			out.print("<td>");
			out.print(result.getString("bidId"));
			
			out.print("</td>");
			
			out.print("<td>");
			
			out.print(result.getString("email"));
			out.print("</td>");
			out.print("<td>");
			out.print("$" + result.getString("bidAmount"));
			out.print("</td>");
			out.print("<td>");
		
	
			out.print(result.getString("date"));
			
			out.print("</td>");
			
			out.print("</tr>");

		}
		out.print("</table>");
		con.close();
	}catch(Exception e){
}
%>
</body>
</html>