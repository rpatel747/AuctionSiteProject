<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Home</title>
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
		
		<div class="topNavBar">
			<ul>
				<li><a href="./Home.jsp">Home</a></li>
				<li><a href="./mySales.jsp">My Sales</a></li>
				<li><a href="./myBids.jsp">My Bids</a></li>
				<li><a href="./messages.jsp">Customer Support</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
			</ul>
		</div>
		
		<br>
		
		
		
		
		
		
		
			<% 
 			// If the user tries to login, but the username/password do not exist then return this error.
			String createAuctionStatus = (String) session.getAttribute("createAuctionStatus");
			String makeBidStatus = (String) session.getAttribute("makeBidStatus");
			if(createAuctionStatus.contains("Auction successfully created, auction sale number: ") || createAuctionStatus== "Error auction not created"){
				%> <h2><%out.println(createAuctionStatus);%></h2><%
				session.setAttribute("createAuctionStatus","");
			} 
		
 			if(makeBidStatus =="Bid was successfully placed" || makeBidStatus== "Bid could not be placed, please try again" || makeBidStatus == "Bid not placed, sale has already closed."
 					|| makeBidStatus == "Sale does not exist"|| makeBidStatus == "You have already placed a bid on the item, the auto bidder will make any further bids for you"){
				%> <h2><%out.println(makeBidStatus);%></h2><%
				session.setAttribute("makeBidStatus","");				
			}
 		%>
		<form id="RefreshSales"  method="post" action="checkAuctions.jsp">
			<input type="submit" value="RefreshSales">
		</form>
		
		<div class="container">
				
			<h2>View the Current Sales</h2>
		
			<form id="filteredSearch" method="post" action="searchFilter.jsp">
				<label for="searchCarName">Car Name:</label>
				<input type="text" name="searchCarName">
				<br>
				<br>
				<label for="searchVehicleType">Vehicle Type:</label>
				<input type="radio" name="searchVehicleType"> Truck 
				<input type="radio" name="searchVehicleType"> Car 
				<input type="radio" name="searchVehicleType"> Motorbike  
				<br>
				<br>
				<label for="searchManufacturer">Manufacturer: </label>
				<input type="text" name="searchManufacturer">
				<br>
				<br>
				<label for="searchManufacturedYear">Manufactured Year: </label>
				<input type="text" name="searchManufacturedYear">
				<br>
				<br>
				<label for="serachColor">Color: </label>
				<input type="radio" name="serachColor"> Red 
				<input type="radio" name="serachColor"> Blue 
				<input type="radio" name="serachColor"> Black
				<input type="radio" name="serachColor"> Green 
				<input type="radio" name="serachColor"> Red 
				<input type="radio" name="serachColor"> Yellow    
				<br>
				<br>				
				<label for="searchMileage">Max Mileage (miles): </label>
				<input type="text" name="searchMileage">
				<br>
				<br>
				<label for="searchPrice">Price (USD): </label>
				<input type="text" name="searchPrice">
				<br>
				<br>
				<label for="searchTrim">Trim</label>
				<input type="text" name="searchTrim">
				<br>
				<br>		
				<input type="submit" value="Find Me This Vehicle" class="submitButton">
			</form>
			
			<br>
			<form id="searchAll"  method="post" action="searchAll.jsp">
				<input type="submit" value="Search All Sales" class="submitButton">
			</form>		
		
	
		</div>
		
	
		
		
		
		
		
		<br>
		<br>
		<br>
		
		
		
		
		
		
		
		
		
		
		
		<div class="container">
			
			<h2>Create Your Own Sale</h2>
			
			<form method="post" action="createSale.jsp">
				<label for="vehicleType">Vehicle Type:</label>
				<input type="radio" name="vehicleType" value="truck"> Truck 
				<input type="radio" name="vehicleType" value="car"> Car 
				<input type="radio" name="vehicleType" value="motorbike"> Motorbike  	
				<br>
				<br>
				
				
				<label for="manufacturer">Manufacturer: </label>
	
				<input list="manufacturer" name="manufacturer">
				<datalist id="manufacturer">
					<option value="Toyota"></option>
					<option value="Honda"></option>
					<option value="Ford"></option>
				</datalist>
				<br>
				<br>
				
				<label for="carName">Car Name:</label>
				<input type="text" name="carName">
				
				<br>
				<br>
				<label for="manufacturedYear">Manufactured Year: </label>
				<input type="text" name="manufacturedYear">			
				<br>
				<br>
				
				
				<label for="color">Color: </label>
				<input type="radio" name="color" value="Red"> Red 
				<input type="radio" name="color" value="Blue"> Blue 
				<input type="radio" name="color" value="Black"> Black
				<input type="radio" name="color" value="Green"> Green 
				<input type="radio" name="color" value="Silver"> Silver 
				<input type="radio" name="color" value="Yellow"> Yellow 
				<br>
				<br>	
				
				
							
				<label for="mileage">Mileage: </label>
				<input type="text" name="mileage">
				<br>
				<br>
				
				
				<label for="price">Price (USD): </label>
				<input type="text" name="price">
				<br>
				<br>
				
				
				<label for="trim">Trim: </label>
				<input type="text" name="trim">
				<br>
				<br>
				
				
				<label for="validBidIncrement">Bid Increment: </label>
				<input type="text" name="validBidIncrement">
				<br>
				<br>
				
				<label for="endDateTime">Sale End Date & Time: </label>
				<input type="datetime-local" name="endDateTime">
				
				<br>
				<br>
				<input type="submit" value="Create Sale!" class="submitButton">
			</form>
			
		
			<div class="container">
		
					<h2>Make a bid</h2>
				
					<form id="makeBid" method="post" action="makeBid.jsp">
			
			
						<label for="bidSaleNumber">Sale Number:</label>
						<input type="text" name="bidSaleNumber">
						<br>
						<br>
						<label for="initBidAmount">Initial Bid Amount:</label>
						<input type="text" name="initBidAmount">				
						<br>
						<br>
						<label for="maxBidAmount">Max bid amount:</label>
						<input type="text" name="maxBidAmount">						
						<br>
						<br>
						<label for="bidIncr">Bid increment:</label>
						<input type="text" name="bidIncr">			
						<br>
						<br>
						<input type="submit" value="Make Bid" class="submitButton">
					</form>
					
					<br>
		
	
			</div>	
		
		</div>

	</body>
</html>