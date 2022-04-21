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
			
			
			// Get the username and passsword entered by the user
			String usernameEntered = request.getParameter("logInUsername");
			String passwordEntered = request.getParameter("logInPassword");
		
			
			// Query the database for username and password that match the ones that were given
			PreparedStatement stmt = con.prepareStatement("SELECT username,password FROM account WHERE username=? AND password=?;");
			stmt.setString(1,usernameEntered);
			stmt.setString(2,passwordEntered);
			
			
			
			ResultSet rs= stmt.executeQuery();
			
			
			if(!rs.next()){
				// The username or password entered due not match any results in the database, try again
				session.setAttribute("loginResult","Username or password is incorrect, try again.");
				con.close();
				response.sendRedirect("LogInPage.jsp");
			}
			else{
				session.setAttribute("makeBidStatus","");
				session.setAttribute("createAuctionStatus","");
				// Login successful, set the loginResult to null string
				session.setAttribute("loginResult","");
				
				
				
				// The username matched, therefore set the username for the current session
				session.setAttribute("username",usernameEntered);
				
						
						
				// Determine if the user is a customer, a employee or an admin
				
				
				// Query the customer table to see if the user is a customer
				PreparedStatement customerQuery = con.prepareStatement("SELECT username FROM customerHas WHERE username=?");
				customerQuery.setString(1,usernameEntered);
				ResultSet rs3 = customerQuery.executeQuery();
				
				// Query the employee table to see if the user is a employee
				PreparedStatement employeeQuery = con.prepareStatement("SELECT username FROM employeeHas WHERE username=?");
				employeeQuery.setString(1,usernameEntered);
				ResultSet rs4 = employeeQuery.executeQuery();				
				
				// Query the admin table to see if the user is a employee
				PreparedStatement adminQuery = con.prepareStatement("SELECT username FROM adminHas WHERE username=?");
				adminQuery.setString(1,usernameEntered);
				ResultSet rs5 = adminQuery.executeQuery();					
				
				
				if(rs3.next()){
					
					// The username entered matches a customer
					// Query the customerHas table to get the customer's email
					// Set the userType attribute as a customer
					
		 			PreparedStatement stmt2 = con.prepareStatement("SELECT email FROM customerHas WHERE username=?");
					stmt2.setString(1,usernameEntered);
					rs= stmt2.executeQuery();
					String customerEmail = "";
					if(rs.next()){
						customerEmail = rs.getString(1);
						session.setAttribute("customerEmail",customerEmail);
						session.setAttribute("employeeID",0);
						session.setAttribute("adminID",0);
						
						session.setAttribute("userType","customer");
					}
				
					
					con.close();
					
					
					response.sendRedirect("Home.jsp");					
					
				}
				
				else if(rs4.next()){
					
					// The username eneted matches that of an employee
					// Query the employeeHas table to get the corresponding employeeID
					// Set the employeeID 
					
		 			PreparedStatement stmt2 = con.prepareStatement("SELECT employeeID FROM employeeHas WHERE username=?");
					stmt2.setString(1,usernameEntered);
					rs = stmt2.executeQuery();
					int employeeID = 0;
					if(rs.next()){
						employeeID = rs.getInt(1);
						session.setAttribute("customerEmail","NULL");
						session.setAttribute("employeeID",employeeID);
						session.setAttribute("adminID",0);
						
						session.setAttribute("userType","employee");
					}					
					
					
					
					con.close();
					
					
					response.sendRedirect("employeePortal.jsp");						
					
				}
				
				
				else if(rs5.next()){
					
					
					// The username eneted matches that of an employee
					// Query the employeeHas table to get the corresponding employeeID
					// Set the employeeID 
					
		 			PreparedStatement stmt2 = con.prepareStatement("SELECT employeeID FROM adminHas WHERE username=?");
					stmt2.setString(1,usernameEntered);
					rs = stmt2.executeQuery();
					int employeeID = 0;
					if(rs.next()){
						employeeID = rs.getInt(1);
						session.setAttribute("customerEmail","NULL");
						session.setAttribute("employeeID",employeeID);
						session.setAttribute("adminID",1);
						
						session.setAttribute("userType","admin");
					}
					
					
					
					con.close();
					
					
					response.sendRedirect("adminPortal.jsp");					
					
					
				}
						
				
			}
	
			
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	
	
	</body>









</html>