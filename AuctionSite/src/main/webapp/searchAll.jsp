<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- This page is used to check if a user with the given credentials exists, if they do
	 then they will be logged in. Otherwise an error we will be reported. -->
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">		
		<style><%@include file="./CSS/home.css"%></style>
	</head>
	
	
	<body>
	
		<div class="topNavBar">
			<ul>
				<li><a href="./checkAuctionsHome.jsp">Home</a></li>
				<li><a href="./checkAuctionsMySales.jsp">My Auctions</a></li>
				<li><a href="./checkAuctionsMyBids.jsp">My Bids</a></li>
				<li><a href="./checkAuctionsMyAlerts.jsp">My Alerts</a></li>
				<li><a href="./checkAuctionsCustomerService.jsp">Customer Support</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
				<li><a href="./logOut.jsp">Log Out</a><li>
			</ul>
		</div>
		<br>
		<br>
	
	<div id="con1">
		<form method="post" action="viewUserParticipation.jsp">
		
			<h2>View Auction Participation History for:</h2>
			<label for="username">Username:</label>
			<input type="text" name="username">
			<input type="submit">		
		
		</form>
	</div>
	
	
	
	
	<div id="con1">
		<form method="post" action="viewAuctionBidHistory.jsp">
		
			<h2>View Bidding History:</h2>
			<label for="auctionNumber">Auction Number:</label>
			<input type="text" name="auctionNumber">
			<input type="submit">
		
		</form>
	</div>
	
	
	
	
	
		<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
		
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM sale WHERE status = 0");
			ResultSet rs= stmt.executeQuery();

			%>
			
			<h1>Open Auctions</h1>
			
			
			<table id="viewSalesTable" style="margin: 0 auto;">
				<tr>
					<th>Auction Number</th>
					<th>Seller</th>
					<th>Car Name</th>
					<th>Manufactured Year</th>
					<th>Manufacturer</th>
					<th>Mileage</th>
					<th>Trim</th>
					<th>Vehicle Type</th>
					<th>Color</th>
					<th>Auction Finish</th>
					<th>Highest Bidder</th>
					<td>Highest Bid</td>
					<th>Status</th>
				</tr>
			<%
			
			if(!rs.next()){
				%>
				
				<tr>
					<td colspan="13">Currently there are no open sales</td>
				</tr>
				</table>
				
				<%
				con.close();
			}
			else{
				
				int numPrintedd=0;
				do{
					
					
					PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids WHERE saleNumber=?)");
				  	getMaxBid.setInt(1,rs.getInt(1));
				  	getMaxBid.setInt(2,rs.getInt(1));
					ResultSet rs2= getMaxBid.executeQuery();
					
					String status;
					if(rs.getInt(13) == 1){
						status = "Closed";
					}
					else{
						status = "Open";
					}
					
					
					Float highestBid;
					String highestBidder = "";
					if(rs2.next()){
						highestBid = rs2.getFloat(3);
						
						PreparedStatement getHighestBidder = con.prepareStatement("SELECT username FROM customerHas WHERE email=?");
						getHighestBidder.setString(1,rs2.getString(1));
						ResultSet rs3 = getHighestBidder.executeQuery();
						
						if(rs3.next()){
							highestBidder = rs3.getString(1);
						}
						
						
					}
					else{
						highestBid = (float) 0.0;
						highestBidder = "";
					}
					
					
					
					PreparedStatement getSellerUsername = con.prepareStatement("SELECT username FROM customerHas WHERE email IN(SELECT email FROM sells WHERE saleNumber=?)");
					getSellerUsername.setInt(1,rs.getInt(1));
					ResultSet rs4 = getSellerUsername.executeQuery();
					
					if(rs4.next()){
						
					}
					
					numPrintedd++;
					%>
					
					<tr >
						<td><%= rs.getString(1) %></td>
						<td><%= rs4.getString(1) %></td>
						<td><%= rs.getString(2) %></td>
						<td><%= rs.getString(3) %></td>
						<td><%= rs.getString(4) %></td>
						<td><%= rs.getString(5) %></td>
						<td><%= rs.getString(7) %></td>
						<td><%= rs.getString(8) %></td>
						<td><%= rs.getString(9) %></td>
						<td><%= rs.getString(10) %></td>
						<td><%= highestBidder %></td>
						<td>$<%= highestBid %></td>
						<td><%= status %></td>		
					</tr>
					
					
					
					
					
				<%}while(rs.next());
				
				if(numPrintedd == 0){
					%>
					
					<tr>
						<td colspan="13">No sales match your search criteria</td>
					</tr>
					<%					
				}
				
				
				%> </table><%
				
				
				con.close();
				
			
				
				
				
				
				
				
				
				
			}
		

			
			
			
			
			
	
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	
<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
		
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM sale WHERE status=1");
			ResultSet rs= stmt.executeQuery();
			
			if(!rs.next()){
				out.println("There are no sales currently.");
				
			}
			else{
				
				
				%>
				
				<h1>Closed Auctions</h1>
				
				
				<table id="viewSalesTable" style="margin: 0 auto;">
					<tr>
						<th>Auction Number</th>
						<th>Seller</th>
						<th>Car Name</th>
						<th>Manufactured Year</th>
						<th>Manufacturer</th>
						<th>Mileage</th>
						<th>Trim</th>
						<th>Vehicle Type</th>
						<th>Color</th>
						<th>Auction Finish</th>
						<th>Highest Bidder</th>
						<td>Highest Bid</td>
						<th>Status</th>
					</tr>
				<%
				do{
					
					
					PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids WHERE saleNumber=?)");
				  	getMaxBid.setInt(1,rs.getInt(1));
				  	getMaxBid.setInt(2,rs.getInt(1));
					ResultSet rs2= getMaxBid.executeQuery();
					
					String status;
					if(rs.getInt(13) == 1){
						status = "Closed";
					}
					else{
						status = "Open";
					}
					
					
					Float highestBid;
					String highestBidder = "";
					if(rs2.next()){
						highestBid = rs2.getFloat(3);
						
						PreparedStatement getHighestBidder = con.prepareStatement("SELECT username FROM customerHas WHERE email=?");
						getHighestBidder.setString(1,rs2.getString(1));
						ResultSet rs3 = getHighestBidder.executeQuery();
						
						if(rs3.next()){
							highestBidder = rs3.getString(1);
						}
						
						
					}
					else{
						highestBid = (float) 0.0;
						highestBidder = "";
					}
					
					
					
					PreparedStatement getSellerUsername = con.prepareStatement("SELECT username FROM customerHas WHERE email IN(SELECT email FROM sells WHERE saleNumber=?)");
					getSellerUsername.setInt(1,rs.getInt(1));
					ResultSet rs4 = getSellerUsername.executeQuery();
					
					if(rs4.next()){
						
					}
					
					
					%>
					
					<tr >
						<td><%= rs.getString(1) %></td>
						<td><%= rs4.getString(1) %></td>
						<td><%= rs.getString(2) %></td>
						<td><%= rs.getString(3) %></td>
						<td><%= rs.getString(4) %></td>
						<td><%= rs.getString(5) %></td>
						<td><%= rs.getString(7) %></td>
						<td><%= rs.getString(8) %></td>
						<td><%= rs.getString(9) %></td>
						<td><%= rs.getString(10) %></td>
						<td><%= highestBidder %></td>
						<td>$<%= highestBid %></td>
						<td><%= status %></td>		
					</tr>
					
					
					
					
					
				<%}while(rs.next());
				
				%> </table><%
				
				
				con.close();
				
			
				
				
				
				
				
				
				
				
			}

			
			
			
			
			
	
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	<br>
	<br>
	<br>
	
	</body>









</html>