package com.cs336.group10.pkg;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;


/**
 * Servlet implementation class AjaxController
 */
@WebServlet("/BiddingAjaxController")
public class BiddingAjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BiddingAjaxController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		switch(request.getParameter("fn")) {
			case "GetAuction":
				_getAuction(request, response);
				break;
			default:
		    // code block
		}
	}
	
	private void _getAuction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
			
		 	int auctionId = Integer.parseInt(request.getParameter("auctionId"));
		 	
		 	String sqlQuery = "SELECT a.auctionId, b.bidId, b.highestBid, b.highBidder, b.upperLimit, b.higherBidAlert, b.highBidderBidIncrement, a.minPrice, a.closeTime, a.startTime, a.title, a.description, a.initialPrice, a.owner, bs.itemId, e.name, e.company, e.year, e.color, l.touch, c.provider, t.size, a.winnerAlerted " + 
		 			"FROM _cs336_buyme.auctions a " +
		 			"JOIN _cs336_buyme.beingSold bs on a.auctionId = bs.auctionId " + 
		 			"JOIN _cs336_buyme.electronics e on e.itemId = bs.itemId " + 
		 			"LEFT OUTER JOIN _cs336_buyme.laptop l on (l.itemId = e.itemId) " + 
		 			"LEFT OUTER JOIN _cs336_buyme.cellphone c on (c.itemId = e.itemId) " + 
		 			"LEFT OUTER JOIN _cs336_buyme.tv t on (t.itemId = e.itemId) " + 
		 			"LEFT OUTER JOIN ( SELECT auctionId, bidId, bidAmount highestBid, email highBidder, upperLimit, bidIncrement highBidderBidIncrement, higherBidAlert FROM bids WHERE auctionId = ? ORDER BY bidId DESC LIMIT 1) b on (a.auctionId = b.auctionId) " +
		 			"WHERE a.auctionId = ?;";
			PreparedStatement ps = con.prepareStatement(sqlQuery);
			
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, auctionId);
			ps.setInt(2, auctionId);
			
			ResultSet resultSet = ps.executeQuery();	 
		    
			JSONConverter jc = new JSONConverter();
			String jsonResult = jc.convertToJSON(resultSet);
			
			PrintWriter out = response.getWriter();
	        out.print(jsonResult);
	        db.closeConnection(con);
	    
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/BuyMe/Member/viewAuctions.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		switch(request.getParameter("fn")) {
		  case "bidAddNew":
			  _bidAddNew(request, response);
		    break;
		  case "bidUpdate":
			  _updateBid(request, response);
			  break;
		  case "bidAlertWinner":
			  _bidAlertWinner(request, response);
			  break;
		  default:
		    // code block
		}
	}
	
	private void _bidAddNew(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			int result = _createBidRecord(request, response, con);
			
			PrintWriter out = response.getWriter();
	        out.print(result);
	        db.closeConnection(con);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private int _createBidRecord(HttpServletRequest request, HttpServletResponse response, java.sql.Connection con) throws ServletException, IOException {
		try {
			
			String bidder = request.getParameter("bidder");
			String auctionId = request.getParameter("auctionId");
			String higherBidAlert = request.getParameter("higherBidAlert");
			String upperLimit = request.getParameter("upperLimit");
			String bidIncrement = request.getParameter("bidIncrement");
			String timeStamp = request.getParameter("timestamp");
			String previousHighBid = request.getParameter("previousHighBid");
			String initialPrice = request.getParameter("initialPrice");
			
			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
	        String sp_setHighBid = "CALL sp_SetHighBid(?,?,?,?,?,?,?,?);";
	        
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(sp_setHighBid);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, bidder);
			ps.setInt(2, Integer.parseInt(auctionId));
			ps.setInt(3, Integer.parseInt(higherBidAlert));
			ps.setFloat(4, Float.parseFloat(upperLimit));
			ps.setFloat(5, Float.parseFloat(bidIncrement));
			ps.setString(6, timeStamp);
			ps.setFloat(7, Float.parseFloat(previousHighBid));
			ps.setFloat(8, Float.parseFloat(initialPrice));
			
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}	
	
	private void _updateBid(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			String bidId = request.getParameter("bidId");
			String higherBidAlert = request.getParameter("higherBidAlert");
			String upperLimit = request.getParameter("upperLimit");
			String bidIncrement = request.getParameter("bidIncrement");

			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
			String update = "UPDATE bids SET upperLimit=?, bidIncrement=?, higherBidAlert=? WHERE bidId=? ";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setFloat(1, Float.parseFloat(upperLimit));
			ps.setFloat(2, Float.parseFloat(bidIncrement));
			ps.setInt(3, Integer.parseInt(higherBidAlert));
			ps.setInt(4,  Integer.parseInt(bidId));
			int result = ps.executeUpdate();
			
			PrintWriter out = response.getWriter();
	        out.print(result);
	        db.closeConnection(con);
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void _bidAlertWinner(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			String auctionId = request.getParameter("auctionId");
			String winner = request.getParameter("winner");
			String timestamp = request.getParameter("timestamp");

			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
			String insertAlert = "INSERT INTO alerts (auctionId, email, date, alertMessage) VALUES (?, ?, ?,?);";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insertAlert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, Integer.parseInt(auctionId));
			ps.setString(2, winner);
			ps.setString(3, timestamp);
			ps.setString(4, "You won! Next step: Pay!");
			int result = ps.executeUpdate();
			
			String updateAuction = "UPDATE auctions SET winnerAlerted = ? WHERE auctionId=?;";
			PreparedStatement ps1 = con.prepareStatement(updateAuction);
			
			ps1.setInt(1, 1);
			ps1.setInt(2, Integer.parseInt(auctionId));
			int result2 = ps1.executeUpdate();
			
			PrintWriter out = response.getWriter();
	        out.print(result2);
	        db.closeConnection(con);
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
