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
	

		<div class="topNavBar" id=".center">
			<ul>
				<li><a href="./adminPortal.jsp">Home</a></li>
				<li><a href="./logOut.jsp">Log Out</a></li>
			</ul>
		</div>
		
		<br>
		
		<div>
		
			<h2>Current Employees</h2>
		
			<% 
				try {
					
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					
				
				
					PreparedStatement stmt = con.prepareStatement("SELECT * FROM employee INNER JOIN employeeHas ON employee.employeeID = employeeHas.employeeID");
				
					ResultSet rs= stmt.executeQuery();
					
					if(!rs.next()){
						%> <h3>No employees exist</h1> <%
					}
					else{
						
						%>
						
	
						
						
						<table style="margin: 0 auto;">
							<tr>
								<th>Employee ID</th>
								<th>Username</th>
								<th>First Name</th>
								<th>Last Name</th>
							</tr>
						<%
						do{
							
							%>
							
							<tr>
								<td><%= rs.getString(1) %></td>
								<td><%= rs.getString(5) %></td>
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
		
		<br>
		<br>


		<div class="container5">
		
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
	
		<br>
		<br>
		
		<div class="container5">
	
	
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
		
		
		<br>
		<br>
		
		
		<div class="container6">
		
			<h2>Sales Report</h2>
			
			<form id="generateSales" method="POST" action="checkAuctionsGenerateSales.jsp">
			
				<input type="submit" value="Generate Report">
			
			
			
			</form>
		
		
		
		
		</div>
		
		
		
		<br>
		<br>
		<br>
		
		

	</body>
</html>