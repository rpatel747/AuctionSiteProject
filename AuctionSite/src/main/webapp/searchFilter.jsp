<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			
			String searchCriteria = new String[8];
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
				
				
				do{
					
					String salesResult = new String[8];
					salesResult[0] = sales.getString(2);
					salesResult[1] = sales.getString(3);
					salesResult[2] = sales.getString(4);
					salesResult[3] = sales.getString(5);
					salesResult[4] = sales.getString(6);
					salesResult[5] = sales.getString(7);
					salesResult[6] = sales.getString(8);
					salesResult[7] = sales.getString(9);
					
					
					
					
					
				}	while(sales.next());
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
			}
			
		}
	
	
		catch (Exception ex){
			out.println(ex);
			session.setAttribute("createAuctionStatus","Error auction not created");
			//response.sendRedirect("Home.jsp");	
		}
	
	%>


</body>
</html>