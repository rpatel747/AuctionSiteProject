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
		
	</head>
	
	
	<body>
		<%
		try {
			
 			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			

			String customerEmail = (String) session.getAttribute("customerEmail");
			
			String manufacturedYear = request.getParameter("manufacturedYear");
			String carName = request.getParameter("carName");
			String manufacturer = request.getParameter("manufacturer");
			String mileage = request.getParameter("mileage");
			String currentPrice = request.getParameter("price");
			String trim = request.getParameter("trim");
			String vehicleType = request.getParameter("vehicleType");
			String color = request.getParameter("color");
			
			String endDateTime = request.getParameter("endDateTime");
			String saleEndDateTime = (endDateTime.replace('T',' ')) + ":00";
			
			String validBidIncrement = request.getParameter("validBidIncrement");
			String minimumPrice = currentPrice;
			
		
			
	
			
			
			
			
			
			
			// Take the given information about the sale, and insert it into the database to register the sale

			String insert = "INSERT INTO sale(saleNumber,carName,manufactureYear,manufacturer,mileage,currentPrice,trim,vehicleType,color,end,validBidIncr,minimumPrice) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
	
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1,0);
			ps.setString(2,carName);
			ps.setInt(3,Integer.parseInt(manufacturedYear));
			ps.setString(4,manufacturer);
			ps.setInt(5,Integer.parseInt(mileage));
			ps.setFloat(6,Float.parseFloat(currentPrice));
			ps.setString(7,trim);
			ps.setString(8,vehicleType);
			ps.setString(9,color);
			ps.setTimestamp(10,java.sql.Timestamp.valueOf(saleEndDateTime));
			ps.setFloat(11,Float.parseFloat(validBidIncrement));
			ps.setFloat(12,Float.parseFloat(minimumPrice));
			
			
			ps.executeUpdate(); 
			
			
			
			
			// Query the database to get the saleNumber for the sale from above, and add it to the insert
			
 			PreparedStatement stmt = con.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs= stmt.executeQuery();
			int currentSaleNumber = 0;
			if(rs.next()){
				currentSaleNumber = rs.getInt(1);
			}
			
			String insert2 = "INSERT INTO sells(email,saleNumber,saleStatus,soldPrice) VALUES(?,?,?,?)";
			
			PreparedStatement ps2 = con.prepareStatement(insert2);
			ps2.setString(1,customerEmail);
			ps2.setInt(2,currentSaleNumber);
			ps2.setInt(3,0);
			ps2.setInt(4,0);
			ps2.executeUpdate();
			
			
			PreparedStatement checkAlerts = con.prepareStatement("SELECT * FROM alerts WHERE setBy=1");
			ResultSet checkAlertsResult = checkAlerts.executeQuery();
			
			if(checkAlertsResult.next()){
				
				
				
				do{
					
					int alertMatchesSale = 1;
					int alertID = checkAlertsResult.getInt(1);
					String[] saleParameters = new String[11];
					saleParameters[3] = carName; // Car name
					saleParameters[4] = vehicleType; // Vehicle Type
					saleParameters[5] = manufacturer; // Manufacturer
					saleParameters[6] = manufacturedYear; // Manufactured Year
					saleParameters[7] = color; // Color
					saleParameters[8] = mileage; // Mileage
					saleParameters[9] = trim; // Trim
					
					for(int i = 3;i<10;i++){
						
						if(i == 8 && !checkAlertsResult.getString(i).equals("null")){
							float cp = Float.valueOf(mileage);
							float ap = Float.valueOf(saleParameters[8]);
							
							
							if(cp<=ap){
								continue;
							}
							
							else{
								alertMatchesSale = 0;
								continue;
							}
						}
						
						if(checkAlertsResult.getString(i).equals("null") || checkAlertsResult.getString(i).isEmpty()){
							continue;
						}
						
						
						 
						if(!saleParameters[i].equals(checkAlertsResult.getString(i))){
							alertMatchesSale = 0;
						}
						
						
					}
					
					if(alertMatchesSale == 1){
		
						PreparedStatement updateAlertsShowAlert = con.prepareStatement("UPDATE alerts SET showAlert=? WHERE alertID=?");
						updateAlertsShowAlert.setInt(1,1);
						updateAlertsShowAlert.setInt(2,alertID);
						updateAlertsShowAlert.executeUpdate();
						
						PreparedStatement updateAlertsShowAlert1 = con.prepareStatement("UPDATE alerts SET alertContent=? WHERE alertID=?");
						String show = "A car that you have set an alert for has become avilable, please check auction #" + currentSaleNumber;
						updateAlertsShowAlert1.setString(1,show);
						updateAlertsShowAlert1.setInt(2,alertID);
						updateAlertsShowAlert1.executeUpdate();
						
						PreparedStatement updateAlertsSetBy = con.prepareStatement("UPDATE alerts SET setBy=? WHERE alertID=?");
						updateAlertsSetBy.setInt(1,3);
						updateAlertsSetBy.setInt(2,alertID);
						updateAlertsSetBy.executeUpdate();
						
						
					}
					
					
					
				} while(checkAlertsResult.next());
				
				
				
				
				
				
				
				
			}
			
			
			
			

			
			
			session.setAttribute("createAuctionStatus","Auction successfully created, auction sale number: " + currentSaleNumber);
			con.close();
			response.sendRedirect("Home.jsp");	
		
		
		}
		
		catch (Exception ex){
			out.println(ex);
			session.setAttribute("createAuctionStatus","Error auction not created");
			//response.sendRedirect("Home.jsp");	
		}

	%>
	
		<h1>Your sale was created successfully!</h1>
	
	
	</body>









</html>