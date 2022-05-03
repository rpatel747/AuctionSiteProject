<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- This page is used to check if a user with the given credentials exists, if they do
	 then they will be logged in. Otherwise an error we will be reported. -->
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">		
		
	</head>
	
	
	<body>
		<%
		
		
		

		  	
		  	
		  	
 		try {
			
 			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			
			// Get the email for the customer sending the message
			String customerEmail = (String) session.getAttribute("customerEmail");
			
			
			// Get the input data from the form
			String messageTopic = request.getParameter("messageTopic");
			String userQuestion = request.getParameter("userMessageContent");
			
		  	// Prepare the statement to insert the question into the database
			PreparedStatement insertQuestion = con.prepareStatement("INSERT INTO questions(questionID,topic,userResponse,employeeResponse,status) VALUES(?,?,?,?,?)");
		  	insertQuestion.setInt(1,0);
			insertQuestion.setString(2,messageTopic);
			insertQuestion.setString(3,userQuestion);
			insertQuestion.setString(4,"");
			insertQuestion.setInt(5,0);
			insertQuestion.executeUpdate();
			
			
			// Get the questionID of the question that was just inserted
 			PreparedStatement stmt = con.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs= stmt.executeQuery();
			int questionID = 0;
			if(rs.next()){
				questionID = rs.getInt(1);
			}
			
			
			// Insert the email of the customer, and the questionID into the asks table
			PreparedStatement insertIntoAsks = con.prepareStatement("INSERT INTO asksQuestion(email,questionID) VALUES(?,?)");
			insertIntoAsks.setString(1,customerEmail);
			insertIntoAsks.setInt(2,questionID);
			insertIntoAsks.executeUpdate();
			
			
			
			con.close();
			response.sendRedirect(request.getHeader("referer"));
			
			
			
			// Get all the bis that are currently placed
			
			// Search through the bids checking:
			//	(1) If the sale has ended
			//  (2) If the bidder has the highest bid for the sale
			//      If either of these are true then skip the bid in question
			//   Otherwise check if the bidder can make a bid that is higher then the current bid for that given sale
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

		}
		
		catch (Exception ex){
			out.println(ex);
			
			//response.sendRedirect(request.getHeader("referer"));	
		} 


	%>
	
	</body>









</html>