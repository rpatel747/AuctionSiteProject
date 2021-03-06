<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User History</title>
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
	<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			
			String usernameGiven = (String) request.getParameter("username");
			
			PreparedStatement getCustomerEmail = con.prepareStatement("SELECT email FROM customerHas WHERE username=?");
			getCustomerEmail.setString(1,usernameGiven);
			ResultSet rs = getCustomerEmail.executeQuery();
			
			%>
			
			<h1>Auctions Created (as Seller):</h1>
			
			
			<table style="margin: 0 auto">
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
					<th>Status</th>
				</tr>
			<%
			
			if(!rs.next()){
				%>
				
					<tr>
						<td colspan="11">User does not exist</td>
					</tr>
					</table>
				
				<%
				con.close();
			}
			
			else{
				
				String customerEmail = (String) rs.getString(1);
				
				PreparedStatement getAuctionsCreated = con.prepareStatement("SELECT * FROM sale WHERE saleNumber IN (SELECT saleNumber FROM sells WHERE email=?)");
				getAuctionsCreated.setString(1,customerEmail);
				ResultSet rs2= getAuctionsCreated.executeQuery();
				
				if(!rs2.next()){
					%>
					
					<tr>
						<td colspan="11">User has not created any auctions</td>
					</tr>
					</table>
				
					<%
					
				}
				else{
					
			
					do{
						
						
						PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids)");
					  	getMaxBid.setInt(1,rs2.getInt(1));
						ResultSet rs3= getMaxBid.executeQuery();
						
						String status;
						if(rs2.getInt(13) == 1){
							status = "Closed";
						}
						else{
							status = "Open";
						}

						
						
						
/* 						PreparedStatement getSellerUsername = con.prepareStatement("SELECT username FROM customerHas WHERE email IN(SELECT email FROM sells WHERE saleNumber=?)");
						getSellerUsername.setInt(1,rs.getInt(1));
						ResultSet rs5 = getSellerUsername.executeQuery(); */
						

						
						%>
						
						<tr >
							<td><%= rs2.getString(1) %></td>
							<td><%= usernameGiven %></td>
							<td><%= rs2.getString(2) %></td>
							<td><%= rs2.getString(3) %></td>
							<td><%= rs2.getString(4) %></td>
							<td><%= rs2.getString(6) %></td>
							<td><%= rs2.getString(7) %></td>
							<td><%= rs2.getString(8) %></td>
							<td><%= rs2.getString(9) %></td>
							<td><%= rs2.getString(10) %></td>
							<td><%= status %></td>		
						</tr>
						
						
						
						
						
					<%}while(rs2.next());
					
					%> </table><%
					
					
					con.close();
					
				
					
					
					
					
					
					
					
					
				}
			
				%>	
				
				<%			
				
			
			
			
			
			
	
		
			}
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
 
	<%
		try {
			
			%>
			
			<h1>Auctions Bidded In :</h1>
			
			
			<table style="margin: 0 auto">
				<tr>
					<th>Auction Number</th>
					<th>Bidder</th>
					<th>Car Name</th>
					<th>Manufactured Year</th>
					<th>Manufacturer</th>
					<th>Mileage</th>
					<th>Trim</th>
					<th>Vehicle Type</th>
					<th>Color</th>
					<th>Auction Finish</th>
					<th>Status</th>
				</tr>
			<%
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			
			String usernameGiven = (String) request.getParameter("username");
			
			PreparedStatement getCustomerEmail = con.prepareStatement("SELECT email FROM customerHas WHERE username=?");
			getCustomerEmail.setString(1,usernameGiven);
			ResultSet rs = getCustomerEmail.executeQuery();
			
			if(!rs.next()){
				%>
				
				<tr>
					<td colspan="11">User does not exist</td>
				</tr>
				</table>
			
				<%
				con.close();
			}
			
			else{
				
				String customerEmail = (String) rs.getString(1);
				
				PreparedStatement getAuctionsCreated = con.prepareStatement("SELECT * FROM sale WHERE saleNumber IN (SELECT saleNumber FROM bids WHERE email=?)");
				getAuctionsCreated.setString(1,customerEmail);
				ResultSet rs2= getAuctionsCreated.executeQuery();
				
				if(!rs2.next()){
					%>
					
					<tr>
						<td colspan="11">User has not bid on any auctions</td>
					</tr>
					</table>
					
					<%
					con.close();
				}
				else{
					
			
					do{
						
						
						PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids)");
					  	getMaxBid.setInt(1,rs2.getInt(1));
						ResultSet rs3= getMaxBid.executeQuery();
						
						String status;
						if(rs2.getInt(13) == 1){
							status = "Closed";
						}
						else{
							status = "Open";
						}

						
						
						
/* 						PreparedStatement getSellerUsername = con.prepareStatement("SELECT username FROM customerHas WHERE email IN(SELECT email FROM sells WHERE saleNumber=?)");
						getSellerUsername.setInt(1,rs.getInt(1));
						ResultSet rs5 = getSellerUsername.executeQuery(); */
						

						
						%>
						
						<tr >
							<td><%= rs2.getString(1) %></td>
							<td><%= usernameGiven %></td>
							<td><%= rs2.getString(2) %></td>
							<td><%= rs2.getString(3) %></td>
							<td><%= rs2.getString(4) %></td>
							<td><%= rs2.getString(6) %></td>
							<td><%= rs2.getString(7) %></td>
							<td><%= rs2.getString(8) %></td>
							<td><%= rs2.getString(9) %></td>
							<td><%= rs2.getString(10) %></td>
							<td><%= status %></td>		
						</tr>
						
						
						
						
						
					<%}while(rs2.next());
					
					%> </table><%
					
					
					con.close();
					
				
					
					
					
					
					
					
					
					
				}
			
		
				
			
			
			
			
			
	
		
			}
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>

	<form id="backToHome"  method="post" action="Home.jsp">
			<input type="submit" value="Back to Home">
	</form>	


</body>
</html>