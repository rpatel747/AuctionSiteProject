<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Auction Site</title>	
		<style><%@include file="./CSS/styles.css"%></style>
	</head>
	
	<body>

		<h1> Welcome to our Sale Site!</h1>
		<br>
		
		
		<% 
			// If the user tries to login, but the username/password do not exist then return this error.
			String logInResult = (String) session.getAttribute("loginResult");
			String registerResult = (String) session.getAttribute("registerResult");
			if(logInResult == "Username or password is incorrect, try again."){
				%> <h2>Username or password is incorrect, try again</h2><%
				session.setAttribute("logInResult","");
				session.setAttribute("registerResult","");
			}
			
			else if(registerResult == "Username in use, pick another username" || registerResult == "Email already in use. Use a different email."	
					|| registerResult=="Username and email already belong to an account." || registerResult == "Registration successful, please log in"){
				
				
				%> <h2><%out.println(registerResult); %></h2><%
				session.setAttribute("logInResult","");
				session.setAttribute("registerResult","");
			}
			
			session.setAttribute("makeBidStatus","");
			session.setAttribute("createAuctionStatus","");
		
		%>
		
		<div id="loginBox">
			<h2>Please Log In</h2>
			<form id="login" autocomplete="off" method="get" action="logIn.jsp">
				<label type="text" for="logInUsername">Username</label>
				<input type="text" id="logInUsername" name="logInUsername" required>
				<br>
				<br>
				<label type= "text" for="logInPassword">Password:</label>
				<input type="text" id="logInPassword" name="logInPassword" required>
				<br>
				<br>
				<input type="submit" value="Log In">
			</form>
		</div>
			
		<br>
		<br>
		<br>
		<br>
		<div id="registerBox">
			<h2>Or Register for a Free Account</h2>
			<form id="register" autocomplete="off" method="post" action="registerAccount.jsp">
				<label type="text" for="firstName">First name:</label>
				<input type="text" id="firstName" name="firstName" required>
				<br>
				<br>
				<label type="text" for="lastName">Last name:</label>
				<input type="text" id="lastName" name="lastName" required>
				<br>
				<br>				
				<label type="text" for="email">Email:</label>
				<input type="text" id="email" name="email" required>
				<br>
				<br>
				<label type="text" for="dob">Date of Birth:</label>
				<input type="date" id="dob" name="dob" required>
				<br>
				<br>
				<label type="text" for="signUpUsername">Username:</label>
				<input type="text" id="signUpUsername" name="signUpUsername" required>
				<br>
				<br>
				<label type= "text" for="signUpPassword">Password:</label>
				<input type="text" id="signUpPassword" name="signUpPassword" required>			
				<br>
				<br>		
				<input type="submit" value="Register">
			</form>
			</div>
</body>
</html>