<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="com.cs336.group10.pkg.*"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Scanner" %>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/customerRepMaster.html"%>
<%@include file="../MasterPages/navBar.html"%>
<%@ page import= "java.time.format.DateTimeFormatter" %>
<%@ page import = "java.time.LocalDateTime" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer Questions</title>
</head>
<body>
<form name = "testForm" action = "answerquestions.jsp">
	<label>Enter questionId </label><br/>
           <input type="text" name="questionId"><br/>
          
           <br>
    <label>Enter question answer</label><br/>
           <input type="text" name="answer"><br/>
       		 <input type="submit">
	</form>

	<%
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String questionId = request.getParameter("questionId");
		String answer = request.getParameter("answer");
		String email = session.getAttribute("user").toString();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		   LocalDateTime now = LocalDateTime.now();
		   String s= dtf.format(now);
	
		
		//String password = request.getParameter("password");
		String check = "select count(*) size from questions q where questionId = '" + questionId + "';";
	
	 	Statement stmt = con.createStatement();
		ResultSet result = stmt.executeQuery(check);


		//Make an insert statement for the Sells table:
		String update = "update questions q set q.answer = '" + answer + "',q.repEmail = '" + email +"',q.answerTime = '" + s + "' where q.questionId = '" + questionId + "';";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(update);

		
		
		ps.executeUpdate();

		
		out.print("<br>");
		while(result.next())
		{
			
		if(!(questionId.isEmpty()) & result.getString("size").equals("0"))
		{
			out.print("Question does not exist");
		}
		else if(result.getString("size").equals("1"))
		{
			out.print("Question answered");
		}
		}
		

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		db.closeConnection(con);

	}catch(Exception e){
		
	}
	%>
		<br><br>
<%
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		Statement stmt = con.createStatement();
		String sqlquery = "SELECT questionId,question,askTime,email FROM questions q where answer is null;";
	
		ResultSet result = stmt.executeQuery(sqlquery);
		
		
		
		out.print("<table>");
		out.print("<tr>");
		
		out.print("<td>");
		
		out.print("questionId");
		out.print("</td>");
		out.print("<td>");
		
		out.print("question");
		out.print("</td>");
		out.print("<td>");
		
		out.print("asktime");
		out.print("</td>");
		out.print("<td>");
		out.print("useremail");
		out.print("</td>");

		out.print("</tr>");
		

	
		while (result.next()) {
		
			out.print("<tr>");
		
			out.print("<td>");
			
			out.print(result.getString("questionId"));
			
			out.print("</td>");
			
			out.print("<td>");
			
			out.print(result.getString("question"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("askTime"));
			out.print("</td>");
			out.print("<td>");
		
	
			out.print(result.getString("email"));
			
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