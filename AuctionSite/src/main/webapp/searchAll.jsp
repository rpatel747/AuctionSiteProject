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
		<style><%@include file="./CSS/searches.css"%></style>
	</head>
	
	
	<body>
	
	
		<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
		
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM sale");
		
			ResultSet rs= stmt.executeQuery();
			
			if(!rs.next()){
				out.println("There are no sales currently.");
				
			}
			else{
				
				
				%>
				
				<h1>All Current Sales:</h1>
				
				
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
					
					String status;
					if(rs.getInt(13) == 1){
						status = "Closed";
					}
					else{
						status = "Open";
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
						<td><%= status %></td>		
					</tr>
					
					
					
					
					
				<%}while(rs.next());
				
				%> </table><%
				
				
				con.close();
				
			
				
				
				
				
				
				
				
				
			}
		
			%>	
			
			<form id="backToHome"  method="post" action="Home.jsp">
				<input type="submit" value="Back to Home">
			</form>				
				
			<%			
			
			
			
			
			
			
	
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	
	
	</body>









</html>