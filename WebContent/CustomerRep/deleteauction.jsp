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
<title>Remove Auctions</title>
</head>
<body>
	<form name = "testForm" action = "deleteauction.jsp">
	<label>Enter id of auction to delete</label><br/>
           <input type="text" name="auctionId"><br/>
           <input type="submit">
	</form>
	<%

try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	
	String auctionId = request.getParameter("auctionId");
	
	String count = "select count(*) size from auctions a;";
	Statement stmt = con.createStatement();
	ResultSet result1 = stmt.executeQuery(count);

	


	//Make an insert statement for the Sells table:
	String delete = "DELETE FROM auctions WHERE auctionId = '" + auctionId + "';";
	//out.print(delete);
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(delete);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	
	ps.executeUpdate();
	
	Statement stmt1 = con.createStatement();
	ResultSet result2 = stmt1.executeQuery(count);
	out.print("<br>");
	
	while(result1.next() && result2.next() && !(auctionId.isEmpty()))
	{
	
	if(!(result1.getString("size").equals(result2.getString("size"))))
	{
	out.print("Auction successfully deleted");
	}
	else
	{
		out.print("Auction does not exist");
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
		String sqlquery = "SELECT auctionId,title,description,closeTime,owner FROM auctions a";
		ResultSet result = stmt.executeQuery(sqlquery);
		
		
		out.print("<br><br>");
		out.print("<table>");
		out.print("<tr>");
		
		out.print("<td>");
		
		out.print("auctionId");
		out.print("</td>");
		out.print("<td>");
		
		out.print("item");
		out.print("</td>");
		out.print("<td>");
		
		out.print("description");
		out.print("</td>");
		out.print("<td>");
		out.print("close time");
		out.print("</td>");
		
		out.print("<td>");
		out.print("owner");
		out.print("</td>");
		out.print("</tr>");
		

	
		while (result.next()) {
		
			out.print("<tr>");
		
			out.print("<td>");
			out.print(result.getString("auctionId"));
			
			out.print("</td>");
			
			out.print("<td>");
			
			out.print(result.getString("title"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("description"));
			out.print("</td>");
			out.print("<td>");
		
	
			out.print(result.getString("closeTime"));
			
			out.print("</td>");
			out.print("<td>");
	  
			
			out.print(result.getString("owner"));
			
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