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


		
		
		<br>
		
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
		
		<br>
		
		
		
		
		
		
		
			<% 
 			// If the user tries to login, but the username/password do not exist then return this error.
			String createAuctionStatus = (String) session.getAttribute("createAuctionStatus");
			String makeBidStatus = (String) session.getAttribute("makeBidStatus");
			
			if(!createAuctionStatus.equals("")){
				%> <h2><%out.println(createAuctionStatus);%></h2><%
				session.setAttribute("createAuctionStatus","");
			} 
			if(!makeBidStatus.equals("")){
				%> <h2><%out.println(makeBidStatus);%></h2><%
				session.setAttribute("makeBidStatus","");				
			}

 		%>
 		
 		
 		
		<form id="RefreshSales"  method="post" action="checkAuctions.jsp">
			<input type="submit" value="RefreshSales">
		</form>
		
		<div >
				
			<h2>View the Current Sales</h2>
		
			<form id="filteredSearch" method="post" action="searchFilter.jsp">
					<label for="searchCarName">Car Name:</label>
					<input type="text" name="searchCarName">
					
					
					<br>
					<br>
					<label for="searchVehicleType">Vehicle Type:</label>
 					<select name="searchVehicleType">
 						<option value="null"></option>
						<option value="Car">Car</option>
						<option value="Motorbike">Motorbike</option>				
						<option value="Truck">Truck</option>		
					</select>
					
					  	
					<br>
					<br>
					<label for="searchManufacturer">Manufacturer: </label>
					<select name="searchManufacturer">
						<option value="null"></option>
						<option value="BMW">BMW</option>
						<option value="Ford">Ford</option>
						<option value="Honda">Honda</option>
						<option value="Kia">Kia</option>
						<option value="Mercedes">Mercedes</option>			
						<option value="Toyota">Toyota</option>				
					</select>
					
					
					<br>
					<br>
					<label for="searchManufacturedYear">Manufactured Year: </label>
					<select name="searchManufacturedYear">
						<option value="null"></option>
					    <option value="2022">2022</option>
					    <option value="2021">2021</option>
					    <option value="2020">2020</option>
					    <option value="2019">2019</option>
					    <option value="2018">2018</option>
					    <option value="2017">2017</option>
					    <option value="2016">2016</option>
					    <option value="2015">2015</option>
					    <option value="2014">2014</option>
					    <option value="2013">2013</option>
					    <option value="2012">2012</option>
					    <option value="2011">2011</option>
					    <option value="2010">2010</option>
					    <option value="2009">2009</option>
					    <option value="2008">2008</option>
					    <option value="2007">2007</option>
					    <option value="2006">2006</option>
					    <option value="2005">2005</option>
					    <option value="2004">2004</option>
					    <option value="2003">2003</option>
					    <option value="2002">2002</option>
					    <option value="2001">2001</option>
					    <option value="2000">2000</option>
					    <option value="1999">1999</option>
					    <option value="1998">1998</option>
					    <option value="1997">1997</option>
					    <option value="1996">1996</option>
					    <option value="1995">1995</option>
					    <option value="1994">1994</option>
					    <option value="1993">1993</option>
					    <option value="1992">1992</option>
					    <option value="1991">1991</option>
					    <option value="1990">1990</option>
					    <option value="1989">1989</option>
					    <option value="1988">1988</option>
					    <option value="1987">1987</option>
					    <option value="1986">1986</option>
					    <option value="1985">1985</option>
					    <option value="1984">1984</option>
					    <option value="1983">1983</option>
					    <option value="1982">1982</option>
					    <option value="1981">1981</option>
					    <option value="1980">1980</option>
					    <option value="1979">1979</option>
					    <option value="1978">1978</option>
					    <option value="1977">1977</option>
					    <option value="1976">1976</option>
					    <option value="1975">1975</option>
					    <option value="1974">1974</option>
					    <option value="1973">1973</option>
					    <option value="1972">1972</option>
					    <option value="1971">1971</option>
					    <option value="1970">1970</option>
					    <option value="1969">1969</option>
					    <option value="1968">1968</option>
					    <option value="1967">1967</option>
					    <option value="1966">1966</option>
					    <option value="1965">1965</option>
					    <option value="1964">1964</option>
					    <option value="1963">1963</option>
					    <option value="1962">1962</option>
					    <option value="1961">1961</option>
					    <option value="1960">1960</option>
					    <option value="1959">1959</option>
					    <option value="1958">1958</option>
					    <option value="1957">1957</option>
					    <option value="1956">1956</option>
					    <option value="1955">1955</option>
					    <option value="1954">1954</option>
					    <option value="1953">1953</option>
					    <option value="1952">1952</option>
					    <option value="1951">1951</option>
					    <option value="1950">1950</option>
					    <option value="1949">1949</option>
					    <option value="1948">1948</option>
					    <option value="1947">1947</option>
					    <option value="1946">1946</option>
					    <option value="1945">1945</option>
					    <option value="1944">1944</option>
					    <option value="1943">1943</option>
					    <option value="1942">1942</option>
					    <option value="1941">1941</option>
					    <option value="1940">1940</option>
					</select>
					
					
					
					<br>
					<br>
					<label for="searchColor">Color: </label>
					<select name="searchColor">	
						<option value="null"></option>			
						<option value="Red">Red</option>
						<option value="Blue">Blue</option>
						<option value="Black">Black</option>
						<option value="Silver">Silver</option>
						<option value="Yellow">Yellow</option>
						<option value="Green">Green</option>			
					</select> 
					
					
					 
					<br>
					<br>				
					<label for="searchMileage">Max Mileage (miles): </label>
					<input type="text" name="searchMileage">
					
					
					<br>
					<br>				
					<label for="searchPrice">Max Price (USD): </label>
					<input type="text" name="searchPrice">
					
					
					
					<br>
					<br>
					<label for="searchTrim">Trim</label>
					<input type="text" name="searchTrim">		
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
		
		
		
		
		
		
		
		
		
		
		
		<div >
			
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
				
				
				<label for="price">Minimum Price (USD): </label>
				<input type="text" name="price">
				<br>
				<br>
				
				
				<label for="trim">Trim: </label>
				<input type="text" name="trim">
				<br>
				<br>

								
				<label for="validBidIncrement">Valid Bid Increment: </label>
				<input type="text" name="validBidIncrement">
				<br>
				<br>

				
				<label for="endDateTime">Sale End Date & Time: </label>
				<input type="datetime-local" name="endDateTime">
				
				<br>
				<br>
				<input type="submit" value="Create Sale!" class="submitButton">
			</form>
		</div>
			
		
		
		
		
			<div >
		
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
						<input type="submit" value="Make Bid" class="submitButton">
					</form>
					
					<br>
		
	
			</div>
			
			
			
			
			
			
			
			
			
			
			<div>
				
				<h2>Set Alert for Item:</h2>
			
				<form id="filteredSearch" method="post" action="setAlertFromUser.jsp">
					<label for="setAlertCarName">Car Name:</label>
					<input type="text" name="setAlertCarName">
					
					
					<br>
					<br>
					<label for="saVT">Vehicle Type:</label>
 					<select name="saVT">
 						<option value="null"></option>
						<option value="Car">Car</option>
						<option value="Motorbike">Motorbike</option>				
						<option value="Truck">Truck</option>		
					</select>
					
					  	
					<br>
					<br>
					<label for="setAlertManufacturer">Manufacturer: </label>
					<select name="setAlertManufacturer">
						<option value="null"></option>
						<option value="BMW">BMW</option>
						<option value="Ford">Ford</option>
						<option value="Honda">Honda</option>
						<option value="Kia">Kia</option>
						<option value="Mercedes">Mercedes</option>			
						<option value="Toyota">Toyota</option>				
					</select>
					
					
					<br>
					<br>
					<label for="setAlertManufacturedYear">Manufactured Year: </label>
					<select id="setAlertManufacturedYear" name="setAlertManufacturedYear">
						<option value="null"></option>
					    <option value="2022">2022</option>
					    <option value="2021">2021</option>
					    <option value="2020">2020</option>
					    <option value="2019">2019</option>
					    <option value="2018">2018</option>
					    <option value="2017">2017</option>
					    <option value="2016">2016</option>
					    <option value="2015">2015</option>
					    <option value="2014">2014</option>
					    <option value="2013">2013</option>
					    <option value="2012">2012</option>
					    <option value="2011">2011</option>
					    <option value="2010">2010</option>
					    <option value="2009">2009</option>
					    <option value="2008">2008</option>
					    <option value="2007">2007</option>
					    <option value="2006">2006</option>
					    <option value="2005">2005</option>
					    <option value="2004">2004</option>
					    <option value="2003">2003</option>
					    <option value="2002">2002</option>
					    <option value="2001">2001</option>
					    <option value="2000">2000</option>
					    <option value="1999">1999</option>
					    <option value="1998">1998</option>
					    <option value="1997">1997</option>
					    <option value="1996">1996</option>
					    <option value="1995">1995</option>
					    <option value="1994">1994</option>
					    <option value="1993">1993</option>
					    <option value="1992">1992</option>
					    <option value="1991">1991</option>
					    <option value="1990">1990</option>
					    <option value="1989">1989</option>
					    <option value="1988">1988</option>
					    <option value="1987">1987</option>
					    <option value="1986">1986</option>
					    <option value="1985">1985</option>
					    <option value="1984">1984</option>
					    <option value="1983">1983</option>
					    <option value="1982">1982</option>
					    <option value="1981">1981</option>
					    <option value="1980">1980</option>
					    <option value="1979">1979</option>
					    <option value="1978">1978</option>
					    <option value="1977">1977</option>
					    <option value="1976">1976</option>
					    <option value="1975">1975</option>
					    <option value="1974">1974</option>
					    <option value="1973">1973</option>
					    <option value="1972">1972</option>
					    <option value="1971">1971</option>
					    <option value="1970">1970</option>
					    <option value="1969">1969</option>
					    <option value="1968">1968</option>
					    <option value="1967">1967</option>
					    <option value="1966">1966</option>
					    <option value="1965">1965</option>
					    <option value="1964">1964</option>
					    <option value="1963">1963</option>
					    <option value="1962">1962</option>
					    <option value="1961">1961</option>
					    <option value="1960">1960</option>
					    <option value="1959">1959</option>
					    <option value="1958">1958</option>
					    <option value="1957">1957</option>
					    <option value="1956">1956</option>
					    <option value="1955">1955</option>
					    <option value="1954">1954</option>
					    <option value="1953">1953</option>
					    <option value="1952">1952</option>
					    <option value="1951">1951</option>
					    <option value="1950">1950</option>
					    <option value="1949">1949</option>
					    <option value="1948">1948</option>
					    <option value="1947">1947</option>
					    <option value="1946">1946</option>
					    <option value="1945">1945</option>
					    <option value="1944">1944</option>
					    <option value="1943">1943</option>
					    <option value="1942">1942</option>
					    <option value="1941">1941</option>
					    <option value="1940">1940</option>
					</select>
					
					
					
					<br>
					<br>
					<label for="setAlertColor">Color: </label>
					<select name="setAlertColor">	
						<option value="null"></option>			
						<option value="Red">Red</option>
						<option value="Blue">Blue</option>
						<option value="Black">Black</option>
						<option value="Silver">Silver</option>
						<option value="Yellow">Yellow</option>
						<option value="Green">Green</option>			
					</select> 
					
					
					 
					<br>
					<br>				
					<label for="setAlertMileage">Max Mileage (miles): </label>
					<input type="text" name="setAlertMileage">
					
					
					
					<br>
					<br>
					<label for="setAlertTrim">Trim</label>
					<input type="text" name="setAlertTrim">
					
					
					<br>
					<br>		
					<input type="submit" value="Set Alert" class="submitButton">
				</form>			
			
			
			
			
			</div>
				
		
		

	</body>
</html>