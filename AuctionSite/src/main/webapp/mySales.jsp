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
				<li><a href="./Home.jsp">Home</a></li>
				<li><a href="./mySales.jsp">My Sales</a></li>
				<li><a href="./myBids.jsp">My Bids</a></li>
				<li><a href="./myAlerts.jsp">My Alerts</a></li>
				<li><a href="./customerServiceTab.jsp">Customer Support</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
				<li><a href="./logOut.jsp">Log Out</a><li>
			</ul>
		</div>
	
		<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			String customerEmail = (String) session.getAttribute("customerEmail");
			
			PreparedStatement activeSales = con.prepareStatement("SELECT * FROM sale WHERE status=? AND saleNumber IN (SELECT saleNumber FROM sells WHERE email=?)");
			activeSales.setInt(1,0);
			activeSales.setString(2,customerEmail);
			ResultSet rs = activeSales.executeQuery();		
		

		

				%>
				
				<h1>My Active Sales</h1>
				
				
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
						<th>Minimum Price</th>
						<td>Highest Bid</td>
						<th>Status</th>
					</tr>
				<%
				
			if(rs.next()){
				

				do{

					PreparedStatement getMaxBid = con.prepareStatement("SELECT MAX(currentBid) FROM bids WHERE saleNumber=?");
				  	getMaxBid.setInt(1,rs.getInt(1));
					ResultSet rs2= getMaxBid.executeQuery();
					
					

					if(!rs2.next()){
						out.println("ERROR");
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
						<td><%= rs.getString(12) %></td>
						<td>$<%= rs2.getFloat(1) %></td>
						<td>Open</td>		
					</tr>
					
					
					
					
					
				<%}while(rs.next());
				

				
			
				
				
				
				
				
				
				
				
			}
		
			else{
				%>
				
				<tr>
					<td colspan="13">No Active Sales</td>
				</tr>
				
				<%
			}
			
			
			%> </table><%
			
			
			con.close();			
			
			
			
	
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	<%
		try {
			
			%>
			<h1>Previous Auctions</h1>
			
			
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
					<th>Minimum Price</th>
					<td>Highest Bid</td>
					<th>Status</th>
				</tr>
			<% 
			
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			String customerEmail = (String) session.getAttribute("customerEmail");
			
			PreparedStatement activeSales = con.prepareStatement("SELECT * FROM sale WHERE status=? AND saleNumber IN (SELECT saleNumber FROM sells WHERE email=?)");
			activeSales.setInt(1,1);
			activeSales.setString(2,customerEmail);
			ResultSet rs = activeSales.executeQuery();		
		

		

			if(rs.next()){
				

				
				
			
				do{

					PreparedStatement getMaxBid = con.prepareStatement("SELECT MAX(currentBid) FROM bids WHERE saleNumber=?");
				  	getMaxBid.setInt(1,rs.getInt(1));
					ResultSet rs2= getMaxBid.executeQuery();
					
					PreparedStatement getSaleStatus = con.prepareStatement("SELECT * FROM won WHERE email=? and saleNumber=?");
					getSaleStatus.setString(1,customerEmail);
					getSaleStatus.setInt(2,rs.getInt(1));
					ResultSet rs3= getSaleStatus.executeQuery();
					
					
					String soldStatus = "";
					
					if(rs3.next()){
						soldStatus = "Sold";
					}
					else{
						soldStatus = "Not Sold";
					}
					
					if(!rs2.next()){
						out.println("ERROR");
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
						<td><%= rs.getString(12) %></td>
						<td>$<%= rs2.getFloat(1) %></td>
						<td>Closed / <%out.println(soldStatus); %></td>		
					</tr>
					
					
					
					
					
				<%}while(rs.next());

			
						
				
			}
	
			else{
				%>
				
				<tr>
					<td colspan="13">No Previous Sales</td>
				</tr>
				
				<%
			}			
			
			%> </table><%
			
			
			con.close();
						
			
			
			
			
	
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	

	
	</body>









</html>