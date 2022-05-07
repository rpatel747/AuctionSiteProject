<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<title>Search</title>
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
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			String carName = request.getParameter("searchCarName");
			String manufacturedYear = request.getParameter("searchManufacturedYear");
			String manufacturer = request.getParameter("searchManufacturer");
			String mileage = request.getParameter("searchMileage");
			String trim = request.getParameter("searchTrim");
			String vehicleType = request.getParameter("searchVehicleType");
			String color = request.getParameter("searchColor");
			String price = request.getParameter("searchPrice");
			
			if(carName.isEmpty()){
				carName = "null";
			}
			
			if(manufacturedYear.isEmpty()){
				manufacturedYear = "null";
			}
			
			if(manufacturer.isEmpty()){
				manufacturer = "null";
			}
			
			if(mileage.isEmpty()){
				mileage = "null";
			}
			
			if(trim.isEmpty()){
				trim = "null";
			}
			
			if(vehicleType.isEmpty()){
				vehicleType = "null";
			}
			
			if(color.isEmpty()){
				color = "null";
			}
			
			if(price.isEmpty()){
				price = "null";
			}
			
			String[] searchCriteria = new String[8];
			searchCriteria[0] = carName;
			searchCriteria[1] = manufacturedYear;
			searchCriteria[2] = manufacturer;
			searchCriteria[3] = mileage;
			searchCriteria[4] = price;
			searchCriteria[5] = trim;
			searchCriteria[6] = vehicleType;
			searchCriteria[7] = color;
			
			
			
			PreparedStatement getSales = con.prepareStatement("SELECT * FROM sale");
			ResultSet sales = getSales.executeQuery();
			
			if(sales.next()){
				
				
				%>
				
				<h1>All Current Sales:</h1>
				
				
				<table>
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
					
					String[] salesResult = new String[8];
					salesResult[0] = String.valueOf(sales.getString(2));
					salesResult[1] = String.valueOf(sales.getString(3));
					salesResult[2] = String.valueOf(sales.getString(4));
					salesResult[3] = String.valueOf(sales.getString(5));
					salesResult[4] = String.valueOf(sales.getString(6));
					salesResult[5] = String.valueOf(sales.getString(7));
					salesResult[6] = String.valueOf(sales.getString(8));
					salesResult[7] = String.valueOf(sales.getString(9));
					
					int matches = 1;
					
					
					for(int i = 0;i<8;i++){
						
						if(searchCriteria[i].equalsIgnoreCase("null")){
							continue;
						}
						
						if(!(searchCriteria[i].equalsIgnoreCase(salesResult[i]))){
							
							matches = 0;
						}
						
					}
					
					
					if(matches == 1){
						
						PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids WHERE saleNumber=?)");
					  	getMaxBid.setInt(1,sales.getInt(1));
					  	getMaxBid.setInt(2,sales.getInt(1));
						ResultSet rs2= getMaxBid.executeQuery();
						
						String status;
						if(sales.getInt(13) == 1){
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
						getSellerUsername.setInt(1,sales.getInt(1));
						ResultSet rs4 = getSellerUsername.executeQuery();
						
						if(rs4.next()){
							
						}						
						
						%>
						
						<tr>
							<td><%= sales.getString(1) %></td>
							<td><%= rs4.getString(1) %></td>
							<td><%= sales.getString(2) %></td>
							<td><%= sales.getString(3) %></td>
							<td><%= sales.getString(4) %></td>
							<td><%= sales.getString(6) %></td>
							<td><%= sales.getString(7) %></td>
							<td><%= sales.getString(8) %></td>
							<td><%= sales.getString(9) %></td>
							<td><%= sales.getString(10) %></td>
							<td><%= highestBidder %></td>
							<td>$<%= highestBid %></td>
							<td><%= status %></td>
						</tr>
						
						
						<%
						
					}
					
					
					
					
				}	while(sales.next());

				%></table><%
			}
			
			else{
				out.println("No sales match your search criteria, please change your criteria");
			}
			
		}
	
	
		catch (Exception ex){
			out.println(ex);
			session.setAttribute("createAuctionStatus","Error sales could not be found");
			response.sendRedirect("Home.jsp");	
		}
	
	%>


</body>
</html>