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
		
					

				<%
					try {
						
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						

								
						String keyWordSearch = (String) request.getParameter("keySearchFAQ");
						
						%><h2>Keyword Search in FAQ for: " <% out.println(keyWordSearch);%>"</h2><%		
								
						PreparedStatement stmt = con.prepareStatement("SELECT * FROM faqs");
						ResultSet rs= stmt.executeQuery();
						
						
						
						if(!rs.next()){
							out.println("No match was found for the given keywords");
							
						}
						else{
							

							
							%>
							
							<table>
								<tr>

									<th>Topic</th>
									<th>Your Message:</th>
									<th>Customer Service Response</th>

								</tr>
							<%
							do{
								
								String[] keywords = keyWordSearch.split("\\s+");
								int numberOfKeywords = keywords.length;
																
								String combinedResult = rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4);
								
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

						%> <h1>Error: Previous messages could not be loaded</h1> <%
					}
			
				%>
				
				
				
			
			
			
			
			</div>
		
		
		
		
		
		
		
		
		</div>
		
		
		
		
		
		
			

	</body>
</html>