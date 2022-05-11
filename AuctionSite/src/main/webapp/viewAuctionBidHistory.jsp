<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Auction Bid History</title>
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
	<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			
			int auctionNumber =  Integer.parseInt(request.getParameter("auctionNumber"));
			
			PreparedStatement getBidsHistory = con.prepareStatement("SELECT * FROM bidsHistory WHERE saleNumber=? ORDER BY (bidDateTime) ASC");
			getBidsHistory.setInt(1,auctionNumber);
			ResultSet rs = getBidsHistory.executeQuery();

			%>
			
			<h1>Auction Bid History</h1>
			
			
			<table style="margin: 0 auto">
				<tr>
					<th>Bid Amount</th>
					<th>Date / Time</th>

				</tr>
			<%
			
			if(!rs.next()){
				%>
					<tr>
						<td colspan="2">No bidding history for auction, or auction does not exist</td>
					</tr>
					</table>
				<%
				
				con.close();
			}
			
			else{
					do{
						

						%>
						
						<tr >
							<td><%= rs.getFloat(3) %></td>
							<td><%= rs.getString(4) %></td>
						</tr>
						
						
						
						
						
					<%}while(rs.next());
					
					%> </table><%
					
					
					con.close();
					
				
					
					
					
					
					
					
					
					
				}
			
				%>	
				
				<form id="backToHome"  method="post" action="Home.jsp">
					<input type="submit" value="Back to Home">
				</form>				
					
				<%			
				
			
			
			
			
			
	
	
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>




</body>
</html>