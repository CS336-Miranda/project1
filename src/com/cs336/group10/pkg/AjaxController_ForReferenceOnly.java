package com.cs336.group10.pkg;

import java.io.IOException;
import java.math.BigInteger;
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
@WebServlet("/AjaxController")
public class AjaxController_ForReferenceOnly extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxController_ForReferenceOnly() {
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
		  case "ListAllUsers":
			  _listAllUsers(request, response);
		    break;
		  
		  default:
		    // code block
		}
	}
	
	private void _listAllUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
			
		 	String sqlQuery = "select * from users;";
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
	
	private void _questionsAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
			
		 	String sqlQuery = "select * from questions;";
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
		  case "questionsAddNew":
			  _questionsAddNew(request, response);
		    break;
		  default:
		    // code block
		}
	}
	
	private void _questionsAddNew(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			String question = request.getParameter("question");
			String email = request.getParameter("email");

			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
			String insert = "insert into questions (question, askTime) "
					+ "VALUES (?,NOW())";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, question);
			int result = ps.executeUpdate();

			//Get Last inserted record id
			String sqlQuery = "select LAST_INSERT_ID() id;";
			ps = con.prepareStatement(sqlQuery);
			ResultSet resultSet = ps.executeQuery();
			
			int lastInsertId = 0;
			while (resultSet.next()) {
				lastInsertId = ((BigInteger) resultSet.getObject("id")).intValue();
			}
			
			insert = "insert into asks (email, questionId) "
					+ "VALUES (?,?)";
			
			ps = con.prepareStatement(insert);
			ps.setString(1, email);
			ps.setNString(2, String.valueOf(lastInsertId));
			result = ps.executeUpdate();
			
			PrintWriter out = response.getWriter();
	        out.print(result);
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
