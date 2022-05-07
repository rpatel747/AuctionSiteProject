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


	</body>
</html>