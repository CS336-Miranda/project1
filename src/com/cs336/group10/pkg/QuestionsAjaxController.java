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
@WebServlet("/QuestionsAjaxController")
public class QuestionsAjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionsAjaxController() {
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
		  case "QuestionsAll":
			  _questionsAll(request, response);
		    break;
		  case "QuestionsBy":
			  _questionsBy(request, response);
		    break;
		  default:
		    // code block
		}
	}
		
	private void _questionsAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
			
		 	String sqlQuery = "SELECT * FROM questions ;";
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
	
	private void _questionsBy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String criteria = request.getParameter("val");
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
		 	Connection con = db.getConnection();
		 	
		 	String sqlQuery = "SELECT * FROM questions " +
		 					"WHERE question LIKE '%" + criteria + "%' OR " +
		 					" answer LIKE '%" + criteria + "%'";
		 					
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
			String timestamp = request.getParameter("timestamp");

			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
	        
			String insert = "insert into questions (question, askTime, email) "
					+ "VALUES (?,?,?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, question);
			ps.setString(2, timestamp);
			ps.setString(3, email);
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
