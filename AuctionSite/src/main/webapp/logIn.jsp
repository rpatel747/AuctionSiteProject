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
			
			
			String usernameEntered = request.getParameter("logInUsername");
			String passwordEntered = request.getParameter("logInPassword");
		
		
			PreparedStatement stmt = con.prepareStatement("SELECT username,password FROM account WHERE username=? AND password=?;");
			stmt.setString(1,usernameEntered);
			stmt.setString(2,passwordEntered);
			
			
			
			ResultSet rs= stmt.executeQuery();
			
			if(!rs.next()){
				out.println("Username or password is incorrect, try again");
				response.sendRedirect("LogInPage.jsp");
			}
			else{
				session.setAttribute("username",usernameEntered);
				response.sendRedirect("Home.jsp");
			}
			
			
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	
	
	</body>









</html>