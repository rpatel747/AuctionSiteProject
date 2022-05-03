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
		<h2>Please check the frequently asked questions before submitting a message to avoid overloading the system.</h2>
		

			<div id="viewMyMessages">

				
				<form method="Post" action="keySearchFAQ.jsp">
					<h4>Search FAQ by keywords:</h4>
					<input type="text" name="keySearchFAQ">
					<input type="submit" value="Search">
				</form>
				
				<%
					try {
						
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						

					
						PreparedStatement stmt = con.prepareStatement("SELECT * FROM faqs");
						ResultSet rs= stmt.executeQuery();
						
						
						if(!rs.next()){
							out.println("No Questions Available");
							
						}
						else{
							
							%>
							
							<table>
								<tr>
									<th>Topic</th>
									<th>Question</th>
									<th>Response</th>
								</tr>
							<%
							do{
								

								
								%>
								
								<tr >
									
									<td><%= rs.getString(2) %></td>
									<td><%= rs.getString(3) %></td>
									<td><%= rs.getString(4) %></td>
										
								</tr>
								
								
								
								
								
							<%}while(rs.next());
							
							%> </table><%
							
							
							con.close();
							
						
							
							
							
							
							
							
							
							
						}
							
						
						
					
					}
					
					catch (Exception ex){
						out.println(ex);
						%> <h1>Error: Messages could not be loaded</h1> <%
					}
			
				%>
				
				
				
			
			
			
			
			</div>
		
		
		
		
		
		
		
		
		</div>
		
		
		
		
		
		
			

	</body>
</html>