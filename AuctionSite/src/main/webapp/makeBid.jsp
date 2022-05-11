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
			

			String customerEmail = (String) session.getAttribute("customerEmail");
			
			
			// Get todays date:
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  	String todaysDateTime = sdf.format(new Date());		
		  	Date todaysDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todaysDateTime);
		  	
		  	
		  	
		  	// Get the currentHighestBid for the sale, if there is not currentHighestBid then they must use a valid bid increment to bid
		  	int saleNumber = Integer.parseInt(request.getParameter("bidSaleNumber"));
		  			
		  	// Query the database to get the information about the sale
		  	PreparedStatement getAuctionInfo = con.prepareStatement("SELECT * FROM sale WHERE saleNumber=?");
		  	getAuctionInfo.setInt(1,saleNumber);
		  	ResultSet auctionInfo = getAuctionInfo.executeQuery();
		  	

		  	
		  	
		  	if(auctionInfo.next()){
		  		
		  		
			  	float minPriceForSale = auctionInfo.getFloat(12);
			  	float validBidIncrForSale = auctionInfo.getFloat(11);
			  	Date saleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(auctionInfo.getString(10));
			  	int saleStatus = auctionInfo.getInt(13);
		  		
	
		  		
		  	

		  
			  	// The auction has already closed
			  	if(todaysDate.after(saleDate)){
			  		
			  		
			  		
			  		if(saleStatus == 1){
			  			// The sale has already been closed off
			  			session.setAttribute("makeBidStatus","Auction has closed and bid could not be placed");
			  			
			  		}
			  		
			  		else{
			  			// We have not yet set the auction to be closed
			  			PreparedStatement updateAuctionStatus = con.prepareStatement("UPDATE sale SET status=1 WHERE saleNumber=?");
			  			updateAuctionStatus.setInt(1,saleNumber);
			  			updateAuctionStatus.executeUpdate();
			  			
						PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids WHERE saleNumber=?)");
					  	getMaxBid.setInt(1,saleNumber);
					  	getMaxBid.setInt(2,saleNumber);
						ResultSet rs2= getMaxBid.executeQuery();			  			
			  			
						// Check if there is a max bid, then check if the max bid is > minimum price
						// If this is true then alert the seller that the item has sold, and the bidder that they have won the auction
						if(rs2.next()){
							
							if(rs2.getFloat(3) >= minPriceForSale){
								
								// The highest bidder has bid higher then the reserve price, alert the owner and the seller
								
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
								
								// Alert the winner that they have won
								String alertMessage = "You have won Auction #" + saleNumber;
					 			PreparedStatement insertUserAlert = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
								insertUserAlert.setInt(1,0);
								insertUserAlert.setString(2,alertMessage);
								insertUserAlert.setString(3,auctionInfo.getString(2));
								insertUserAlert.setString(4,auctionInfo.getString(8));
								insertUserAlert.setString(5,auctionInfo.getString(4));
								insertUserAlert.setString(6,auctionInfo.getString(3));
								insertUserAlert.setString(7,auctionInfo.getString(9));
								insertUserAlert.setString(8,auctionInfo.getString(5));
								insertUserAlert.setString(9,auctionInfo.getString(7));
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
								insertUserAlert.setString(3,auctionInfo.getString(2));
								insertUserAlert.setString(4,auctionInfo.getString(8));
								insertUserAlert.setString(5,auctionInfo.getString(4));
								insertUserAlert.setString(6,auctionInfo.getString(3));
								insertUserAlert.setString(7,auctionInfo.getString(9));
								insertUserAlert.setString(8,auctionInfo.getString(5));
								insertUserAlert.setString(9,auctionInfo.getString(7));
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
							
						}
			  			
			  			session.setAttribute("makeBidStatus","Auction has closed and bid could not be placed");
			  			
			  			
			  		}
			  		
			  		
			  		
			  	}
			  	
			  	// The auction is open, therefore bid can be placed
			  	else{
			  		
			  		// The bid being placed must be greater then the current max bid
			  		
					Float bidInitalAmount = Float.parseFloat((String)request.getParameter("initBidAmount"));
					Float maxBidAmount = Float.parseFloat((String)(request.getParameter("maxBidAmount")));
			  		
					// Check if the user has already placed a bid on sale in question
					PreparedStatement checkBidHistory = con.prepareStatement("SELECT * FROM bids WHERE email=? AND saleNumber=?");
					checkBidHistory.setString(1,customerEmail);
					checkBidHistory.setInt(2,saleNumber);
					ResultSet rs2= checkBidHistory.executeQuery();
				
					
			  		if(rs2.next()){
			  			
			  			if(bidInitalAmount > rs2.getFloat(3)){
				  			// There is already a bid in place, delete the bid and then place the bid

				  			PreparedStatement updateCurrentBid = con.prepareStatement("UPDATE bids SET currentBid=? WHERE email=? AND saleNumber=?");
				  			updateCurrentBid.setFloat(1,bidInitalAmount);
				  			updateCurrentBid.setString(2,customerEmail);
				  			updateCurrentBid.setInt(3,saleNumber);
				  			updateCurrentBid.executeUpdate();
				  			
				  			PreparedStatement updateMaxBid = con.prepareStatement("UPDATE bids SET maxBid=? WHERE email=? AND saleNumber=?");
				  			updateMaxBid.setFloat(1,maxBidAmount);
				  			updateMaxBid.setString(2,customerEmail);
				  			updateMaxBid.setInt(3,saleNumber);				  			
				  			updateMaxBid.executeUpdate();
				  			
				  			PreparedStatement createNewBidHistory = con.prepareStatement("INSERT INTO bidsHistory(email,saleNumber,currentBid,bidDateTime) VALUES(?,?,?,?)");
				  			createNewBidHistory.setString(1,customerEmail);
				  			createNewBidHistory.setInt(2,saleNumber);
				  			createNewBidHistory.setFloat(3,bidInitalAmount);
				  			createNewBidHistory.setTimestamp(4,java.sql.Timestamp.valueOf(todaysDateTime));
				  			createNewBidHistory.executeUpdate();
				  			
				  			
				  			// Check if the current bid being placed is greater than the maximum bid of other bidders
				  			PreparedStatement getListOfUsers = con.prepareStatement("SELECT email FROM bids WHERE saleNumber=? AND maxBid<?");
				  			getListOfUsers.setFloat(1,saleNumber);
				  			getListOfUsers.setFloat(2,bidInitalAmount);
				  			ResultSet listOfBidders = getListOfUsers.executeQuery();
				  			
				  			if(listOfBidders.next()){
					  			
					  			String alertMessage = "A bidder has placed a bid greater than you maximum bid for Auction #"+saleNumber;
					  			do{
					  				
					  				
					  				PreparedStatement insertIntoAlerts = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
					  				insertIntoAlerts.setInt(1,0);
					  				insertIntoAlerts.setString(2,alertMessage);
					  				insertIntoAlerts.setString(3,"null");
					  				insertIntoAlerts.setString(4,"null");
					  				insertIntoAlerts.setString(5,"null");
					  				insertIntoAlerts.setString(6,"null");
					  				insertIntoAlerts.setString(7,"null");
					  				insertIntoAlerts.setString(8,"null");
					  				insertIntoAlerts.setString(9,"null");
					  				insertIntoAlerts.setInt(10,1);
					  				insertIntoAlerts.setInt(11,3);
					  				insertIntoAlerts.setInt(12,0);
					  				insertIntoAlerts.executeUpdate();
					  				
						 			PreparedStatement getSellerAlertID = con.prepareStatement("SELECT LAST_INSERT_ID()");
									ResultSet rs4= getSellerAlertID.executeQuery();
									int alertID = 0;
									if(rs4.next()){
										alertID = rs4.getInt(1);
									}
									
									PreparedStatement insertIntoCustomerHasAlerts = con.prepareStatement("INSERT INTO customerHasAlerts(alertID,email) VALUES(?,?)");
									insertIntoCustomerHasAlerts.setInt(1,alertID);
									insertIntoCustomerHasAlerts.setString(2,listOfBidders.getString(1));
									insertIntoCustomerHasAlerts.executeUpdate();
					  				
					  			} while(listOfBidders.next());
					  			
				  			
				  			
				  			}
				  			session.setAttribute("makeBidStatus","Bid was successfully placed");
			  			}
			  		}
			  		
			  		else{
			  			// There is no bid in place,
			  			
			  			PreparedStatement getMaxBid = con.prepareStatement("SELECT * FROM bids WHERE saleNumber=? AND currentBid IN (SELECT MAX(currentBid) currentBid FROM bids)");
					  	getMaxBid.setInt(1,saleNumber);
						ResultSet rs3= getMaxBid.executeQuery();
						
						float currentMaxBid = 0;
						if(rs3.next()){
							currentMaxBid = rs3.getFloat(3);
						}
						
						Float nextValidBid = currentMaxBid + validBidIncrForSale;
						
						if(bidInitalAmount >= nextValidBid || currentMaxBid == 0){
							// The bid being placed is greater then the max bid by atleast the bid increment set by the seller
							
				  			PreparedStatement createNewBid = con.prepareStatement("INSERT INTO bids(email,saleNumber,currentBid,maxBid) VALUES(?,?,?,?)");
				  			createNewBid.setString(1,customerEmail);
				  			createNewBid.setInt(2,saleNumber);
				  			createNewBid.setFloat(3,bidInitalAmount);
				  			createNewBid.setFloat(4,maxBidAmount);
				  			createNewBid.executeUpdate();
				  			
				  			PreparedStatement createNewBidHistory = con.prepareStatement("INSERT INTO bidsHistory(email,saleNumber,currentBid,bidDateTime) VALUES(?,?,?,?)");
				  			createNewBidHistory.setString(1,customerEmail);
				  			createNewBidHistory.setInt(2,saleNumber);
				  			createNewBidHistory.setFloat(3,bidInitalAmount);
				  			createNewBidHistory.setTimestamp(4,java.sql.Timestamp.valueOf(todaysDateTime));
				  			createNewBidHistory.executeUpdate();
							
				  			session.setAttribute("makeBidStatus","Bid was successfully placed");
				  			
				  			
				  			PreparedStatement usersToNotify = con.prepareStatement("SELECT email FROM bids WHERE saleNumber=? AND email <> ?");
				  			usersToNotify.setInt(1,saleNumber);
				  			usersToNotify.setString(2,customerEmail);
				  			ResultSet notifyBidders = usersToNotify.executeQuery();
				  			
				  			if(notifyBidders.next()){
				  				
				  				String alertMessage = "A higher bid has been placed by another bidder for Auction #" +saleNumber;
				  				
				  				do {
				  					
					  				PreparedStatement insertIntoAlerts = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
					  				insertIntoAlerts.setInt(1,0);
					  				insertIntoAlerts.setString(2,alertMessage);
					  				insertIntoAlerts.setString(3,"null");
					  				insertIntoAlerts.setString(4,"null");
					  				insertIntoAlerts.setString(5,"null");
					  				insertIntoAlerts.setString(6,"null");
					  				insertIntoAlerts.setString(7,"null");
					  				insertIntoAlerts.setString(8,"null");
					  				insertIntoAlerts.setString(9,"null");
					  				insertIntoAlerts.setInt(10,1);
					  				insertIntoAlerts.setInt(11,3);
					  				insertIntoAlerts.setInt(12,0);
					  				insertIntoAlerts.executeUpdate();
					  				
						 			PreparedStatement getSellerAlertID = con.prepareStatement("SELECT LAST_INSERT_ID()");
									ResultSet rs4= getSellerAlertID.executeQuery();
									int alertID = 0;
									if(rs4.next()){
										alertID = rs4.getInt(1);
									}
									
									PreparedStatement insertIntoCustomerHasAlerts = con.prepareStatement("INSERT INTO customerHasAlerts(alertID,email) VALUES(?,?)");
									insertIntoCustomerHasAlerts.setInt(1,alertID);
									insertIntoCustomerHasAlerts.setString(2,notifyBidders.getString(1));
									insertIntoCustomerHasAlerts.executeUpdate();				  					
				  					
				  					
				  					
				  					
				  				}	while(notifyBidders.next());
				  				
				  				
				  				
				  			}
				  			
				  			
				  			
				  			
				  			
				  			// Check if the current bid being placed is greater than the maximum bid of other bidders
				  			PreparedStatement getListOfUsers = con.prepareStatement("SELECT email FROM bids WHERE saleNumber=? AND maxBid<?");
				  			getListOfUsers.setFloat(1,saleNumber);
				  			getListOfUsers.setFloat(2,bidInitalAmount);
				  			ResultSet listOfBidders = getListOfUsers.executeQuery();
				  			
				  			if(listOfBidders.next()){
					  			
					  			String alertMessage = "A bidder has placed a bid greater than you maximum bid for Auction #"+saleNumber;
					  			do{
					  				
					  				
					  				PreparedStatement insertIntoAlerts = con.prepareStatement("INSERT INTO alerts(alertID,alertContent,carName,vehicleType,manufacturer,year,color,mileage,trim,showAlert,setBy,acknowledged) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
					  				insertIntoAlerts.setInt(1,0);
					  				insertIntoAlerts.setString(2,alertMessage);
					  				insertIntoAlerts.setString(3,"null");
					  				insertIntoAlerts.setString(4,"null");
					  				insertIntoAlerts.setString(5,"null");
					  				insertIntoAlerts.setString(6,"null");
					  				insertIntoAlerts.setString(7,"null");
					  				insertIntoAlerts.setString(8,"null");
					  				insertIntoAlerts.setString(9,"null");
					  				insertIntoAlerts.setInt(10,1);
					  				insertIntoAlerts.setInt(11,3);
					  				insertIntoAlerts.setInt(12,0);
					  				insertIntoAlerts.executeUpdate();
					  				
						 			PreparedStatement getSellerAlertID = con.prepareStatement("SELECT LAST_INSERT_ID()");
									ResultSet rs4= getSellerAlertID.executeQuery();
									int alertID = 0;
									if(rs4.next()){
										alertID = rs4.getInt(1);
									}
									
									PreparedStatement insertIntoCustomerHasAlerts = con.prepareStatement("INSERT INTO customerHasAlerts(alertID,email) VALUES(?,?)");
									insertIntoCustomerHasAlerts.setInt(1,alertID);
									insertIntoCustomerHasAlerts.setString(2,listOfBidders.getString(1));
									insertIntoCustomerHasAlerts.executeUpdate();
					  				
					  			} while(listOfBidders.next());
					  			
				  			
				  			
				  			}
				  			
				  			
				  			
				  			
				  			
						}
						
						else{
							
							// The bid being placed is less then the max by + the bid increment set by the seller
							// User must set a higher bid
							
							session.setAttribute("makeBidStatus","Bid not placed, please bid a higher amount");
							
							
						}
						
			  			
			  			
			  			
	
			  			
			  		}
		  		
		  		
		  		
		  		
		  		
		  		
		  		
		  		
		  		
		  		}
		  	
		  	}
		  	
		  	else{
		  		session.setAttribute("makeBidStatus","Auction does not exist");
		  	}

			con.close();
			response.sendRedirect("Home.jsp");	

		}
		
		catch (Exception ex){
			out.println(ex);
			session.setAttribute("makeBidStatus","Bid could not be placed, please try again");
			response.sendRedirect("Home.jsp");	
		} 

	%>
	
	
	
	</body>









</html>