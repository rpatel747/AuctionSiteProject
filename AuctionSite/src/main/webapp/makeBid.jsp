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
		
		
		
			
		  	//Compare Dates
		  	
/* 		  	Date todaysDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
		  	String beforeDate = "2001-05-05 01:01:01";
		  	String afterDate = "2023-04-04 01:01:01";
		  	Date dateBefore = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(afterDate);
		  	if(todaysDate.after(dateBefore)){
			  out.println("HAPPEND LATER");
		  	}
		  	else{
			  out.println("Happend Before");
		  	} */
		  	
		  	
		  	
 		try {
			
 			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			

			String customerEmail = (String) session.getAttribute("customerEmail");
			
			
			// Get todays date:
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  	String todaysDateTime = sdf.format(new Date());		
			
		  	
			int saleNumber = Integer.parseInt(request.getParameter("bidSaleNumber"));
			String bidInitalAmount = (String) request.getParameter("initBidAmount");
			String maxBidAmount =(String)(request.getParameter("maxBidAmount"));
			String bidIncrement = (String)(request.getParameter("bidIncr"));
			
			// Check if the user has already placed a bid on sale in question
			PreparedStatement checkBidHistory = con.prepareStatement("SELECT * FROM bids WHERE email=? AND saleNumber=?");
			checkBidHistory.setString(1,customerEmail);
			checkBidHistory.setInt(2,saleNumber);
			ResultSet rs2= checkBidHistory.executeQuery();
			
			if(rs2.next()){
				// User has already palced a bid on the item
				// The auto bidder will make any further bids
				// If they want to make any adjustments please contact customer support
				session.setAttribute("makeBidStatus","You have already placed a bid on the item, the auto bidder will make any further bids for you");
			}						
			
			
			//Get the information about the sale, make sure that the sale is still open
			PreparedStatement getSaleStatus = con.prepareStatement("SELECT * FROM sale WHERE saleNumber=?");
			getSaleStatus.setInt(1,saleNumber);
			ResultSet rs= getSaleStatus.executeQuery();
		
			
			if(rs.next()){
				

				
				int saleStatus = rs.getInt(13);
				
				if(saleStatus == 0){
				
					String insertIntoBids = "INSERT INTO bids(email,saleNumber,currentBid,maxBid,automaticBidIncrement) VALUES(?,?,?,?,?)";
					PreparedStatement ps = con.prepareStatement(insertIntoBids);
					ps.setString(1,customerEmail);
					ps.setInt(2,saleNumber);
					ps.setFloat(3,Float.parseFloat(bidInitalAmount));
					ps.setFloat(4,Float.parseFloat(maxBidAmount));
					ps.setFloat(5,Float.parseFloat(bidIncrement));			
					
					ps.executeUpdate();
					
					
					String insertIntoBidsHistory = "INSERT INTO bidsHistory(email,saleNumber,currentBid,maxBid,automaticBidIncrement,bidDateTime) VALUES(?,?,?,?,?,?)";
					PreparedStatement ps1 = con.prepareStatement(insertIntoBidsHistory);
					ps1.setString(1,customerEmail);
					ps1.setInt(2,saleNumber);
					ps1.setFloat(3,Float.parseFloat(bidInitalAmount));
					ps1.setFloat(4,Float.parseFloat(maxBidAmount));
					ps1.setFloat(5,Float.parseFloat(bidIncrement));					
					ps1.setTimestamp(6,java.sql.Timestamp.valueOf(todaysDateTime));
					ps1.executeUpdate();
					
					session.setAttribute("makeBidStatus","Bid was successfully placed");
				}
				
				else if(saleStatus == 1){
					
					session.setAttribute("makeBidStatus","Bid not placed, sale has already closed.");
				}
			}
			
			
			else{
				
				
				session.setAttribute("makeBidStatus","Sale does not exist");	
				
				
				
				
			}
			
			
			con.close();
			response.sendRedirect(request.getHeader("referer"));	

		}
		
		catch (Exception ex){
			out.println(ex);
			session.setAttribute("makeBidStatus","Bid could not be placed, please try again");
			//response.sendRedirect("Home.jsp");	
		} 

	%>
	
		<h1>Your sale was created successfully!</h1>
	
	
	</body>









</html>