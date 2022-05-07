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


		
		
		<br>
		
		<div class="topNavBar">
			<ul>
				<li><a href="./Home.jsp">Home</a></li>
				<li><a href="./mySales.jsp">My Sales</a></li>
				<li><a href="./myBids.jsp">My Bids</a></li>
				<li><a href="./myAlerts.jsp">My Alerts</a></li>
				<li><a href="./customerServiceTab.jsp">Customer Support</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
				<li><a href="./logOut.jsp">Log Out</a><li>
			</ul>
		</div>
		
		<br>
		
		
		<h2>** To make any account changes please go to the Customer Support tab, and request the account change. ** </h2>
		<h2>** Please include the new value for the account setting you would like changed, you may also request account deletion **</h2>
				
		
		

	</body>
</html>