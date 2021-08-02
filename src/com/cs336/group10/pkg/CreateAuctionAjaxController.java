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

			int result = _createAuctionsItem(request, response, con);
			
			if(result == 0) { return; }
			int insertedAuctionId = _getLastInsertedId(request, response, con);
			int electronicsResult = _insertElectronicsItem(request, response, con);
			int insertedElectronicsId = _getLastInsertedId(request, response, con);
			int subcategoryResult = _insertSubCategoryItem(request, response, con, insertedElectronicsId);
			int beingSoldResult = _insertBeingSoldItem(request, response, con, insertedAuctionId, insertedElectronicsId);
			
			PrintWriter out = response.getWriter();
	        out.print(insertedElectronicsId);
	        db.closeConnection(con);
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private int _createAuctionsItem(HttpServletRequest request, HttpServletResponse response, java.sql.Connection con) throws ServletException, IOException {
		try {
			String title = request.getParameter("title");
			String startTime = request.getParameter("startTime");
			String initialPrice = request.getParameter("initialPrice");
			String minPrice = request.getParameter("minPrice");
			String description = request.getParameter("description");
			String owner = request.getParameter("owner");
			String closeTime = request.getParameter("closeTime");

			response.setContentType("text/json");
	        response.setCharacterEncoding("UTF-8");
	        
			String insert = "insert into auctions (title, startTime, initialPrice, minPrice, description, owner, closeTime) "
					+ "VALUES (?,?,?,?,?,?,?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, title);
			ps.setString(2, startTime);
			ps.setFloat(3, Float.parseFloat(initialPrice));
			ps.setFloat(4, Float.parseFloat(minPrice));
			ps.setString(5, description);
			ps.setString(6, owner);
			ps.setString(7, closeTime);
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}
	
	private int _getLastInsertedId(HttpServletRequest request, HttpServletResponse response, java.sql.Connection con) throws ServletException, IOException {
		try {
			//Get Last inserted record id
			String sqlQuery = "select LAST_INSERT_ID() id;";
			PreparedStatement ps = con.prepareStatement(sqlQuery);
			ResultSet resultSet = ps.executeQuery();
			
			int lastInsertId = 0;
			while (resultSet.next()) {
				lastInsertId = ((BigInteger) resultSet.getObject("id")).intValue();
			}
			return lastInsertId;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}		

	private int _insertElectronicsItem(HttpServletRequest request, HttpServletResponse response, java.sql.Connection con) throws ServletException, IOException {
		try {
			String name = request.getParameter("name");
			String company = request.getParameter("company");
			String year = request.getParameter("year");
			String color = request.getParameter("color");
			
			String insert = "insert into electronics (name, company, year, color) "
					+ "VALUES (?,?,?,?)";
			
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, name);
			ps.setString(2, company);
			ps.setString(3, year);
			ps.setString(4, color);
			//ps.setNString(2, String.valueOf(lastInsertId));
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}
	
	private int _insertSubCategoryItem(HttpServletRequest request, HttpServletResponse response, java.sql.Connection con, int itemId) throws ServletException, IOException {
		try {
			String subcategory = request.getParameter("subcategory");
			String laptopTouchscreen = request.getParameter("laptopTouchscreen");
			String cellphoneProvider = request.getParameter("cellphoneProvider");
			String tvSize = request.getParameter("tvSize");
			
			String insert = "";
			PreparedStatement ps = con.prepareStatement(insert);

			if(subcategory.equals("laptop")) {
				insert = "insert into laptop (itemId, touch) "
						+ "VALUES (?,?)";
				ps = con.prepareStatement(insert);
				ps.setInt(1, itemId);
				ps.setString(2, laptopTouchscreen);
			}else if(subcategory.equals("cellphone")) {
				insert = "insert into cellphone (itemId, provider) "
						+ "VALUES (?,?)";
				ps = con.prepareStatement(insert);
				ps.setInt(1, itemId);
				ps.setString(2, cellphoneProvider);
			}else if(subcategory.equals("tv")) {
				insert = "insert into tv (itemId, size) "
						+ "VALUES (?,?)";
				ps = con.prepareStatement(insert);
				ps.setInt(1, itemId);
				ps.setString(2, tvSize);
			}

			//ps.setNString(2, String.valueOf(lastInsertId));
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}

	private int _insertBeingSoldItem(HttpServletRequest request, HttpServletResponse response, java.sql.Connection con, int auctionId, int itemId) throws ServletException, IOException {
		try {
						
			String insert = "insert into beingSold (auctionId, itemId) "
					+ "VALUES (?,?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, auctionId);
			ps.setInt(2, itemId);
		

			//ps.setNString(2, String.valueOf(lastInsertId));
			int result = ps.executeUpdate();
			return result;
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}
	
}
