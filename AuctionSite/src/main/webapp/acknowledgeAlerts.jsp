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
			
			PreparedStatement alertAcknowledged = con.prepareStatement("UPDATE alerts SET acknowledged=? WHERE acknowledged=0 AND alertID IN(SELECT alertID FROM customerHasAlerts WHERE email=?)");
			alertAcknowledged.setInt(1,1);
			alertAcknowledged.setString(2,customerEmail);
			alertAcknowledged.executeUpdate();
	
			con.close();
			response.sendRedirect(request.getHeader("referer"));				
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>




</body>
</html>