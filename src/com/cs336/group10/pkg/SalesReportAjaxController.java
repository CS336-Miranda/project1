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
@WebServlet("/SalesReportAjaxController")
public class SalesReportAjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalesReportAjaxController() {
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
			  case "getsalesreport":
				  _getsalesreport(request, response);
			    break;
			  
			  default:
			    // code block
			}
		}


	private void _getsalesreport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
		
			String sqlquery = "select sum(a.minPrice) TotalEarnings from auctions a;";
			PreparedStatement ps = con.prepareStatement(sqlquery);
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
	}

	
	