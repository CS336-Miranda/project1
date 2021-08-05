package com.cs336.group10.pkg;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;


/**
 * Servlet implementation class AjaxController
 */
@WebServlet("/ViewAuctionsAjaxController")
public class ViewAuctionsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewAuctionsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		switch(request.getParameter("fn")) {
		  case "AuctionsAll":
			  _auctionsAll(request, response);
			  break;
		  case "UserAuctions":
			  _userAuctions(request, response);
			  break;
		  default:
		    // code block
		}
	}
		
	private void _auctionsAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
			
		 	String sqlQuery = "SELECT a.auctionId, a.closeTime, a.startTime, a.title, a.description, IF(highestBid.highest IS NULL,0,highestBid.highest) highest " +
		 			"FROM ((((auctions a "+
		    		"LEFT OUTER JOIN beingSold b ON a.auctionId = b.auctionId) "+
		    		"LEFT OUTER JOIN electronics e ON b.itemId = e.itemId) "+
		    		"LEFT OUTER JOIN cellphone c ON e.itemId = c.itemId) "+ 
		    		"LEFT OUTER JOIN (SELECT auctionId, max(bidAmount) highest " + 
		    		"FROM bids b "+ 
		    		"GROUP BY b.auctionId) highestBid "+
		    		"ON highestBid.auctionId = a.auctionId)";
		 	
			PreparedStatement ps = con.prepareStatement(sqlQuery);
			
			ResultSet rs = ps.executeQuery();	 
		    
			JSONConverter jc = new JSONConverter();
			String jsonResult = jc.convertToJSON(rs);
			
			PrintWriter out = response.getWriter();
	        out.print(jsonResult);
	        db.closeConnection(con);
	    
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void _userAuctions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String email = request.getParameter("email");
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
			
		 	String sqlQuery = "SELECT a.auctionId, a.closeTime, a.startTime, a.title, a.description " + 
		 			"FROM auctions a " + 
		 			"WHERE a.owner = '"+ email +"' " + 
		 			"UNION " + 
		 			"SELECT a.auctionId, a.closeTime, a.startTime, a.title, a.description " + 
		 			"FROM auctions a JOIN bids b USING(auctionId) " + 
		 			"WHERE b.email = '" + email +"'";
		 	
			PreparedStatement ps = con.prepareStatement(sqlQuery);
			
			ResultSet rs = ps.executeQuery();	 
		    
			JSONConverter jc = new JSONConverter();
			String jsonResult = jc.convertToJSON(rs);
			
			PrintWriter out = response.getWriter();
	        out.print(jsonResult);
	        db.closeConnection(con);
	    
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


}
