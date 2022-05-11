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
	
 
	<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			

			String customerEmail = (String) session.getAttribute("customerEmail");
			
			String carName = request.getParameter("setAlertCarName");
			String manufacturer = request.getParameter("setAlertManufacturer");
			String manufacturedYear = request.getParameter("setAlertManufacturedYear");
			String color = request.getParameter("setAlertColor");
			String mileage = request.getParameter("setAlertMileage");
			String trim = request.getParameter("setAlertTrim");
			String vehicleType = request.getParameter("saVT");
			
			if(carName.isEmpty()){
				carName = "null";
			}
			
			if(mileage.isEmpty()){
				mileage = "null";
			}
			
			if(trim.isEmpty()){
				trim = "null";
			}
			
			
			
			
			
  			PreparedStatement insertUserAlert = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
			insertUserAlert.setInt(1,0);
			insertUserAlert.setString(2,"null");
			insertUserAlert.setString(3,carName);
			insertUserAlert.setString(4,vehicleType);
			insertUserAlert.setString(5,manufacturer);
			insertUserAlert.setString(6,manufacturedYear);
			insertUserAlert.setString(7,color);
			insertUserAlert.setString(8,mileage);
			insertUserAlert.setString(9,trim);
 			insertUserAlert.setInt(10,0);
			insertUserAlert.setInt(11,1);
			insertUserAlert.setInt(12,0); 
			insertUserAlert.executeUpdate();
			
			
 			PreparedStatement getAlertID = con.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs= getAlertID.executeQuery();
			int alertID = 0;
			if(rs.next()){
				alertID = rs.getInt(1);
			}
			
			PreparedStatement updateCustomerHas = con.prepareStatement("INSERT INTO customerHasAlerts(alertID,email) VALUES(?,?)");
			updateCustomerHas.setInt(1,alertID);
			updateCustomerHas.setString(2,customerEmail);
			updateCustomerHas.executeUpdate();
			

				
				
				
				
				
				
				
			
			
			
		
				 
			con.close();
			response.sendRedirect("Home.jsp");	
			
			
			
	
	
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
			
		}

	%>




</body>
</html>