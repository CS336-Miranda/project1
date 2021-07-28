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
@WebServlet("/CreateAuctionAjaxController")
public class CreateAuctionAjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAuctionAjaxController() {
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
		  
		  default:
		    // code block
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
		  case "auctionsAddNew":
			  _auctionsAddNew(request, response);
		    break;
		  default:
		    // code block
		}
	}
	
	private void _auctionsAddNew(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			String title = request.getParameter("title");
			String startTime = request.getParameter("startTime");
			//String itemType = request.getParameter("title");
			String initialPrice = request.getParameter("initialPrice");
			String bidIncrement = request.getParameter("bidIncrement");
			String minPrice = request.getParameter("minPrice");
			String description = request.getParameter("description");
			String owner = request.getParameter("owner");

			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
			String insert = "insert into auctions (title, startTime, initialPrice, bidIncrement, minPrice, description, owner) "
					+ "VALUES (?,?,?,?,?,?,?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, title);
			ps.setString(2, startTime);
			ps.setFloat(3, Float.parseFloat(initialPrice));
			ps.setFloat(4, Float.parseFloat(bidIncrement));
			ps.setFloat(5, Float.parseFloat(minPrice));
			ps.setString(6, description);
			ps.setString(7, owner);
			int result = ps.executeUpdate();
			
			PrintWriter out = response.getWriter();
	        out.print(result);
	        db.closeConnection(con);
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
