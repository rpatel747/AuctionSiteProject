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

		<br>
		
		<div class="topNavBar">
			<ul>
				<li><a href="./adminPortal.jsp">Home</a></li>
				<li><a href="./logOut.jsp">Log Out</a></li>
			</ul>
		</div>

		<%
		
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			
			// Generate the total earnings report
			PreparedStatement getTotalSold = con.prepareStatement("SELECT COUNT(bidPrice) FROM won");
			ResultSet totalSalesValue = getTotalSold.executeQuery();
			
			PreparedStatement getTotalNumberOfSold = con.prepareStatement("SELECT SUM(bidPrice) FROM won");
			ResultSet totalNumOfItems = getTotalNumberOfSold.executeQuery();
			
			float totalEarnings = 0;
			int totalNumberOfItemsSold = 0;
			
			if(totalSalesValue.next()){
				totalEarnings = totalEarnings + totalSalesValue.getFloat(1);
			}
			
			if(totalNumOfItems.next()){
				totalNumberOfItemsSold = totalNumOfItems.getInt(1);
			}
			
			%>
			<h2>Total Earnings</h2>
			<table style="margin: 0 auto;">
				<tr>
					<th>Total Number of Items Sold</th>
					<th>Total Amount Made From Sales (USD)</th>
				</tr>
				<tr>
					<td><%=totalEarnings %></td>
					<td>$<%=totalNumberOfItemsSold %></td>
				</tr>
			</table>
			<%
			
			// Generate the earnings per item table 
			
			PreparedStatement salesForEachItem = con.prepareStatement("SELECT vehicleType,manufacturer,carName,COUNT(carName),SUM(won.bidPrice) FROM sale INNER JOIN won ON sale.saleNumber = won.saleNumber WHERE status = 1 GROUP BY vehicleType,manufacturer,carName");
			ResultSet itemSales = salesForEachItem.executeQuery();
			
			%>
			<h2>Earnings For Vehicles</h2>
			<table style="margin: 0 auto;">
				<tr>
					<th>Vehicle Type</th>
					<th>Manufacturer</th>
					<th>Car Name</th>
					<th>Number Sold</th>
					<th>Total Earnings</th>
				</tr>
			<% 
			
			if(itemSales.next()){
				
				do{
					
					%>
					
						<tr>
							<td><%out.println(itemSales.getObject(1)); %></td>
							<td><%out.println(itemSales.getObject(2)); %></td>
							<td><%out.println(itemSales.getObject(3)); %></td>
							<td><%out.println(itemSales.getObject(4)); %></td>
							<td>$<%out.println(itemSales.getObject(5)); %></td>
						</tr>
					
					
					
					
					<%
					
					
					
					
					
					
					
					
				}	while(itemSales.next());
				

			}
			
			else{
				
				%>
				
				<tr>
					<td><%out.println("n/a"); %></td>
					<td><%out.println("n/a"); %></td>
					<td><%out.println("n/a"); %></td>
					<td><%out.println("n/a"); %></td>
					<td>$<%out.println("n/a"); %></td>
				</tr>
			
			
			
			
			<%				
				
				
				
			}
			
			
			
			
			
			%></table><%
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			// Generate the earnings per item type table
			PreparedStatement getEarningsForTrucks = con.prepareStatement("SELECT SUM(bidPrice) FROM won WHERE saleNumber IN(SELECT saleNumber FROM sale WHERE vehicleType=?)");
			getEarningsForTrucks.setString(1,"truck");
			ResultSet trucksEarnings = getEarningsForTrucks.executeQuery();
			
			PreparedStatement getNumberOfTrucksSold = con.prepareStatement("SELECT COUNT(*) FROM won WHERE saleNumber IN(SELECT saleNumber FROM sale WHERE vehicleType=?)");
			getNumberOfTrucksSold.setString(1,"truck");
			ResultSet numOfTrucks = getNumberOfTrucksSold.executeQuery();
			
			PreparedStatement getEarningsForCars = con.prepareStatement("SELECT SUM(bidPrice) FROM won WHERE saleNumber IN(SELECT saleNumber FROM sale WHERE vehicleType=?)");
			getEarningsForCars.setString(1,"car");
			ResultSet carsEarnings = getEarningsForCars.executeQuery();
			
			PreparedStatement getNumberOfCarsSold = con.prepareStatement("SELECT COUNT(*) FROM won WHERE saleNumber IN(SELECT saleNumber FROM sale WHERE vehicleType=?)");
			getNumberOfCarsSold.setString(1,"car");
			ResultSet numOfCars = getNumberOfCarsSold.executeQuery();
			
			PreparedStatement getEarningsForMotorbikes = con.prepareStatement("SELECT SUM(bidPrice) FROM won WHERE saleNumber IN(SELECT saleNumber FROM sale WHERE vehicleType=?)");
			getEarningsForMotorbikes.setString(1,"motorbike");
			ResultSet motorbikesEarnings = getEarningsForMotorbikes.executeQuery();
			
			PreparedStatement getNumberOfMotorbikesSold = con.prepareStatement("SELECT COUNT(*) FROM won WHERE saleNumber IN(SELECT saleNumber FROM sale WHERE vehicleType=?)");
			getNumberOfMotorbikesSold.setString(1,"motorbike");
			ResultSet numOfMotorbikes = getNumberOfMotorbikesSold.executeQuery();
			
			float truckEarnings = 0;
			int numberOfTrucksSold = 0;
			float carEarnings = 0;
			int numberOfCarsSold = 0;
			float motorbikeEarnings = 0;
			int numberOfMotorbikesSold = 0;
			
			if(trucksEarnings.next() && numOfTrucks.next() && carsEarnings.next() && numOfCars.next() && motorbikesEarnings.next() && numOfMotorbikes.next()){
				
				truckEarnings = trucksEarnings.getFloat(1);
				numberOfTrucksSold  = numOfTrucks.getInt(1);
				
				carEarnings = carsEarnings.getFloat(1);
				numberOfCarsSold = numOfCars.getInt(1);
				
				motorbikeEarnings = motorbikesEarnings.getFloat(1);
				numberOfMotorbikesSold = numOfMotorbikes.getInt(1);
								
				
				
			}
			
			%>
			<h2>Earnings for Vehicle Type</h2>
			<table style="margin: 0 auto;">
				<tr>
					<th>Item Type</th>
					<th>Number of Items Sold</th>
					<th>Total Earned</th>
				</tr>
				<tr>
					<td><%out.println("Car"); %></td>
					<td><%=numberOfCarsSold %></td>
					<td>$<%=carEarnings %></td>
				</tr>
				<tr>
					<td><%out.println("Motorbike"); %></td>
					<td><%=numberOfMotorbikesSold %></td>
					<td>$<%=motorbikeEarnings %></td>
				</tr>	
				<tr>
					<td><%out.println("Truck"); %></td>
					<td><%=numberOfTrucksSold %></td>
					<td>$<%=truckEarnings%></td>
				</tr>			
			</table>
			<%
			

			// Generate the earnings per end-user
			PreparedStatement getUsernameEmail = con.prepareStatement("SELECT * FROM customerHas");
			ResultSet customerUsernameAndEmails = getUsernameEmail.executeQuery();
			
			%>
			<h2>Earnings Per Customer</h2>
			<table style="margin: 0 auto;">
				<tr>
					<th>Username</th>
					<th>Number of Items Sold</th>
					<th>Total Earned from Selling</th>
					<th>Number of Items Bought</th>
					<th>Total Spent on Buying</th>
				</tr>			
			<%
			int numOfPrinted = 0;
			if(customerUsernameAndEmails.next()){
				do{
					
					String customerUsername = String.valueOf(customerUsernameAndEmails.getObject(2));
					String customerEmail = String.valueOf(customerUsernameAndEmails.getObject(1));
					
					PreparedStatement getSalesHistory = con.prepareStatement("SELECT COUNT(bidPrice),SUM(bidPrice) FROM won WHERE saleNumber IN (SELECT saleNumber FROM sells WHERE email=?)");
					getSalesHistory.setString(1,customerEmail);
					ResultSet salesHistory = getSalesHistory.executeQuery();
					
					PreparedStatement getBidsHistory = con.prepareStatement("SELECT COUNT(bidPrice),SUM(bidPrice) FROM won WHERE email=? AND saleNumber IN (SELECT saleNumber FROM bids WHERE email=?)");
					getBidsHistory.setString(1,customerEmail);
					getBidsHistory.setString(2,customerEmail);
					ResultSet bidsHistory = getBidsHistory.executeQuery();
					
					int numberOfItemsSold = 0;
					int numberOfItemsBought = 0;
					float earningsFromSelling = 0;
					float earningsFromBuying = 0;
					
					if(salesHistory.next()){
						
						String c1 = (String.valueOf(salesHistory.getObject(1)));
						String c2 = (String.valueOf(salesHistory.getObject(2)));
						
						if(!c1.equals("null")){
							numberOfItemsSold = Integer.parseInt((String.valueOf(salesHistory.getObject(1))));
						}
						
						if(!c2.equals("null")){
							earningsFromSelling = Float.parseFloat((String.valueOf(salesHistory.getObject(2))));
						}
						
					}
					
					if(bidsHistory.next()){
						
						String c1 = (String.valueOf(bidsHistory.getObject(1)));
						String c2 = (String.valueOf(bidsHistory.getObject(2)));		

						if(!c1.equals("null")){
							numberOfItemsBought = Integer.parseInt((String.valueOf(bidsHistory.getObject(1))));
						}
						
						if(!c2.equals("null")){
							earningsFromBuying = Float.parseFloat((String.valueOf(bidsHistory.getObject(2))));
						}
						

												
					}
					numOfPrinted++;				
					%>
					
					<tr>
						<td><%=customerUsername %></td>
						<td><%=numberOfItemsSold %></td>
						<td><%=earningsFromSelling %></td>
						<td><%=numberOfItemsBought %></td>
						<td><%=earningsFromBuying %></td>
					</tr>
					
					<%
					
					
				}	while(customerUsernameAndEmails.next());
			}
			
			if(numOfPrinted == 0){
				%>
				
				<tr>
					<td colspan="5">n/a</td>
				</tr>				
				
				<%
			}
			
			%></table><%
			
			
			
			
			// Generate the best selling items table
			
			PreparedStatement getBestSellingItems = con.prepareStatement("SELECT carName,manufacturer,vehicleType,COUNT(carName),SUM(bidPrice) FROM sale INNER JOIN won ON sale.saleNumber=won.saleNumber WHERE status=1 GROUP BY carName,manufacturer,vehicleType ");
			ResultSet bestSellingItems = getBestSellingItems.executeQuery();
			
			
			
			String[][] carDetails = new String[5][500];
			int[] numOfCarsSold = new int[500];
			
			int i = 0;
			
			int firstMostSold = -1;
			int secondMostSold = -1;
			int thirdMostSold = -1;
			int fourthMostSold = -1;
			
			
			if(bestSellingItems.next()){
				
				do{
	
					
					String carName = String.valueOf(bestSellingItems.getObject(1));
					String manufacturer = String.valueOf(bestSellingItems.getObject(2));
					String vehicleType = String.valueOf(bestSellingItems.getObject(3));
					String numberOfItemSold = String.valueOf(bestSellingItems.getObject(4));
					
					
					carDetails[0][i] = carName;
					carDetails[1][i] = manufacturer;
					carDetails[2][i] = vehicleType;
					carDetails[3][i] = numberOfItemSold;
					carDetails[4][i] = String.valueOf(bestSellingItems.getObject(5));
					
					if(firstMostSold == -1 || Integer.valueOf(numberOfItemSold) >= Integer.valueOf(carDetails[3][firstMostSold]) ){
						
						int oldFirst = firstMostSold;
						int oldSecond = secondMostSold;
						int oldThird = thirdMostSold;
						
						firstMostSold = i;
						secondMostSold = oldFirst;
						thirdMostSold = oldSecond;
						fourthMostSold = oldThird;
						
						i++;
					}
					
					else if(secondMostSold == -1 || Integer.valueOf(numberOfItemSold) >= Integer.valueOf(carDetails[3][secondMostSold])){
						int oldSecond = secondMostSold;
						int oldThird = thirdMostSold;
						
						secondMostSold = i;
						thirdMostSold = oldSecond;
						fourthMostSold = oldThird;
						
						i++;
					}
					
					else if(thirdMostSold == -1 || Integer.valueOf(numberOfItemSold) >= Integer.valueOf(carDetails[3][thirdMostSold])){
						int oldThird = thirdMostSold;
						
						thirdMostSold = i;
						fourthMostSold = oldThird;
						
						i++;
					}
					
					else if(fourthMostSold == -1  || Integer.valueOf(numberOfItemSold) >= Integer.valueOf(carDetails[3][fourthMostSold])){
						fourthMostSold = i;
						i++;
					}
					
					else{
						i++;
					}
						
					
				}	while(bestSellingItems.next());
				
				
			}
			
			int[] indexes = new int[4];
			indexes[0] = firstMostSold;
			indexes[1] = secondMostSold;
			indexes[2] = thirdMostSold;
			indexes[3] = fourthMostSold;
			
			
			%>
			<h2>Top 4 Selling Vehicles</h2>
			<table style="margin: 0 auto;">
				<tr>
					<th>Vehicle Type</th>
					<th>Manufacturer</th>
					<th>Vehicle Name</th>
					<th>Number of Vehicles Sold</th>
					<th>Earnings</th>
				</tr>
				
				
				<%
					int rowsPrinted = 0;
					for(int j=0;j<4;j++){
						
						if(indexes[j] == -1){
							continue;
						}
						
						else{
							rowsPrinted = 1;
							int indexValue = indexes[j];
							%>
							<tr>
								<td><%=carDetails[2][indexValue] %></td>
								<td><%=carDetails[1][indexValue] %></td>
								<td><%=carDetails[0][indexValue] %></td>
								<td><%=carDetails[3][indexValue] %></td>
								<td><%=carDetails[4][indexValue] %></td>
							</tr>							
							<%
							
						}
						
						
						
					}
					
					if(rowsPrinted == 0){
						%>
							<tr>
								<td><%out.println("n/a"); %></td>
								<td><%out.println("n/a"); %></td>
								<td><%out.println("n/a"); %></td>
								<td><%out.println("n/a"); %></td>
								<td><%out.println("n/a"); %></td>
							</tr>							
						<%
					}
				
				
				%></table><%
				
				
				
				
			
				
				%><h2>Best Buyers (Top 3)</h2>
				
				<table style="margin: 0 auto;">
					<tr>
						<td>Username</td>
						<td>Amount Spent (USD)</td>
						<td>Number of Items Bought</td>
					</tr>
				
				
				
				
				<%
				
				PreparedStatement getBestBuyers = con.prepareStatement("SELECT won.email,SUM(bidPrice),COUNT(bidPrice),username FROM won INNER JOIN customerHas ON won.email=customerHas.email GROUP BY email,customerHas.username");
				ResultSet bestBuyers = getBestBuyers.executeQuery();
				
				String[][] buyerDetails = new String[3][100];
				int k = 0;
				
				firstMostSold = -1;
				secondMostSold = -1;
				thirdMostSold = -1;
				
				if(bestBuyers.next()){
					
					do{
						
						String buyerEmail = String.valueOf(bestBuyers.getObject(4));
						String buyerTotalAmount = String.valueOf(bestBuyers.getObject(2));
						String buyerNumberOfItems = String.valueOf(bestBuyers.getObject(3));
						
						
						buyerDetails[0][k] = buyerEmail;
						buyerDetails[1][k] = buyerTotalAmount;
						buyerDetails[2][k] = buyerNumberOfItems;
						
						
						
						if(firstMostSold == -1 || Float.valueOf(buyerTotalAmount) >= Float.valueOf(buyerDetails[2][firstMostSold]) ){
							
							int oldFirst = firstMostSold;
							int oldSecond = secondMostSold;
							
							firstMostSold = k;
							secondMostSold = oldFirst;
							thirdMostSold = oldSecond;
							
							k++;
						}
						
						else if(secondMostSold == -1 || Float.valueOf(buyerTotalAmount) >= Float.valueOf(buyerDetails[2][secondMostSold])){
							int oldSecond = secondMostSold;
							
							secondMostSold = k;
							thirdMostSold = oldSecond;
							
							k++;
						}
						
						
						else if(thirdMostSold == -1  || Float.valueOf(buyerTotalAmount) >= Float.valueOf(buyerDetails[2][thirdMostSold])){
							fourthMostSold = k;
							k++;
						}
						
						else{
							k++;
						}					
						
					}	while(bestBuyers.next());
					
					
				}
				
				
					indexes[0] = firstMostSold;
					indexes[1] = secondMostSold;
					indexes[2] = thirdMostSold;
					
					rowsPrinted = 0;
					
					for(int j=0;j<3;j++){
						
						if(indexes[j] == -1){
							continue;
						}
						
						else{
							rowsPrinted = 1;
							int indexValue = indexes[j];
							%>
							<tr>
								<td><%=buyerDetails[0][indexValue] %></td>
								<td><%=buyerDetails[1][indexValue] %></td>
								<td><%=buyerDetails[2][indexValue] %></td>
							</tr>							
							<%
							
						}
						
						
						
					}
					
					if(rowsPrinted == 0){
						%>
							<tr>
								<td><%out.println("n/a"); %></td>
								<td><%out.println("n/a"); %></td>
								<td><%out.println("n/a"); %></td>
							</tr>							
						<%
					}
				
				
				%></table>
				
				<br>
				<br>
				
				<%						
			
						
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		
			
			
		
			
			
			
			
			
			
			
			
		}
		
		catch (Exception ex){
			out.println(ex);
			session.setAttribute("createAuctionStatus","Error sales could not be found");
			//response.sendRedirect("adminPortal.jsp");	
		}
			
		%>
	
	</body>









</html>