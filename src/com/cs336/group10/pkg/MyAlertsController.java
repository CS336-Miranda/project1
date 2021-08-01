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
@WebServlet("/MyAlertsAjaxController")
public class MyAlertsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyAlertsController() {
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
		  case "AlertsAll":
			  _alertsAll(request, response);
		    break;
		  default:
		    // code block
		}
	}
		
	private void _alertsAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String email = request.getParameter("email");
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
			
		 	String sqlQuery = "SELECT al.alertId, al.auctionId, a.title, al.date, al.markasread FROM alerts al LEFT OUTER JOIN auctions a on al.auctionId = a.auctionId WHERE al.email=? ORDER BY date DESC;";
			PreparedStatement ps = con.prepareStatement(sqlQuery);
			
			 //Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			 ps.setString(1, email);
			
			 ResultSet resultSet = ps.executeQuery();	 
		    
			 JSONConverter jc = new JSONConverter();
			 String jsonResult = jc.convertToJSON(resultSet);
			
			PrintWriter out = response.getWriter();
	        out.print(jsonResult);
	        db.closeConnection(con);
	    
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		  case "myAlertsMarkAsRead":
			  _myalertsMarkAsRead(request, response);
		    break;
		  default:
		    // code block
		}
	}
	
	private void _myalertsMarkAsRead(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			String alertId = request.getParameter("alertId");

			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
			String update = "update alerts SET markasread = 1 WHERE alertId=?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, Integer.parseInt(alertId));
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
