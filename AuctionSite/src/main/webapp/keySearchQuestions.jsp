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
		
					

				<%
					try {
						
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						
						// Get the email for the customer to make query
						String customerEmail = (String) session.getAttribute("customerEmail");
								
						String keyWordSearch = (String) request.getParameter("keyWordSearch");
						
						%><h2>Keyword Search for: " <% out.println(keyWordSearch);%>"</h2><%		
								
						PreparedStatement stmt = con.prepareStatement("SELECT * FROM questions WHERE questionID IN (SELECT questionID FROM asksQuestion WHERE email=?)");
						stmt.setString(1,customerEmail);
						ResultSet rs= stmt.executeQuery();
						
						%>
						<br>
						<table style="margin: 0 auto">
							<tr>
								<th>Question ID</th>
								<th>Topic</th>
								<th>Your Message:</th>
								<th>Customer Service Response</th>
								<th>Status</th>
							</tr>
						<%
						
						
						if(!rs.next()){
							out.println("You have not sent any messages.");
							
						}
						else{
							

			
							do{
								
								String[] keywords = keyWordSearch.split("\\s+");
								int numberOfKeywords = keywords.length;
																
								String combinedResult = " " + rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4);
								
								boolean show = false;
								
								int i = 0;
								while(i<numberOfKeywords){
									if(combinedResult.contains(keywords[i]) == true){
										show = true;
									}
									i++;
									
								}
								
								if(show == false){
									continue;
								}

								
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