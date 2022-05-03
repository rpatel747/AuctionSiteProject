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
				<li><a href="./manageBids.jsp">Manage Bids</a><li>
				<li><a href="./accountSettings.jsp">Account Settings</a></li>
			</ul>
		</div>
		
		<br>
		<br>
		
		<div>
			<h2>Answer Question Form</h2>
			<form method="post" action="answerQuestion.jsp">
				<label for="questionID">Question ID:</label>
				<input type="text" name="questionID">
				<br>
				<br>
				<label for="reply">Reply:</label>
				<input type="text" name="reply">
				<br>
				<br>
				<input type="submit" value="Submit Reply">
			</form>
		</div>
		
			<h2>Open/Unanswered Customer Messages</h2>
		
		
		
		
		<div id="showAllQuestions">
		
				<%
					try {
						
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();

					
						PreparedStatement stmt = con.prepareStatement("SELECT * FROM questions WHERE status=0");
						ResultSet rs= stmt.executeQuery();
						
						
						if(!rs.next()){
							out.println("All customer questions have been answered.");
							
						}
						else{
							
							%>
							
							<table>
								<tr>
									<th>Question ID</th>
									<th>Topic</th>
									<th>Customers Question:</th>
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

	</body>
</html>