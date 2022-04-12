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
			

			
			
			
			String[] vehicleType = request.getParameterValues("vehicleType");
			String manufacturer = request.getParameter("manufacturer");
			String manufacturedYear = request.getParameter("manufacturedYear");
			String[] color = request.getParameterValues("color");
			String mileage = request.getParameter("mileage");
			String price = request.getParameter("price");
			String validBidIncrement = request.getParameter("validBidIncrement");
			String trim = request.getParameter("trim");
			
			
			
			
			String saleEndDateTime = request.getParameter("endDateTime");
			String sEDT = "";
			for(int i =0;i<saleEndDateTime.length();i++){
				if((saleEndDateTime.charAt(i)) == 'T'){
					char space = ' ';
					sEDT = sEDT + space;
				}
				else{
					sEDT = sEDT + saleEndDateTime.charAt(i);
				}
				
			}
			
			String ss = ":00";
			sEDT = sEDT + ss;
			
			String insert = "INSERT INTO sale(saleNumber,manufactureYear,manufacturer,price,trim,subcategory,color,end,validBidIncr,minimumPrice) VALUES(?,?,?,?,?,?,?,?,?,?)";
	
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1,0);
			ps.setString(2,manufacturedYear);
			ps.setInt(3,Integer.parseInt(manufacturedYear));
			ps.setFloat(4,Float.parseFloat(price));
			ps.setString(5,trim);
			ps.setString(6,vehicleType[0]);
			ps.setString(7,color[0]);
			ps.setTimestamp(8,java.sql.Timestamp.valueOf(sEDT));
			ps.setFloat(9,Float.parseFloat(validBidIncrement));
			ps.setFloat(10,Float.parseFloat(price));
			
			
			
			ps.executeUpdate();
			

			con.close();
			
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	
	
	
	</body>









</html>