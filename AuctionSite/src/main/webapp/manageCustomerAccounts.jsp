<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Accounts</title>
		<style><%@include file="./CSS/home.css"%></style>
	</head>
	
	<body>
	
		
		<div class="topNavBar">
			<ul>
				<li><a href="./employeePortal.jsp">Home</a></li>
				<li><a href="./manageCustQuestions.jsp">Manage Customer Questions</a><li>
				<li><a href="./manageAuctions.jsp">Manage Auctions</a><li>
				<li><a href="./manageCustomerAccounts.jsp">Manage Customer Accounts</a><li>
				<li><a href="./logOut.jsp">Log Out</a></li>
			</ul>
		</div>
		
		<br>
		<br>
		
		
		
		<div>
		
			<h2>Change Customer Account Details</h2>
			<h3>** Enter null for values that you don't want changed **</h3>
			<form method="post" action="changeCustomerAccount.jsp">
				<label for="username">Customer Username:</label>
				<select name="username">
			
				
					<%
						
				 		try {
							
				 			ApplicationDB db = new ApplicationDB();
							Connection con = db.getConnection();
							
							
				
							
						  	// Prepare the statement to insert the question into the database
							PreparedStatement getUsers = con.prepareStatement("SELECT username FROM customerHas");
							ResultSet rs = getUsers.executeQuery();
							
							String[] userInfo = new String[2000];
							int numberOfUsers = 0;
							
							while(rs.next()){
								
								userInfo[numberOfUsers]=rs.getString(1);
								numberOfUsers++;
								
							}
							
							
							int i = 0;
							while(i<numberOfUsers){
								
								%><option value="<%= userInfo[i].toString()%>"><%= userInfo[i].toString()%></option> <%
								i++;
							}
							
							
							
				
							con.close();
	
							
							
				
						}
						
						catch (Exception ex){
							out.println(ex);
				
						} 
				
				
					
	
					%>

				</select>
				<br>
				<br>
			
				<label for="firstName">New First Name:</label>
				<input type="text" name="firstName" required>
				<br>
				<br>
				
				<label for="lastName">New Last Name:</label>
				<input type="text" name="lastName" required>
				<br>
				<br>

				
				<label for="password">New Password:</label>
				<input type="text" name="password" required>
				<br>
				<br>
				
				<input type="submit" value="makeChanges">
			
			</form>
		
		
		</div>




		<div>
		
			<h2>Delete Customer Account</h2>
			<form method="post" action="deleteCustomerAccount.jsp">
				<label for="deleteUsername">Customer Username:</label>
				<select name="deleteUsername">
			
				
					<%
						
				 		try {
							
				 			ApplicationDB db = new ApplicationDB();
							Connection con = db.getConnection();
							
							
				
							
						  	// Prepare the statement to insert the question into the database
							PreparedStatement getUsers = con.prepareStatement("SELECT username FROM customerHas");
							ResultSet rs = getUsers.executeQuery();
							
							String[] userInfo = new String[2000];
							int numberOfUsers = 0;
							
							while(rs.next()){
								
								userInfo[numberOfUsers]=rs.getString(1);
								numberOfUsers++;
								
							}
							
							
							int i = 0;
							while(i<numberOfUsers){
								
								%><option value="<%= userInfo[i].toString()%>"><%= userInfo[i].toString()%></option> <%
								i++;
							}
							
							
							
				
							con.close();
	
							
							
				
						}
						
						catch (Exception ex){
							out.println(ex);
				
						} 
				
				
					
	
					%>

				</select>
				<br>
				<br>

				
				<input type="submit" value="makeChanges">
			
			</form>
		
		
		</div>



	</body>
</html>