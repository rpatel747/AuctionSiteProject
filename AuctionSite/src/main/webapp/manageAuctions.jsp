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
	
	<h1><%
		String username = (String) session.getAttribute("username");
		out.println("Welcome " + username +"!");
		%></h1>
		
		<form id="logOutButton"  method="post" action="logOut.jsp">
			<input type="submit" value="Log Out">
		</form>
		
		
		<br>
		<br>
		
		<div class="topNavBar">
			<ul>
				<li><a href="./employeePortal.jsp">Home</a></li>
				<li><a href="./manageCustQuestions.jsp">Manage Customer Questions</a><li>
				<li><a href="./manageAuctions.jsp">Manage Auctions</a><li>
				<li><a href="./manageBids.jsp">Manage Bids</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
			</ul>
		</div>
		
		
		
		
		
		
		
		<h2>Delete Auction Form</h2>
		<form method="post" action="deleteAuction.jsp">
			<label for="auctionID">Auction ID:</label>
			<input type="text" name="auctionID">
			<br>
			<br>
			<label for="reason">Reason for Deletion:</label>
			<input type="text" name="reason">
			<br>
			<input type="submit" value="Delete Auction">
		</form>
		
		
		<h2>Delete Bids Form</h2>
		<h4>**For the form, if you are deleting all bids for user account please enter Auction ID: 0**</h4>
		<h4>ADD MORE WARNINGS HERE::::::::</h4>
		<form method="post" action="deleteBids.jsp">
			<label for="auctionID">Auction ID:</label>
			<input type="text" name="auctionID" required>
			<br>
			<br>
			<label for="bidderUsernameEmail">Bider Username/Email:</label>
			<select name="bidderUsernameEmail">
			
				
				<%
					
			 		try {
						
			 			ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						
						
			
						
					  	// Prepare the statement to insert the question into the database
						PreparedStatement getUsers = con.prepareStatement("SELECT * FROM customerHas");
						ResultSet rs = getUsers.executeQuery();
						
						String[] userInfo = new String[2000];
						int numberOfUsers = 0;
						
						while(rs.next()){
							
							userInfo[numberOfUsers]=rs.getString(1) + "///" + rs.getString(2);
							numberOfUsers++;
							
						}
						
						
						int i = 0;
						while(i<numberOfUsers){
							
							%><option value="<%= userInfo[i].toString()%>"><%= userInfo[i].toString()%></option> <%
							i++;
						}
						
						
						
			
						con.close();

						
						
			
					}
					
					catch (Exception ex){
						out.println(ex);
			
					} 
			
			
				

				%>

			</select>
			<br>
			<br>
			<label for="deleteType">Delete Type:</label>
			<select name="deleteType">
				<option value="deleteBidsFromAuction">Only Delete Bids for Given Auction</option>
				<option value="deleteAllUserBids">Delete All of the Users Bids</option>
			</select>
			<br>
			<br>
			<input type="submit" value="Delete Bids">
		
		
		
		
		
		</form>
		
		
		<br>
		
		
		
	
		<%
			try {
				
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
			
			
				PreparedStatement stmt = con.prepareStatement("SELECT * FROM sale");
			
				ResultSet rs= stmt.executeQuery();
				
				if(!rs.next()){
					out.println("There are no sales currently.");
					con.close();
				}
				else{
					
					
					%>
					
					<h1>All Open Auctions:</h1>
					
					
					<table>
						<tr>
							<th>Sale Number</th>
							<th>Car Name</th>
							<th>Manufactured Year</th>
							<th>Manufacturer</th>
							<th>Mileage</th>
							<th>Current Price</th>
							<th>Trim</th>
							<th>Vehicle Type</th>
							<th>Color</th>
							<th>Sale Finish</th>
							<td>Highest Bid</td>
							<th>Status</th>
						</tr>
					<%
					do{
						
						
						PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids)");
					  	getMaxBid.setInt(1,rs.getInt(1));
						ResultSet rs2= getMaxBid.executeQuery();
						
						
						if(rs.getInt(13) == 1){
							continue;
						}
	
						
						
						
						Float highestBid;
						
						if(rs2.next()){
							highestBid = rs2.getFloat(3);
						}
						else{
							highestBid = (float) 0.0;
						}
						
						
						
						
						%>
						
						<tr >
							<td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
							<td><%= rs.getString(3) %></td>
							<td><%= rs.getString(4) %></td>
							<td>$<%= rs.getString(5) %></td>
							<td><%= rs.getString(6) %></td>
							<td><%= rs.getString(7) %></td>
							<td><%= rs.getString(8) %></td>
							<td><%= rs.getString(9) %></td>
							<td><%= rs.getString(10) %></td>
							<td>$<%= highestBid %></td>
							<td>Open</td>		
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
	
		<%
			try {
				
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
			
			
				PreparedStatement stmt = con.prepareStatement("SELECT * FROM sale");
			
				ResultSet rs= stmt.executeQuery();
				
				if(!rs.next()){
					con.close();
				}
				else{
					
					
					%>
					
					<h1>All Closed Auctions</h1>
					
					
					<table>
						<tr>
							<th>Sale Number</th>
							<th>Car Name</th>
							<th>Manufactured Year</th>
							<th>Manufacturer</th>
							<th>Mileage</th>
							<th>Current Price</th>
							<th>Trim</th>
							<th>Vehicle Type</th>
							<th>Color</th>
							<th>Sale Finish</th>
							<td>Highest Bid</td>
							<th>Status</th>
						</tr>
					<%
					do{
						
						
						PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids)");
					  	getMaxBid.setInt(1,rs.getInt(1));
						ResultSet rs2= getMaxBid.executeQuery();
						
						
						if(rs.getInt(13) == 0){
							continue;
						}
	
						
						
						
						Float highestBid;
						
						if(rs2.next()){
							highestBid = rs2.getFloat(3);
						}
						else{
							highestBid = (float) 0.0;
						}
						
						
						
						
						%>
						
						<tr >
							<td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
							<td><%= rs.getString(3) %></td>
							<td><%= rs.getString(4) %></td>
							<td>$<%= rs.getString(5) %></td>
							<td><%= rs.getString(6) %></td>
							<td><%= rs.getString(7) %></td>
							<td><%= rs.getString(8) %></td>
							<td><%= rs.getString(9) %></td>
							<td><%= rs.getString(10) %></td>
							<td>$<%= highestBid %></td>
							<td>Closed</td>		
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
	
	
	
	
	</body>









</html>