<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Service</title>
		<style><%@include file="./CSS/home.css"%></style>
	</head>
	
	<body>
	
	
		
		<div class="topNavBar">
			<ul>
				<li><a href="./checkAuctionsHome.jsp">Home</a></li>
				<li><a href="./checkAuctionsMySales.jsp">My Auctions</a></li>
				<li><a href="./checkAuctionsMyBids.jsp">My Bids</a></li>
				<li><a href="./checkAuctionsMyAlerts.jsp">My Alerts</a></li>
				<li><a href="./checkAuctionsCustomerService.jsp">Customer Support</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
				<li><a href="./logOut.jsp">Log Out</a><li>
			</ul>
		</div>
		
		<br>
		
		
		
		
		
		
		
		
		
		<h2>Answering your questions, and providing a great customer experience is our top goal.</h2>
		<h2>Before you send us a message, check out our FAQ for questions that customers have already asked us.</h2>
			<form method="post" action="viewFAQ.jsp">
				<input type="submit" value="Check FAQ">
			</form>	

		
		<br>
		<br>
		
		
		
		
		
		

			
			<h3>If you have any questions, or need to make any requests, then message our customer rep team. Use the form below</h3>
			
			
			
				<h2>Send Question</h2>
				<div id="con">
					<form method="post" action="sendQuestion.jsp">
						<label for="messageTopic">Topic: </label>
						<br>
						<select name="messageTopic">
							<option value="Reset password">Reset Password</option>
							<option value="Change First Name">Change First Name</option>
							<option value="Change Last Name">Change Last Name</option>
							<option value="Remove Bid">Remove Bid (include Auction #)</option>
							<option value="Delete Auction">Delete Auction (include Auction #)</option>
							<option value="Delete Account">Delete Account (inlcude your username and email)</option>
							<option value="General Information">General Information</option>
							<option value="Other">Other</option>
						</select>
						<br>
						<br>
						<label for="userMessageContent">Tell Us More:</label>
						<br>
						<textarea id="userMessageContent" name="userMessageContent" rows="2" COLS="60"></textarea>
						<br>
						<br>
						<input type="submit" value="Send">
					
					</form>
				</div>
			
		
			<div id="con">
				<br>
				<br>
				<h2>Try Searching by Key Words:</h2>
	
				<form method="Post" action="keySearchQuestions.jsp">
					<textarea id="keyWordSearch" name="keyWordSearch" rows="1" COLS="60"></textarea>
					<br>
					<br>
					<input type="submit" value="Search">
				</form>
			</div>		
				
		
		
		
		
		
		
			<br>
			<br>

				<h3>** In order to avoid sending duplicate questions, please check your previously send messages with their responses. **</h3>
				<h3>My Previous Messages</h3>

						
							
				<table style="margin: 0 auto">
					<tr>
						<th>Question ID</th>
						<th>Topic</th>
						<th>Your Message:</th>
						<th>Customer Service Response</th>
						<th>Status</th>
					</tr>
	
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
							%>
							
							<tr>
								<td colspan="5">No messages have been sent</td>
							<tr>
							
						
													
							<%
							
						}
						else{
						
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
				
				<br>
				<br>
				<br>
				
			
			
		

		
		
		
		
		
		
		
		
			

	</body>
</html>