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
			
			

			
			
			// Get the input data from the form
			String faqTopic = request.getParameter("topic");
			String faqQuestionContent = request.getParameter("questionContent");
			String faqQuestionAnswer = request.getParameter("questionAnswer");
			
		  	// Prepare the statement to insert the question into the database
			PreparedStatement insertFAQ = con.prepareStatement("INSERT INTO faqs(faqID,topic,content,response) VALUES(?,?,?,?)");
			insertFAQ.setInt(1,0);
			insertFAQ.setString(2,faqTopic);
			insertFAQ.setString(3,faqQuestionContent);
			insertFAQ.setString(4,faqQuestionAnswer);
			insertFAQ.executeUpdate();
			
			

			con.close();
			response.sendRedirect(request.getHeader("referer"));
			
			

		}
		
		catch (Exception ex){
			out.println(ex);

		} 


	%>
	
	</body>









</html>