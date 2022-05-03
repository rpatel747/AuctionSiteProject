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
				<li><a href="./Home.jsp">Home</a></li>
				<li><a href="./mySales.jsp">My Sales</a></li>
				<li><a href="./myBids.jsp">My Bids</a></li>
				<li><a href="customerServiceTab.jsp">Customer Support</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
			</ul>
		</div>
		
		<br>
		
		
		
		
		
		
		
		
		
		
		<h2>Answering your questions, and providing a great customer experience is our top goal.</h2>
		<h2>Before you send us a message, check out our FAQ for questions that customers have already asked us.</h2>
		<form method="post" action="viewFAQ.jsp">
			<input type="submit" value="Check FAQ">
		</form>
		
		
		
		
		
		
		
		
		
		
		
		<div id="myMessages">
			
			<h3>If you have any questions, or need to make any requests, then message our customer rep team.</h3>
			<h3>Use the form below</h3>
			
			
			<div id="createMessage">
			
				<h3>Send Question</h3>
				<form method="post" action="sendQuestion.jsp">
					<label for="messageTopic">Topic: </label>
					<input list="messageTopic" name="messageTopic">
					<datalist id="messageTopic">
						<option value="Reset password"></option>
						<option value="Remove Bid"></option>
						<option value="Delete Auction"></option>
						<option value="Change Account Information"></option>
						<option value="General Information"></option>
					</datalist>
					<br>
					<br>
					<label for="userMessageContent">Tell Us More:</label>
					<input type="text" name="userMessageContent">
					<br>
					<br>
					<input type="submit" value="Send">
				
				</form>	
			</div>
		
		
			<br>
			<br>
			<div id="viewMyMessages">
				<h3>In order to avoid sending duplicate questions, please check your previously send messages with their responses.</h3>
				<h3>My Previous Messages</h3>
				
				<form method="Post" action="keySearchQuestions.jsp">
					<h4>Try Searching by Key Words:</h4>
					<input type="text" name="keyWordSearch">
					<input type="submit" value="Search">
				</form>
				
				<%
					try {
						
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						
						// Get the email for the customer to make query
						String customerEmail = (String) session.getAttribute("customerEmail");
					
						PreparedStatement stmt = con.prepareStatement("SELECT * FROM questions WHERE questionID IN (SELECT questionID FROM asksQuestion WHERE email=?)");
						stmt.setString(1,customerEmail);
						ResultSet rs= stmt.executeQuery();
						
						
						if(!rs.next()){
							out.println("You have not sent any messages.");
							
						}
						else{
							
							%>
							
							<table>
								<tr>
									<th>Question ID</th>
									<th>Topic</th>
									<th>Your Message:</th>
									<th>Customer Service Response</th>
									<th>Status</th>
								</tr>
							<%
							do{
								
								

								
								String status;
								if(rs.getInt(5) == 1){
									status = "Closed";
								}
								else{
									status = "Open";
								}
								
								
								
								
								
								
								%>
								
								<tr >
									<td><%= rs.getInt(1) %></td>
									<td><%= rs.getString(2) %></td>
									<td><%= rs.getString(3) %></td>
									<td><%= rs.getString(4) %></td>
									<td><%= status %></td>		
								</tr>
								
								
								
								
								
							<%}while(rs.next());
							
							%> </table><%
							
							
							con.close();
							
						
							
							
							
							
							
							
							
							
						}
							
						
						
					
					}
					
					catch (Exception ex){

						%> <h1>Error: Previous messages could not be loaded</h1> <%
					}
			
				%>
				
				
				
			
			
			
			
			</div>
		
		
		
		
		
		
		
		
		</div>
		
		
		
		
		
		
			

	</body>
</html>