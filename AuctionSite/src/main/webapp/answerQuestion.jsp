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
			
			// Get the employee ID of the employee answering the question
			String employeeID = session.getAttribute("employeeID").toString();
			out.println(employeeID);
			// Get the input data from the form
			int questionID = Integer.parseInt(request.getParameter("questionID"));
			String reply = request.getParameter("reply");
			
			
		  	// Update the question with the employee response, and set the status as 1 (closed)
		  	String update = "UPDATE questions SET employeeResponse=? , status=? WHERE questionID=?";
			PreparedStatement updateQuestion = con.prepareStatement(update);
			updateQuestion.setString(1,reply);
			updateQuestion.setInt(2,1);
			updateQuestion.setInt(3,questionID);
			updateQuestion.executeUpdate();
			
			// Insert into the answersQuestions table
			PreparedStatement insertIntoAnswers = con.prepareStatement("INSERT INTO answersQuestion(employeeID,questionID) VALUES(?,?)");
			insertIntoAnswers.setInt(1,Integer.parseInt(employeeID));
			insertIntoAnswers.setInt(2,questionID);
			insertIntoAnswers.executeUpdate(); 
			
			con.close();
			response.sendRedirect(request.getHeader("referer"));
			
			

		}
		
		catch (Exception ex){
			out.println(ex);

		} 


	%>
	
	</body>









</html>