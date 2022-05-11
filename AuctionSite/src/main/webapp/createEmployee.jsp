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
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			// Insert the account information into the account table
			String insert = "INSERT INTO account(username,password) VALUES(?,?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1,username);
			ps.setString(2,password);
			ps.executeUpdate();
			
			// Insert the customer information into the customer table
			String insert2 = "INSERT INTO employee(employeeID,firstName,lastName) VALUES(?,?,?)";
			PreparedStatement ps2 = con.prepareStatement(insert2);
			ps2.setInt(1,0);
			ps2.setString(2,firstName);
			ps2.setString(3,lastName);

			ps2.executeUpdate();
			
			// Insert the information for the customer account relationship into customerHas table
 			PreparedStatement ps3 = con.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs= ps3.executeQuery();
			int employeeID = 0;
			if(rs.next()){
				employeeID = rs.getInt(1);
				
				String insert4 = "INSERT INTO employeeHas(employeeID,username) VALUES(?,?)";
				PreparedStatement ps4 = con.prepareStatement(insert4);
				ps4.setInt(1,employeeID);
				ps4.setString(2,username);
				ps4.executeUpdate();
			}	
			
					
			
			

			con.close();
			
			response.sendRedirect("adminPortal.jsp");
		
		}
		
		catch (Exception ex){
			//out.print(ex);
			out.print("Account Already Exists");
		}

	%>
	
	
	
	</body>









</html>