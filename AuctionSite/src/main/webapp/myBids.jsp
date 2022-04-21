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
	
		
	
		<h1>My Active Bids:</h1>
	
	
		
	
	

		<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			String customerEmail = (String) session.getAttribute("customerEmail");
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM bids WHERE email=? AND saleNumber IN (SELECT saleNumber FROM sale WHERE status=0)");
			stmt.setString(1,customerEmail);
			ResultSet rs = stmt.executeQuery();
			
			
			
			
			
			if(!rs.next()){
				out.println("There are no sales currently.");
				
			}
			else{
				
				
				
				
				%>
				
				
				
				
				<table>
					<tr>
						<th>Sale Number</th>
						<th>Highest Bid</th>
						<th>My Current Bid</th>
					</tr>
				<%
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
						<td><%= rs2.getFloat(1) %></td>
						<td><%= rs.getFloat(3) %></td>			
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
	
	
	<h1>My Bidding History</h1>
	
		<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			String customerEmail = (String) session.getAttribute("customerEmail");
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM bidsHistory WHERE email=?");
			stmt.setString(1,customerEmail);
			ResultSet rs = stmt.executeQuery();
			
			
			
			
			
			if(!rs.next()){
				out.println("There are no sales currently.");
				
			}
			else{
				
				
				
				
				%>
				
				
				
				
				<table>
					<tr>
						<th>Sale Number</th>
						<th>Bid Amount</th>
						<th>Date</th>
					</tr>
				<%
				do{


					%>
					
					<tr >
						<td><%= rs.getInt(2) %></td>
						<td><%= rs.getFloat(3) %></td>
						<td><%= rs.getString(6) %></td>			
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