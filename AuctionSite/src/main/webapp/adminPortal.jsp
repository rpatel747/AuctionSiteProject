<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Home</title>
		<style><%@include file="./CSS/home.css"%></style>
	</head>
	
	<body>
	

		<h1><%
		String username = (String) session.getAttribute("username");
		out.println("Welcome " + username +"!");
		%></h1>
		
		<form id="logOutButton"  method="post" action="logOut.jsp">
			<input type="submit" value="Log Out">
		</form>
		
		
		<br>
		
		<div class="topNavBar">
			<ul>
				<li><a href="./adminPortal.jsp">Manage Employees</a></li>
				<li><a href="./mySales.jsp">Sales Information</a></li>
			</ul>
		</div>
		
		<br>
		
		<div class="cotainer">
		
			<h2>Current Employees</h2>
		
			<% 
				try {
					
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					
				
				
					PreparedStatement stmt = con.prepareStatement("SELECT * FROM employee");
				
					ResultSet rs= stmt.executeQuery();
					
					if(!rs.next()){
						%> <h3>No employees exist</h1> <%
					}
					else{
						
						%>
						
	
						
						
						<table>
							<tr>
								<th>Employee ID</th>
								<th>First Name</th>
								<th>Last Name</th>
							</tr>
						<%
						do{
							
							%>
							
							<tr>
								<td><%= rs.getString(1) %></td>
								<td><%= rs.getString(2) %></td>
								<td><%= rs.getString(3) %></td>
								
							</tr>
							
							
							
							
							
						<%}while(rs.next());
						
						%> </table><%
						
						
						con.close();
						

					}
					

				}
				
				catch (Exception ex){
					out.print(ex);
					out.print("Query failed :()");
				}
		
			%>
		
		
		
		
		
		
		
		
		
		
		
		</div>


		<div class="container">
		
			<h2>Add An Employee:</h2>
			
			<form id="createEmployee" autocomplete="off" method="POST" action="createEmployee.jsp">
			
				<label for="firstName">First Name: </label>
				<input type="text" name="firstName" required>
				<br>
				<br>
				<label for="lastName">Last Name: </label>
				<input type="text" name="lastName" required>
				<br>
				<br>

				<label for="username">Username: </label>
				<input type="text" name="username" required>
				<br>
				<br>
				<label for="password">Password: </label>
				<input type="text" name="password" required>			
				<br>
				<br>					
				<input type="submit" value="Submit">
			</form>
		
		</div>
	
	
		<div class="container">
	
		
			<h2>Delete Employee:</h2>
			
			<form id="deleteEmployee" autocomplete="off" method="POST" action="deleteEmployee.jsp">
			
				<label for="firstName">First Name: </label>
				<input type="text" name="firstName" required>
				<br>
				<br>
				<label for="lastName">Last Name: </label>
				<input type="text" name="lastName" required>
				<br>
				<br>
				<label for="employeeID">EmployeeID: </label>
				<input type="text" name="employeeID" required>
				<br>
				<br>				
				<label for="username">Username: </label>
				<input type="text" name="username" required>
				<br>
				<br>			
				<input type="submit" value="Submit">
			</form>
		
		
		
		
		
		</div>

	</body>
</html>