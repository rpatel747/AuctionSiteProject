<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
 
	<%
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			
			int auctionNumber =  Integer.parseInt(request.getParameter("auctionNumber"));
			
			PreparedStatement getBidsHistory = con.prepareStatement("SELECT * FROM bidsHistory WHERE saleNumber=? ORDER BY (bidDateTime) ASC");
			getBidsHistory.setInt(1,auctionNumber);
			ResultSet rs = getBidsHistory.executeQuery();
			
			if(!rs.next()){
				out.println("No users have placed a bid on this auction");
				con.close();
			}
			
			else{
				

		
					%>
					
					<h1>Auction Bid History</h1>
					
					
					<table>
						<tr>
							<th>Bid Amount</th>
							<th>Date / Time</th>

						</tr>
					<%
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