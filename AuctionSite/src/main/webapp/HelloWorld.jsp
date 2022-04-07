<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Auction Site</title>
	</head>
	
	<body>

		<h1> Welcome to our Sale Site!</h1>
		
		<br>
			<h2>Please Log In</h2>
			<form	method="get" action="logIn.jsp">
				<label type="text" for="logInUsername">Username</label>
				<input type="text" id="logInUsername" name="logInUsername">
				<br>
				<br>
				<label type= "text" for="logInPassword">Password:</label>
				<input type="text" id="logInPassword" name="logInPassword">
				<br>
				<br>
				<input type="submit" value="Log In">
			</form>
			
		<br>
		<br>
		<br>
		<br>
			<h2>Or Register for a Free Account</h2>
			<form method="post" action="registerAccount.jsp">
				<label type="text" for="firstName">First name:</label>
				<input type="text" id="firstName" name="firstName">
				<br>
				<br>
				<label type="text" for="lastName">Last name:</label>
				<input type="text" id="lastName" name="lastName">
				<br>
				<br>				
				<label type="text" for="email">Email:</label>
				<input type="text" id="email" name="email">
				<br>
				<br>
				<label type="text" for="dob">Date of Birth:</label>
				<input type="date" id="dob" name="dob">
				<br>
				<br>
				<label type="text" for="signUpUsername">Username:</label>
				<input type="text" id="signUpUsername" name="signUpUsername">
				<br>
				<br>
				<label type= "text" for="signUpPassword">Password:</label>
				<input type="text" id="signUpPassword" name="signUpPassword">			
				<br>
				<br>		
				<input type="submit" value="Register">
			
			
			</form>
</body>
</html>