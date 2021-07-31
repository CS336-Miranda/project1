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
			/*case "GetHighBid":
				_getHighBid(request, response);
				break;*/
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
		 	
		 	String sqlQuery = "SELECT a.auctionId, b.highestBid, b.email, a.minPrice, a.closeTime, a.startTime, a.title, a.description, a.bidIncrement, a.initialPrice, a.owner, bs.itemId, e.name, e.company, e.year, e.color, l.touch, c.provider, t.size " + 
		 			"FROM _cs336_buyme.auctions a " +
		 			"JOIN _cs336_buyme.beingSold bs on a.auctionId = bs.auctionId " + 
		 			"JOIN _cs336_buyme.electronics e on e.itemId = bs.itemId " + 
		 			"LEFT OUTER JOIN _cs336_buyme.laptop l on (l.itemId = e.itemId) " + 
		 			"LEFT OUTER JOIN _cs336_buyme.cellphone c on (c.itemId = e.itemId) " + 
		 			"LEFT OUTER JOIN _cs336_buyme.tv t on (t.itemId = e.itemId) " + 
		 			"LEFT OUTER JOIN ( SELECT auctionId, bidAmount highestBid, email FROM bids ORDER BY bidId DESC LIMIT 1) b on (a.auctionId = b.auctionId) " +
		 			"WHERE a.auctionId = ?;";
			PreparedStatement ps = con.prepareStatement(sqlQuery);
			
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, auctionId);
			
			ResultSet resultSet = ps.executeQuery();	 
		    
			JSONConverter jc = new JSONConverter();
			String jsonResult = jc.convertToJSON(resultSet);
			
			PrintWriter out = response.getWriter();
	        out.print(jsonResult);
	        db.closeConnection(con);
	    
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private ResultSet _getHighBid(HttpServletRequest request, HttpServletResponse response, java.sql.Connection con) throws ServletException, IOException {
		try {
			//Get the database connection
			//ApplicationDB db = new ApplicationDB();	
		 	//Connection con = db.getConnection();
			
		 	int auctionId = Integer.parseInt(request.getParameter("auctionId"));
		 	String bidder = request.getParameter("bidder");
		 	
		 	String sqlQuery = "SELECT Max(b.upperLimit) upperLimit, b.bidIncrement, b.email FROM _cs336_buyme.bids b WHERE b.auctionId = ? AND b.email <> ?;";
			PreparedStatement ps = con.prepareStatement(sqlQuery);
			
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, auctionId);
			ps.setString(2, bidder);
			
			return ps.executeQuery();	 
		    
			/*JSONConverter jc = new JSONConverter();
			String jsonResult = jc.convertToJSON(resultSet);
			
			PrintWriter out = response.getWriter();
	        out.print(jsonResult);
	        db.closeConnection(con);*/
	    
		} catch (Exception e) {
			e.printStackTrace();
			return null;
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
			
			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
	        String sp_setHighBid = "CALL sp_SetHighBid(?,?,?,?,?,?,?);";
	        
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
			
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}	
	
	private int _updateHighBidOnAuction(HttpServletRequest request, HttpServletResponse response, java.sql.Connection con) throws ServletException, IOException {
		try {
			
			String bidder = request.getParameter("bidder");
			String auctionId = request.getParameter("auctionId");
			Float upperLimit = Float.parseFloat(request.getParameter("upperLimit"));
			Float bidIncrement = Float.parseFloat(request.getParameter("bidIncrement"));
			Float previousHighBid = Float.parseFloat(request.getParameter("previousHighBid"));
			
			Float newHighBid = previousHighBid + bidIncrement;
			if(newHighBid > upperLimit) {
				newHighBid = upperLimit;
			}
			
			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
			String insert = "UPDATE auctions SET highestBid = ?, highestBidder = ? WHERE auctionId = ?;";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setFloat(1, newHighBid);
			ps.setString(2, bidder);
			ps.setInt(3, Integer.parseInt(auctionId));
			
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}	
}
