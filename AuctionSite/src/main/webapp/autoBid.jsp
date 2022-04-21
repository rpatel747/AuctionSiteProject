<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- This page is used to check if a user with the given credentials exists, if they do
	 then they will be logged in. Otherwise an error we will be reported. -->
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">		
		
	</head>
	
	
	<body>
		<%
		
		
		

		  	
		  	
		  	
 		try {
			
 			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			

			String customerEmail = (String) session.getAttribute("customerEmail");
			
			
			// Get todays date:
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  	String todaysDateTime = sdf.format(new Date());		
			
		  	
		  	// Get the all the bids for the current user
		  	PreparedStatement stmt = con.prepareStatement("SELECT * FROM bids WHERE email=? VALUE(?)");
		  			
		  	//For each sale, get the rows where 
		  	
		  	stmt.setString(1,customerEmail);
			ResultSet rs= stmt.executeQuery();

			
			
			
			
			
			con.close();
			response.sendRedirect(request.getHeader("referer"));
			
			
			
			// Get all the bis that are currently placed
			
			// Search through the bids checking:
			//	(1) If the sale has ended
			//  (2) If the bidder has the highest bid for the sale
			//      If either of these are true then skip the bid in question
			//   Otherwise check if the bidder can make a bid that is higher then the current bid for that given sale
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

		}
		
		catch (Exception ex){
			out.println(ex);
			session.setAttribute("makeBidStatus","Bid could not be placed, please try again");
			//response.sendRedirect("Home.jsp");	
		} 


	%>
	
	</body>









</html>