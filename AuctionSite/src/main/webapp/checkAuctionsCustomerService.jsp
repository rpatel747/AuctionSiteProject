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
		
		
		try {
			
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
		
		
			PreparedStatement stmt = con.prepareStatement("SELECT * FROM sale WHERE status=0");
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
					
					if(trim.isEmpty()){
						trim = "null";
					}
					
					
					if(soldStatus == 1){
						// Item has already been sold, not need to look at bids or query for other information.
						// Check if the highest bid is greater then the minimum price, if this is true then set as sold and alert bidder and owner
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
				  	
					PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids WHERE saleNumber=?)");
				  	getMaxBid.setInt(1,saleNumber);
				  	getMaxBid.setInt(2,saleNumber);
					ResultSet rs2= getMaxBid.executeQuery();
					
					
				  	if(todaysDate.after(saleDate)){
							// At the time of checking the auctions, the sale date is older therefore the sale must be finished						
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
									
									// Alert the winner that they have won
									
									String alertMessage = "You have won Auction #" + saleNumber;
									
						 			PreparedStatement insertUserAlert = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
									insertUserAlert.setInt(1,0);
									insertUserAlert.setString(2,alertMessage);
									insertUserAlert.setString(3,carName);
									insertUserAlert.setString(4,vehicleType);
									insertUserAlert.setString(5,manufacturer);
									insertUserAlert.setString(6,String.valueOf(manufacturedYear));
									insertUserAlert.setString(7,color);
									insertUserAlert.setString(8,String.valueOf(mileage));
									insertUserAlert.setString(9,trim);
						 			insertUserAlert.setInt(10,1);
									insertUserAlert.setInt(11,3);
									insertUserAlert.setInt(12,0); 
									insertUserAlert.executeUpdate();
									
									
						 			PreparedStatement getAlertID = con.prepareStatement("SELECT LAST_INSERT_ID()");
									ResultSet rs3= getAlertID.executeQuery();
									int alertID = 0;
									if(rs3.next()){
										alertID = rs3.getInt(1);
									}
									
									PreparedStatement updateCustomerHas = con.prepareStatement("INSERT INTO customerHasAlerts(alertID,email) VALUES(?,?)");
									updateCustomerHas.setInt(1,alertID);
									updateCustomerHas.setString(2,rs2.getString(1));
									updateCustomerHas.executeUpdate();
									

									// Alert the seller that the auction has finished with a winner
									
									alertMessage = "Auction #" + saleNumber+ " has sold";
						 			PreparedStatement insertSellerAlert = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
						 			insertSellerAlert.setInt(1,0);
						 			insertSellerAlert.setString(2,alertMessage);
						 			insertSellerAlert.setString(3,carName);
						 			insertSellerAlert.setString(4,vehicleType);
						 			insertSellerAlert.setString(5,manufacturer);
						 			insertSellerAlert.setString(6,String.valueOf(manufacturedYear));
						 			insertSellerAlert.setString(7,color);
						 			insertSellerAlert.setString(8,String.valueOf(mileage));
						 			insertSellerAlert.setString(9,trim);
						 			insertSellerAlert.setInt(10,1);
						 			insertSellerAlert.setInt(11,3);
						 			insertSellerAlert.setInt(12,0); 
						 			insertSellerAlert.executeUpdate();
						 			
						 			PreparedStatement getSellerAlertID = con.prepareStatement("SELECT LAST_INSERT_ID()");
									ResultSet rs4= getSellerAlertID.executeQuery();
									alertID = 0;
									if(rs4.next()){
										alertID = rs4.getInt(1);
									}
									
									PreparedStatement getSellerEmail = con.prepareStatement("SELECT email FROM sells WHERE saleNumber=?");
									getSellerEmail.setInt(1,saleNumber);
									ResultSet sellerEmail = getSellerEmail.executeQuery();
									
									if(sellerEmail.next()){
										PreparedStatement updateSellerHas = con.prepareStatement("INSERT INTO customerHasAlerts(alertID,email) VALUES(?,?)");
										updateCustomerHas.setInt(1,alertID);
										updateCustomerHas.setString(2,sellerEmail.getString(1));
										updateCustomerHas.executeUpdate();										
									}								
								
								}
							
							
							
							else{
								
								// The auction date has finished but no one bet above the minimum reserve 
								// Close the auction
									// Update the sale so that its status is set to 1 (closed)
									out.println("NEXT");
									PreparedStatement ps3 = con.prepareStatement("UPDATE sale SET status=? WHERE saleNumber=?");
									ps3.setInt(1,1);
									ps3.setInt(2,saleNumber);
									ps3.executeUpdate();
									
									// Alert the seller that the item has not sold because the bids did not reach the minimum price
								
									String alertMessage = "Auction #"+saleNumber+" has not sold because no bids were above the minimum price";
									
						 			PreparedStatement insertUserAlert = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
									insertUserAlert.setInt(1,0);
									insertUserAlert.setString(2,alertMessage);
									insertUserAlert.setString(3,carName);
									insertUserAlert.setString(4,vehicleType);
									insertUserAlert.setString(5,manufacturer);
									insertUserAlert.setString(6,String.valueOf(manufacturedYear));
									insertUserAlert.setString(7,color);
									insertUserAlert.setString(8,String.valueOf(mileage));
									insertUserAlert.setString(9,trim);
						 			insertUserAlert.setInt(10,1);
									insertUserAlert.setInt(11,3);
									insertUserAlert.setInt(12,0); 
									insertUserAlert.executeUpdate();
									
									
						 			PreparedStatement getAlertID = con.prepareStatement("SELECT LAST_INSERT_ID()");
									ResultSet rs3= getAlertID.executeQuery();
									int alertID = 0;
									if(rs3.next()){
										alertID = rs3.getInt(1);
									}
									
									PreparedStatement getSellerEmail = con.prepareStatement("SELECT email FROM sells WHERE saleNumber=?");
									getSellerEmail.setInt(1,saleNumber);
									ResultSet sellerEmail = getSellerEmail.executeQuery();	
									
									if(sellerEmail.next()){
										
									}
									
									PreparedStatement updateCustomerHas = con.prepareStatement("INSERT INTO customerHasAlerts(alertID,email) VALUES(?,?)");
									updateCustomerHas.setInt(1,alertID);
									updateCustomerHas.setString(2,sellerEmail.getString(1));
									updateCustomerHas.executeUpdate();									
									
								
								}
							}
								
								else{
									
									// The auction date has finished but no one bet above the minimum reserve 
									// Close the auction
										// Update the sale so that its status is set to 1 (closed)
										out.println("NEXT");
										PreparedStatement ps3 = con.prepareStatement("UPDATE sale SET status=? WHERE saleNumber=?");
										ps3.setInt(1,1);
										ps3.setInt(2,saleNumber);
										ps3.executeUpdate();
										
										// Alert the seller that the item has not sold because the bids did not reach the minimum price
									
										String alertMessage = "Auction #"+saleNumber+" has not sold because no bids were above the minimum price";
										
							 			PreparedStatement insertUserAlert = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
										insertUserAlert.setInt(1,0);
										insertUserAlert.setString(2,alertMessage);
										insertUserAlert.setString(3,carName);
										insertUserAlert.setString(4,vehicleType);
										insertUserAlert.setString(5,manufacturer);
										insertUserAlert.setString(6,String.valueOf(manufacturedYear));
										insertUserAlert.setString(7,color);
										insertUserAlert.setString(8,String.valueOf(mileage));
										insertUserAlert.setString(9,trim);
							 			insertUserAlert.setInt(10,1);
										insertUserAlert.setInt(11,3);
										insertUserAlert.setInt(12,0); 
										insertUserAlert.executeUpdate();
										
										
							 			PreparedStatement getAlertID = con.prepareStatement("SELECT LAST_INSERT_ID()");
										ResultSet rs3= getAlertID.executeQuery();
										int alertID = 0;
										if(rs3.next()){
											alertID = rs3.getInt(1);
										}
										
										PreparedStatement getSellerEmail = con.prepareStatement("SELECT email FROM sells WHERE saleNumber=?");
										getSellerEmail.setInt(1,saleNumber);
										ResultSet sellerEmail = getSellerEmail.executeQuery();	
										
										if(sellerEmail.next()){
											
										}
										
										PreparedStatement updateCustomerHas = con.prepareStatement("INSERT INTO customerHasAlerts(alertID,email) VALUES(?,?)");
										updateCustomerHas.setInt(1,alertID);
										updateCustomerHas.setString(2,sellerEmail.getString(1));
										updateCustomerHas.executeUpdate();									
										
									
								}
						}
				  					  				  		
				  
			  	
				  	else{
				  		// Auction has not finished
				  		// Get all the users that are bidding, if they choose to auto bid then perform one round of auto biddings
				  		

						PreparedStatement getBids = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=?");
						getBids.setInt(1,saleNumber);
						ResultSet currentBidsPlaced = getBids.executeQuery();
				  		
				  		if(currentBidsPlaced.next()){
				  			// Get the current max bid, if the user has the current max bid then skip them 
				  			// Otherwise get the current max bid, check if the bidder can make a a larger bid
				  			// if they can then place the bid
				  			
				  			do{
				  				
								PreparedStatement getMB = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids WHERE saleNumber=?)");
								getMB.setInt(1,saleNumber);
								getMB.setInt(2,saleNumber);
								ResultSet rs3= getMB.executeQuery();
								
								float currentMaxBid = 0;
								if(rs3.next()){
									currentMaxBid = rs3.getFloat(3);
								}
								
								// Get the information about the bidders current bid and their email
								float currentUserBid = currentBidsPlaced.getFloat(3);
								float userMaxBid = currentBidsPlaced.getFloat(4);
								String currentUserEmail = currentBidsPlaced.getString(1);
								
								if(currentUserBid == userMaxBid){
									continue;
								}
				  				
								else{
									
									float currentUserMaxBidAmount = currentBidsPlaced.getFloat(4);
									float nextValidBid = (currentMaxBid + validBidIncr);
									if(currentUserMaxBidAmount >= nextValidBid){
										
										// The current bidder can increase their bid
										// Update their bid with the larger bid
										PreparedStatement updateBid = con.prepareStatement("UPDATE bids SET currentBid=? WHERE email=? AND saleNumber=?");
										updateBid.setFloat(1,nextValidBid);
										updateBid.setString(2,currentUserEmail);
										updateBid.setInt(3,saleNumber);
										updateBid.executeUpdate();
										
										// Update the bid history with the bid that was just placed
							  			PreparedStatement createNewBidHistory = con.prepareStatement("INSERT INTO bidsHistory(email,saleNumber,currentBid,bidDateTime) VALUES(?,?,?,?)");
							  			createNewBidHistory.setString(1,currentUserEmail);
							  			createNewBidHistory.setInt(2,saleNumber);
							  			createNewBidHistory.setFloat(3,nextValidBid);
							  			createNewBidHistory.setTimestamp(4,java.sql.Timestamp.valueOf(todaysDateTime));
							  			createNewBidHistory.executeUpdate();
										
									}
									
									
								}
				  				
				  				
				  				
				  			}while(currentBidsPlaced.next());
				  			
				  			
				  		}
				  		
				  	}
				  	
				} while(rs.next());

				
			
				
				
				
				
			}
					
			
			con.close();
			response.sendRedirect("customerServiceTab.jsp");		
			
			
			
			
			
	
		
		
		
		}
		
		catch (Exception ex){
			out.print(ex);
			out.print("Query failed :()");
			response.sendRedirect("customerServiceTab.jsp");		
		}

	%>
	
	
	
	</body>









</html>