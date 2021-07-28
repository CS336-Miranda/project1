<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/member.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<form>
<div class="content">
	<div class="row">
		<div class="col-12"><h1>Create Auction</h1></div>
	</div>
	<div class="row">
		<div class="col-6">
			<div class="form-group">
			    <label for="txtTitle">Title</label>
			    <input type="text" class="form-control" id="txtTitle" aria-describedby="titleHelp" placeholder="Auction Title">
			    <!--<small id="titleHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>-->
		  	</div>
	  	</div>
	 </div>
	 <div class="row">
		  <div class="col-3">
			<label for="ddlAuctionLength">Auction Length</label>
		  	<select class="form-select" aria-label="Item Type" id="ddlAuctionLength">
			  <option selected># of days</option>
			  <option value="3">3</option>
			  <option value="5">5</option>
			  <option value="7">7</option>
			</select>
		</div>	
		<div class="col-3">
		 	<label for="ddlItemType">Item Type</label>
		  	<select class="form-select" aria-label="Item Type" id="ddlItemType">
			  <option selected></option>
			  <option value="cellphone">Cell Phone</option>
			  <option value="laptop">Laptop</option>
			  <option value="tv">TV</option>
			</select>
		 </div>
	</div>
	<div class="row">
  		<div class="col-6">
			<div class="form-group">
			    <label for="txtMinPrice">Minimum Reserve Price</label>
			    <input type="number" class="form-control" id="txtTitle" aria-describedby="minReserveHelp" placeholder="Minimum Reserve Price">
			    <!--<small id="minReserveHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>-->
		  	</div>
	  	</div>
	</div>
	<div class="row">
		<div class="col-6">
			<div class="mb-3">
			  <label for="txtQuestion" class="form-label">Description:</label>
			  <textarea class="form-control" id="txtQuestion" rows="3"></textarea>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12"><button type="submit" class="btn btn-primary">Post</button></div>

	</div>
</div>

  
  

  
</form>
</body>
</html>