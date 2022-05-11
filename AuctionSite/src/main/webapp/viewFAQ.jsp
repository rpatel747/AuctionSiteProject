<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>FAQ</title>
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
		<h2>Please check the frequently asked questions before submitting a message to avoid overloading the system.</h2>
		

			<div id="con1">

				
				<form method="Post" action="keySearchFAQ.jsp">
					<h3>Search FAQ by keywords:</h3>
					<textarea name="keySearchFAQ" rows="2" cols="60"></textarea>
					<br>
					<br>
					<input type="submit" value="Search">
				</form>

				<br>
				<br>
				<br>
				
				<%
					try {
						
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						

					
						PreparedStatement stmt = con.prepareStatement("SELECT * FROM faqs");
						ResultSet rs= stmt.executeQuery();
						
						%>
						
						<table>
							<tr>
								<th>Topic</th>
								<th>Question</th>
								<th>Response</th>
							</tr>
						<%
						
						if(!rs.next()){
							%>
							<tr>
								<td colspan="3">No questions available</td>
							<tr>
							
							
							<%
							
						}
						else{
						
							do{
								

								
								%>
								
								<tr >
									
									<td><%= rs.getString(2) %></td>
									<td><%= rs.getString(3) %></td>
									<td><%= rs.getString(4) %></td>
										
								</tr>
								
								
								
								
								
							<%}while(rs.next());
							
							%> </table>
							
							</div><%
							
							
							con.close();
							
						
							
							
							
							
							
							
							
							
						}
					
						
						
					
					}
					
					catch (Exception ex){
						out.println(ex);
						%> <h1>Error: Messages could not be loaded</h1> <%
					}
			
				%>
				
				
				
			
			
			
			

		
		
		
		
		
		
		
		
		
		
		
		
		
		
			

	</body>
</html>