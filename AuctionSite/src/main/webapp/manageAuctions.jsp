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
		<title>Customer Auctions</title>
	</head>
	
	
	
	<body>
	
		
		<div class="topNavBar">
			<ul>
				<li><a href="./employeePortal.jsp">Home</a></li>
				<li><a href="./manageCustQuestions.jsp">Manage Customer Questions</a><li>
				<li><a href="./manageAuctions.jsp">Manage Auctions</a><li>
				<li><a href="./manageCustomerAccounts.jsp">Manage Customer Accounts</a><li>
				<li><a href="./logOut.jsp">Log Out</a></li>
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
			<br>
			<input type="submit" value="Delete Auction">
		</form>
		
		
		<h2>Delete Bids Form</h2>
		<h3>** For the form, if you are deleting all bids for user account please enter Auction ID: 0 **</h3>
		<form method="post" action="deleteBids.jsp">
			<label for="auctionID">Auction ID:</label>
			<input type="text" name="auctionID" required>
			<br>
			<br>
			<label for="bidderUsernameEmail">Bider Email/Username:</label>
			<select name="bidderUsernameEmail">
			
				
				<%
					
			 		try {
						
			 			ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						
						
			
						
					  	// Prepare the statement to insert the question into the database
						PreparedStatement getUsers = con.prepareStatement("SELECT * FROM customerHas");
						ResultSet rs = getUsers.executeQuery();
						
						String[] userInfo = new String[2000];
						String[][] rawInfo = new String[2][2000];
						int numberOfUsers = 0;
						
						while(rs.next()){
							
							userInfo[numberOfUsers]=rs.getString(1) + "///" + rs.getString(2);
							rawInfo[0][numberOfUsers] = rs.getString(1);
							rawInfo[1][numberOfUsers] = rs.getString(2);
							numberOfUsers++;
							
						}
						
						
						int i = 0;
						while(i<numberOfUsers){
							
							%><option value="<%= userInfo[i].toString() %>"><% out.println(rawInfo[0][i].toString() + " || " +rawInfo[1][i].toString() );%></option> <%
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
				
				%>
				
				<h2>Open Auctions:</h2>
				
				
				<table style="margin: 0 auto;">
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
				
				if(!rs.next()){
					%>
					<tr>
						<td colspan="12">There are no sales in the system</td>
					</tr>
					<%
					con.close();
				}
				else{
					
					int numOfSalesPrinted = 0;
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
						
						
						
						numOfSalesPrinted++;
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

					if(numOfSalesPrinted == 0){
						%>
						<tr>
							<td colspan="12">There are no sales in the system</td>
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
				
			
			
				PreparedStatement stmt = con.prepareStatement("SELECT * FROM sale");
			
				ResultSet rs= stmt.executeQuery();
				
				%>
				
				<h2>Closed Auctions</h2>
				
				
				<table style="margin: 0 auto;">
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
				
				if(!rs.next()){
					%>
						<tr>
							<td colspan="12">There are no sales in the system</td>
						</tr>
					<%
					con.close();
				}
				else{
					int numOfSalesPrinted = 0;
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
						
						
						
						numOfSalesPrinted++;
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
					
					
					if(numOfSalesPrinted == 0){
						%>
						<tr>
							<td colspan="12">There are no sales in the system</td>
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
	
	
	
	
	</body>









</html>