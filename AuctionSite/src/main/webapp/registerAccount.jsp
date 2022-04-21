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
			
			
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String username = request.getParameter("signUpUsername");
			String password = request.getParameter("signUpPassword");
			String dob = request.getParameter("dob");
			
			
			// Check if the username is already in the database
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM account WHERE username=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			stmt.setString(1,username);
			ResultSet rs= stmt.executeQuery();
			
			
			// Check if the email is already in the database
 			PreparedStatement stmt2 = con.prepareStatement("SELECT * FROM customerHas WHERE username=? AND email=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			stmt2.setString(1,username);
			stmt2.setString(2,email);
			ResultSet rs2= stmt2.executeQuery();
			
			// Check if the email is already in the database
 			PreparedStatement stmt3 = con.prepareStatement("SELECT * FROM customerHas WHERE email=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			stmt3.setString(1,email);
			ResultSet rs3= stmt3.executeQuery();
			
			// Check if the username is already in the database
			PreparedStatement stmt4 = con.prepareStatement("SELECT * FROM account WHERE username=?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			stmt4.setString(1,username);
			ResultSet rs4= stmt4.executeQuery();			
			
			if(rs.next() && rs2.next()){
				// The username and email already exists, return to the login page and set the error message
				session.setAttribute("registerResult","Username and email already belong to an account.");
				con.close();
				response.sendRedirect("LogInPage.jsp");
			} 
			
			else if(rs4.next()){
				
				//The username already exists in the database
				session.setAttribute("registerResult","Username in use, pick another username");
				con.close();
				response.sendRedirect("LogInPage.jsp");				
				
			}
			
			else if(rs3.next()){
				//The username already exists in the database
				session.setAttribute("registerResult","Email already in use. Use a different email.");
				con.close();
				response.sendRedirect("LogInPage.jsp");					
				
			}
			
			else{
			
				session.setAttribute("registerResult","");
				
				
				// Insert the account information into the account table
				String insert = "INSERT INTO account(username,password)" + "VALUES (?,?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1,username);
				ps.setString(2,password);
				ps.executeUpdate();
				
				// Insert the customer information into the customer table
				String insert2 = "INSERT INTO customer(email,firstName,lastName,dob) VALUES(?,?,?,?)";
				PreparedStatement ps2 = con.prepareStatement(insert2);
				ps2.setString(1,email);
				ps2.setString(2,firstName);
				ps2.setString(3,lastName);
				ps2.setDate(4,java.sql.Date.valueOf(dob));
				ps2.executeUpdate();
				
				// Insert the information for the customer account relationship into customerHas table
				String insert3 = "INSERT INTO customerHas(email,username) VALUES(?,?)";
				PreparedStatement ps3 = con.prepareStatement(insert3);
				ps3.setString(1,email);
				ps3.setString(2,username);
				ps3.executeUpdate();
				
				
				
				
	
				con.close();
				session.setAttribute("logInResult","");
				session.setAttribute("registerResult","Registration successful, please log in");
				con.close();
				response.sendRedirect("LogInPage.jsp");						

				
			}
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Account Already Exists");
		}

	%>
	
	
	
	</body>









</html>