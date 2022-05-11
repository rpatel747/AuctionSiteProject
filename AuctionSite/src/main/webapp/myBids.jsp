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
		<title>My Bids</title>
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
	
		<h1>My Active Bids:</h1>
	
			<table style="margin: 0 auto;">
				<tr>
					<th>Sale Number</th>
					<th>My Current Bid</th>
					<th>My Max Bid</th>
				</tr>
		
	
	

		<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			String customerEmail = (String) session.getAttribute("customerEmail");
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM bids WHERE email=? AND saleNumber IN (SELECT saleNumber FROM sale WHERE status=0)");
			stmt.setString(1,customerEmail);
			ResultSet rs = stmt.executeQuery();
			
			
			
			
			
			if(!rs.next()){
				%>
				
				<tr>
					<td colspan="3">You have no active bids.</td>
				</tr>
				
				</table>
				<%
				con.close();
			}
			else{
				
				
				
		
				do{
					
					PreparedStatement getMaxBid = con.prepareStatement("SELECT MAX(currentBid) FROM bids WHERE saleNumber=?");
				  	getMaxBid.setInt(1,rs.getInt(2));
					ResultSet rs2= getMaxBid.executeQuery();
					
					

					if(!rs2.next()){
						out.println("ERROR");
					}
			
					
					
	
					%>
					
					<tr >
						<td><%= rs.getInt(2) %></td>
						<td><%= rs.getFloat(3) %></td>
						<td><%= rs.getFloat(4) %></td>	
					</tr>
					
					
					
					
					
				<%} while(rs.next());
				
				%> </table><%
				
				
				con.close();
				

			}
		
			%>	
		
				
			<%			
			
			
			
			
			
			
	
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	

		<h1>My Bidding History</h1>
				
				
				
				
				
				<table style="margin: 0 auto;">
					<tr>
						<th>Sale Number</th>
						<th>Bid Amount</th>
						<th>Date</th>
					</tr>
				<%
		
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			String customerEmail = (String) session.getAttribute("customerEmail");
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM bidsHistory WHERE email=?");
			stmt.setString(1,customerEmail);
			ResultSet rs = stmt.executeQuery();
			
			
			
			
			
			if(!rs.next()){
				%>
				
				<tr>
					<td colspan="3">You have no bidding history</td>
				</tr>
				</table>
				<%
				con.close();
				
			}
			else{
				
				

				do{


					%>
					
					<tr >
						<td><%= rs.getInt(2) %></td>
						<td><%= rs.getFloat(3) %></td>
						<td><%= rs.getString(4) %></td>			
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