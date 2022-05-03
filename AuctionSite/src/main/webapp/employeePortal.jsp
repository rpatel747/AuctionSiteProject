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
		<br>
		
		<div class="topNavBar">
			<ul>
				<li><a href="./employeePortal.jsp">Home</a></li>
				<li><a href="./manageCustQuestions.jsp">Manage Customer Questions</a><li>
				<li><a href="./manageAuctions.jsp">Manage Auctions</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
			</ul>
		</div>
		
		<br>
		<br>
		
		<div>
		
			<h2>Create FAQ</h2>
			<form method="post" action="createFAQ.jsp">
				<label for="topic">Topic:</label>
				<input type="text" name="topic">
				<br>
				<label for="questionContent">Question Content:</label>
				<input type="text" name="questionContent">
				<br>
				<label for="questionAnswer">Question Answer:</label>
				<input type="text" name="questionAnswer">
				<br>
				<input type="submit" value="Create FAQ">
				
			</form>
		
		
		</div>

	</body>
</html>