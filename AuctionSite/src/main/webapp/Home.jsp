<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Home</title>
		<style><%@include file="./CSS/styles.css"%></style>
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
		<br>
		
		<div id="MySales">
			<h2>My Sales</h2>
			
			<%
			
			
			
			
			
			
			
			
			
			
			
			
			
			%>
		
		</div>
		
		<br>
		<br>
			
			
		<div id="MyBids">
			<h2>My Bids</h2>
		
		</div>
		

	</body>
</html>