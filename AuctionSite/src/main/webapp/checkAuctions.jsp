<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.auctionsite.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.DateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- This page is used to check if a user with the given credentials exists, if they do
	 then they will be logged in. Otherwise an error we will be reported. -->
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">		
		
	</head>
	
	
	<body>
	
	
		<%
		
		//NEED TO MAKE GET THE DATE FOR EACH OF THE dates for the sales, right now it only checks the sale for the first date
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
		
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM sale");
			ResultSet rs= stmt.executeQuery();
			
			
				
			if(rs.next()){
				
				do{
				
					int saleNumber = rs.getInt(1);
					String carName = rs.getString(2);
					int manufacturedYear = rs.getInt(3);
					String manufacturer = rs.getString(4);
					int mileage = rs.getInt(5);
					float currentPrice = rs.getFloat(6);
					String trim = rs.getString(7);
					String vehicleType = rs.getString(8);
					String color = rs.getString(9);
					String saleEndDateTime = rs.getString(10);
					float validBidIncr = rs.getFloat(11);
					float minPrice = rs.getFloat(12); 
					int soldStatus = rs.getInt(13);
					
					
					
					
					if(soldStatus == 1){
						// Item has already been sold, not need to look at bids or query for other information.
						
						continue;
					}
					
					// Get todays date:
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				  	String todaysDateTime = sdf.format(new Date());	
				  	Date todaysDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todaysDateTime);
				  	
				  	// Convert and check the sales date vs todays date
				  	
				  	Date saleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(saleEndDateTime);
				  	
				  	// If the current date is after the end of the sale,
				  	// and the max bid made is greater then minimum price
				  	// If these conditions are true then the sale has finished,
				  	// set the sale status as 1 and place the winner with the max bid
				  	// as the winner in the won relationship
				  	
					PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids)");
				  	getMaxBid.setInt(1,saleNumber);
					ResultSet rs2= getMaxBid.executeQuery();
					
				  	if(todaysDate.after(saleDate)){
						
							
							// There is a max bid, now check if it is greater then the minimum get by the seller
							if(rs2.next()){
								
								float currentMaxBid = rs2.getFloat(3);
								
								if(currentMaxBid >= minPrice){
									
									// The sale has been won by someone, get the winners email
									
									// Set the information about the winner into the won relationship
									String insertWinner = "INSERT INTO won(email,saleNumber,bidPrice) VALUES(?,?,?)";
									PreparedStatement ps = con.prepareStatement(insertWinner);
									ps.setString(1,rs2.getString(1));
									ps.setInt(2,saleNumber);
									ps.setFloat(3,rs2.getFloat(3));
									ps.executeUpdate();
									
									// Update the sales relationship with the updated status of sold, and the price that the item sold for									
									String updateSells = "UPDATE sells SET saleStatus=? AND soldPrice=? WHERE saleNumber=?";
									PreparedStatement ps2 = con.prepareStatement(updateSells);
									ps2.setInt(1,1);
									ps2.setFloat(2,rs2.getFloat(3));
									ps2.setInt(3,saleNumber);
									ps2.executeUpdate();
									
									
									// Update the sale so that its status is set to 1
									String insert = "UPDATE sale SET status=? WHERE saleNumber=?";
									PreparedStatement ps3 = con.prepareStatement(insert);
									ps3.setInt(1,1);
									ps3.setInt(2,saleNumber);
									ps3.executeUpdate();							
								}
							
							}
							
							
							else{
								
								// The auction has ended, but there is not bid that is greater then the min price set by the user
								// Need to extend the auction for more users to bid
								// Get todays date, and add two more dates
								Calendar calendar = Calendar.getInstance();
								Date today = calendar.getTime();
								calendar.add(Calendar.DAY_OF_YEAR,2);
								Date tommorow = calendar.getTime();
								
								String extendedDate = sdf.format(tommorow);
								
								// Update the database with the new end of auction date
								String updateSaleEndTimeDate = "UPDATE sale SET end=? WHERE saleNumber=?";
								PreparedStatement ps4 = con.prepareStatement(updateSaleEndTimeDate);
								ps4.setTimestamp(1, java.sql.Timestamp.valueOf(extendedDate));
								ps4.setInt(2,saleNumber);
								ps4.executeUpdate();
								
								
								//Alert the user that the date has been extended
							}
						}
				  					  				  		
				  	
			  	
				  	else{
				  		// Auction has not finished
				  		// Check if there a bid greater then the min value for the sale has been placed
				  		
				  		if(rs2.next()){
				  			
				  			float currentMaxBid = rs2.getFloat(3);
				  			
				  			if(currentMaxBid >= minPrice){
				  				// Alert the user that a bid has been placed that is greater then the min price
				  			}
				  			
				  		}
				  		
				  		
				  	}
				
				} while(rs.next());

				
			
				
				
				
				
			}
			
			else {
				out.println("There are no sales to check currently.");
			}
		
			
			con.close();
			
		
			
			response.sendRedirect("Home.jsp");		
			
			
			
			
			
	
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
		}

	%>
	
	
	
	</body>









</html>