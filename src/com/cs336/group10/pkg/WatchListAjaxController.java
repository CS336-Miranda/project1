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
@WebServlet("/WatchListAjaxController")
public class WatchListAjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WatchListAjaxController() {
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
		  case "GetWatchList":
			  _getWatchList(request, response);
		    break;
		  default:
		    // code block
		}
	}
		
	private void _getWatchList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
			
		 	String email = request.getParameter("email");
		 	
		 	String sqlQuery = "SELECT w.keywords, w.email, w.watchId FROM watchList w WHERE email = '" + email + "'";
			PreparedStatement ps = con.prepareStatement(sqlQuery);
			
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
		  case "PostItem":
			  _watchItemAdd(request, response);
		    break;
		  default:
		    // code block
		}
	}
	
	private void _watchItemAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			String email = request.getParameter("email");
			String keyword = request.getParameter("keyword");

			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
			String insert = "INSERT INTO watchList(keywords, email) " +
							"VALUES ('" + keyword +"','" + email + "')";

			PreparedStatement ps = con.prepareStatement(insert);
			
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
