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
			String username = request.getParameter("username");
			int employeeID = Integer.parseInt(request.getParameter("employeeID"));
			
			String deleteFromEmployeeHas = "DELETE FROM employeeHas WHERE employeeID=?";
			PreparedStatement pst3 = con.prepareStatement(deleteFromEmployeeHas);
			pst3.setInt(1,employeeID);
			pst3.executeUpdate();	
			
			
			String deleteFromAccount = "DELETE FROM account WHERE username=?";
			PreparedStatement pst1 = con.prepareStatement(deleteFromAccount);
			pst1.setString(1,username);
			pst1.executeUpdate();
			
			
			String deleteFromEmployee = "DELETE FROM employee WHERE employeeID=?";
			PreparedStatement pst2 = con.prepareStatement(deleteFromEmployee);
			pst2.setInt(1,employeeID);
			pst2.executeUpdate();			
						
			
					
			
			

			con.close();
			
			response.sendRedirect("adminPortal.jsp");
		
		}
		
		catch (Exception ex){
			//out.print(ex);
			out.print("Account was not deleted");
		}

	%>
	
	
	
	</body>









</html>