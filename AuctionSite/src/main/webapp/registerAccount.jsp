<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">		
		
	</head>
	
	
	<body>
		<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String username = request.getParameter("signUpUsername");
			String password = request.getParameter("signUpPassword");
			String dob = request.getParameter("dob");
			
			String insert = "INSERT INTO account(username,password)" + "VALUES (?,?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1,username);
			ps.setString(2,password);
			ps.executeUpdate();
			
			con.close();
			
			out.print("Registration Sucessful");
		
		}
		
		catch (Exception ex){
			//out.print(ex);
			out.print("Account Already Exists");
		}

	%>
	
	
	
	</body>









</html>