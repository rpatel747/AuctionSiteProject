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
			String userInfo = request.getParameter("bidderUsernameEmail");
			String deleteType = request.getParameter("deleteType");
			
			String[] split = userInfo.split("///");
			String userEmail = split[0];
			String userUsername = split[1];
			
			
			
			if(deleteType.equals("deleteBidsFromAuction")){
				
				PreparedStatement deleteBids = con.prepareStatement("DELETE FROM bids WHERE email=? AND saleNumber=?");
				deleteBids.setString(1,userEmail);
				deleteBids.setInt(2,auctionID);
				deleteBids.executeUpdate();
				
				PreparedStatement deleteBids2 = con.prepareStatement("DELETE FROM bidsHistory WHERE email=? AND saleNumber=?");
				deleteBids2.setString(1,userEmail);
				deleteBids2.setInt(2,auctionID);
				deleteBids2.executeUpdate();				
				
				
			}
			
			
			else if(deleteType.equals("deleteAllUserBids")){
				PreparedStatement deleteBids = con.prepareStatement("DELETE FROM bids WHERE email=?");
				deleteBids.setString(1,userEmail);
				deleteBids.executeUpdate();
				
				PreparedStatement deleteBids2 = con.prepareStatement("DELETE FROM bidsHistory WHERE email=?");
				deleteBids2.setString(1,userEmail);
				deleteBids2.executeUpdate();				
			}

			

			con.close();
			response.sendRedirect(request.getHeader("referer"));
			
			

		}
		
		catch (Exception ex){
			out.println(ex);

		} 


	%>
	
	</body>









</html>