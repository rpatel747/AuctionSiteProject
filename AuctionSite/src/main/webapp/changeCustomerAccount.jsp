<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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
			
			

			
			
			String customerUsername = request.getParameter("username");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String password = request.getParameter("password");
			
			if(!firstName.equalsIgnoreCase("null")){
				PreparedStatement changeFirstName = con.prepareStatement("UPDATE customer SET firstName=? WHERE email IN (SELECT email FROM customerHas WHERE username=?)");
				changeFirstName.setString(1,firstName);
				changeFirstName.setString(2,customerUsername);
				changeFirstName.executeUpdate();
			}
			
			if(!lastName.equalsIgnoreCase("null")){
				PreparedStatement changeLastName = con.prepareStatement("UPDATE customer SET lastName=? WHERE email IN (SELECT email FROM customerHas WHERE username=?)");
				changeLastName.setString(1,lastName);
				changeLastName.setString(2,customerUsername);
				changeLastName.executeUpdate();				
			}
			
			if(!password.equalsIgnoreCase("null")){
				PreparedStatement changePassword = con.prepareStatement("UPDATE account SET password=? WHERE username=?");
				changePassword.setString(1,password);
				changePassword.setString(2,customerUsername);
				changePassword.executeUpdate();				
			}			
			

			con.close();
			response.sendRedirect(request.getHeader("referer"));
			
			

		}
		
		catch (Exception ex){
			out.println(ex);

		} 


	%>
	
	</body>









</html>