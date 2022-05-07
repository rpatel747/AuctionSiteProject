<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>My Alerts</title>
		<style><%@include file="./CSS/searches.css"%></style>
</head>

<body>

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
		<br>
		<form method="POST" action="acknowledgeAlerts.jsp">
			<input type="submit" value="Acnowledge Alerts">
		</form>

 		
 		<h2>New Alerts</h2>
 		
 		<%
 			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
 		
			
			String customerEmail = (String) session.getAttribute("customerEmail");
			
			
			PreparedStatement getNewAlerts = con.prepareStatement("SELECT * FROM alerts WHERE showAlert=1 AND alertID IN(SELECT alertID FROM customerHasAlerts WHERE email=?)");
			getNewAlerts.setString(1,customerEmail);
			ResultSet newAlerts = getNewAlerts.executeQuery();
			
			%>
			<table>
				<tr>
					<th>Alert ID</th>
					<th>Alert Content</th>
				</tr>

			<%
			int numOfNewAlerts = 0;
			if(newAlerts.next()){
				
				do{
					if(newAlerts.getInt(12) == 1){
						continue;
					}
					numOfNewAlerts++;
					int alertID = newAlerts.getInt(1);
					String alertContent = newAlerts.getString(2);
					
					%>
					
						<tr>
							<td><%=alertID %></td>
							<td><%out.println(alertContent); %></td>
						</tr>
					
					
					<%
					
				}	while(newAlerts.next());
				
				
			}
			
			else{
				%>
				<tr>
					<td>N/A</td>
					<td>NO NEW ALERTS</td>
				</tr>
				
				<%
				
			}
			
			if(numOfNewAlerts == 0){
				%>
				<tr>
					<td>N/A</td>
					<td>NO NEW ALERTS</td>
				</tr>
				
				<%				
			}
			
			%></table>
			
			<br>


			<br>
		
			<h2>Old Alerts</h2>
			
			<%
			
			

			
			
			PreparedStatement getOldAlerts = con.prepareStatement("SELECT * FROM alerts WHERE showAlert=1 AND alertID IN(SELECT alertID FROM customerHasAlerts WHERE email=?)");
			getOldAlerts.setString(1,customerEmail);
			ResultSet oldAlerts = getNewAlerts.executeQuery();
			
			%>
			<table>
				<tr>
					<th>Alert ID</th>
					<th>Alert Content</th>
				</tr>

			<%
			int numOfOldAlerts = 0;
			if(oldAlerts.next()){
				
				do{
					if(oldAlerts.getInt(12) == 0){
						continue;
					}
					numOfOldAlerts++;
					int alertID = oldAlerts.getInt(1);
					String alertContent = oldAlerts.getString(2);
					
					%>
					
						<tr>
							<td><%=alertID %></td>
							<td><%out.println(alertContent); %></td>
						</tr>
					
					
					<%
					
				}	while(oldAlerts.next());
				
				
			}
			
			else{
				%>
				<tr>
					<td>N/A</td>
					<td>NO OLD ALERTS</td>
				</tr>
				
				<%
				
			}
			
			if(numOfOldAlerts == 0){
				%>
				<tr>
					<td>N/A</td>
					<td>NO OLD ALERTS</td>
				</tr>
				
				<%				
			}
			
			%></table><%
 			
 			con.close();
 		
 		%>

 		
 		
 		
 		<br>
 		<br>

</body>
</html>