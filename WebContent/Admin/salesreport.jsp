<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.group10.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/adminMaster.html"%>
<%@include file="../MasterPages/navBar.html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>

<div class="content">
	<div class="row">
		<div class="col-10">
			<h1>Sales Report</h1>
		</div>
	</div>
	
	<%
	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String sqlquery =  "select sum(maxbid) TotalEarnings from (select max(b.bidAmount) maxbid, b.auctionId from  bids b  group by b.auctionId) t1 join auctions a using(auctionId) where a.winnerAlerted = '1' and maxbid >= minPrice;";
		ResultSet result = stmt.executeQuery(sqlquery);
		out.print("Total Earnings: ");


		
		while (result.next()) {
		
			out.print("$"+ result.getString("TotalEarnings"));
			

		}
		
		out.print("<br><br>");
		//Earnings per item
		sqlquery = "select title,max(b.bidAmount) earningsperitem from  bids b join auctions a using(auctionId)" +
				"where winnerAlerted = '1' and bidAmount >= minPrice group by b.auctionId;";
		result = stmt.executeQuery(sqlquery);
		
		out.print("<table>");
		out.print("<tr>");
		
		out.print("<td>");
		
		out.print("item");
		out.print("</td>");
		out.print("<td>");
		
		out.print("Earnings per item");
		out.print("</td>");
		
	
		out.print("</tr>");

	
		while (result.next()) {
			
			out.print("<tr>");
		
			out.print("<td>");
			
			out.print(result.getString("title"));
			out.print("</td>");
			
			out.print("<td>");
			
			out.print("$" + result.getString("earningsperitem"));
			out.print("</td>");
		
			out.print("</tr>");

		}
		out.print("</table>");
		out.print("<br>");
		//Earnings from laptops
		sqlquery = "select if(count(*) >0,sum(bidperlaptop),0) earningsfromlaptops from (select max(bidAmount) bidperlaptop from auctions a join bids using(auctionId) join beingSold using(auctionId) join laptop using(itemId) where bidAmount >= minPrice and winnerAlerted ='1' group by itemId)t1;";
        
		result = stmt.executeQuery(sqlquery);
		out.print("Earnings from laptops: ");
		while (result.next()) {
			
			out.print("$" + result.getString("earningsfromlaptops"));
			

		}
		out.print("<br>");
		//Earnings from TVs
		sqlquery = "select if(count(*) >0,sum(bidpertv),0) earningsfromtv from (select max(bidAmount) bidpertv from auctions a join bids using(auctionId) join beingSold using(auctionId) join tv using(itemId) where bidAmount >= minPrice and winnerAlerted ='1' group by itemId)t1;";
		result = stmt.executeQuery(sqlquery);
		out.print("Earnings from TVs: ");
		while (result.next()) {
			
			out.print("$" + result.getString("earningsfromtv"));
			

		}
		out.print("<br>");
		//Earnings from cellphones
		sqlquery = "select if(count(*) >0,sum(bidperphone),0) earningsfromphone from (select max(bidAmount) bidperphone from auctions a join bids using(auctionId) join beingSold using(auctionId) join cellphone using(itemId) where bidAmount >= minPrice and winnerAlerted ='1' group by itemId)t1;";
		result = stmt.executeQuery(sqlquery);
		out.print("Earnings from Cellphones: ");
		while (result.next()) {
			
			out.print("$" + result.getString("earningsfromphone"));
			

		}
        //Earnings per user
        out.print("<br><br>");
        sqlquery = "select owner, sum(earnings) earningsperuser from(SELECT max(bidAmount) earnings,owner" +
        		" from auctions a join bids b using(auctionId)where bidAmount >= minPrice and winnerAlerted = '1' group by auctionId) t1 group by owner;";
        		result = stmt.executeQuery(sqlquery);
        		
        		out.print("<table>");
        		out.print("<tr>");
        		
        		out.print("<td>");
        	
        		out.print("User Email");
        		out.print("</td>");
        		out.print("<td>");
        		
        		out.print("Total Earnings per user");
        		out.print("</td>");
        		
        	
        		out.print("</tr>");

        		
        		while (result.next()) {
        		
        			out.print("<tr>");
        			
        			out.print("<td>");
        			
        			out.print(result.getString("owner"));
        			out.print("</td>");
        			
        			out.print("<td>");
        			
        			out.print("$" + result.getString("earningsperuser"));
        			out.print("</td>");
        		
        			out.print("</tr>");

        		}
        		out.print("</table>");	
        		//Best selling items
        		out.print("<br>");
        		sqlquery = "select title from(select title,count(*) sellers from auctions a join bids b using(auctionId) where winnerAlerted = '1' and auctionId in "
        				+ "(select auctionId from bids b join auctions a using(auctionId) where bidAmount>= minPrice) group by auctionId) t1 where sellers in "
        		+ "(select max(sellers) from (select title,count(*) sellers from auctions a join bids b using(auctionId) where winnerAlerted = '1' and auctionId in "
        		+ "(select auctionId from bids b join auctions a using(auctionId) where bidAmount>= minPrice) group by auctionId) t1)";
        		result = stmt.executeQuery(sqlquery);
        		out.print("Best Selling item(s): ");
        		while (result.next()) {
        			
        			out.print(result.getString("title"));
        			
					if(!result.isLast())
					{
						out.print(",");
					
        		}
        		}
        	// Best Buyers
        	out.print("<br>");
        	sqlquery = "select email from(select email,count(*) wins from alerts a where a.alertMessage = 'You won! Next step: Pay!' group by email) t1 " +
        			"where wins in( select max(wins) from(select email,count(*) wins from alerts a where a.alertMessage = 'You won! Next step: Pay!' group by email) t1);";
        			result = stmt.executeQuery(sqlquery);
            		out.print("Best Buyer(s): ");
            		while (result.next()) {
            			
            			out.print(result.getString("email"));
            			
    					if(!result.isLast())
    					{
    						out.print(",");
    					
            		}
            		}
		con.close();
		
		
        		}catch(Exception e){
		
	}
	
	%>


</body>
</html>