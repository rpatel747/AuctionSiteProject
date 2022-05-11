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
			
			

			
			
			// Get the input data from the form
			int auctionID = Integer.parseInt(request.getParameter("auctionID"));
			String deletionReason = request.getParameter("reason");

			
		  	// Prepare the statement to insert the question into the database
			PreparedStatement deleteSale = con.prepareStatement("DELETE FROM sale WHERE saleNumber=?");
			deleteSale.setInt(1,auctionID);
			deleteSale.executeUpdate();
			

			con.close();
			response.sendRedirect(request.getHeader("referer"));
			
			

		}
		
		catch (Exception ex){
			out.println(ex);

		} 


	%>
	
	</body>









</html>