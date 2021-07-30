<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/member.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
	#btnCreateAuction {
		width: 100%;
	}
	.is-countdown {
	    border: 0 !important;
	    background-color: transparent !important;
	}
</style>
<link rel="stylesheet" type="text/css" href="/BuyMe/style/jquery.countdown.css"> 
<script type="text/javascript" src="/BuyMe/js/jQueryCountdown/jquery.plugin.js"></script> 
<script type="text/javascript" src="/BuyMe/js/jQueryCountdown/jquery.countdown.js"></script>
</head>
<body>
<form id="createAuctionForm" class="g-3">
	<div class="content auctionDetails" style="display:none;">
		<div class="row">
			<div class="col-3 d-none d-xl-block"></div>
			<div class="col-xs-12 col-lg-9">
			
				<div class="row">
				<div class="col-12"><h1>View Auction</h1></div>
			</div>
				<div class="row">
					<div class="col-xs-12 col-lg-9">
						<div class="form-group">
						    <label for="txtTitle">Title</label>
						    <input id="txtTitle" name="Title" type="text" class="form-control-plaintext" placeholder="Auction Title" readonly>
					  	</div>
				  	</div>
				 </div>
				 <div class="row">
					<div class="col-xs-12 col-lg-9">
						<div class="mb-3">
						  <label for="txtDescription" class="form-label">Description:</label>
						  <label id="txtDescription" name="Description" class="form-control-plaintext"></textarea>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-lg-3">
						<div class="form-group">
						    <label for="txtName">Name</label>
						    <input id="txtName" name="Name" type="text" class="form-control-plaintext" placeholder="Item name" readonly>
					  	</div>
				  	</div>
				  	<div class="col-xs-12 col-lg-3">
					 	<label for="txtCategory">Category</label>
					    <input id="txtCategory" name="Category" type="text" class="form-control-plaintext" placeholder="Category" readonly>
					 </div>
					 <div class="col-xs-12 col-lg-3">
					 	<label for="txtSubCategory">Subcategory</label>
					 	<input id="txtSubCategory" name="SubCategory" type="text" class="form-control-plaintext" placeholder="SubCategory" readonly>
					 </div>
	 				<div class="col-xs-12 col-lg-3 subCategoryAttributes laptop" style="display: none;">
						<label for="ddlLaptopTouchScreen">Touchscreen?</label>
					  	<select id="ddlLaptopTouchScreen" name="LaptopTouchScreen" class="form-select subCatAttr boolean">
						  <option value="0" selected>No</option>
						  <option value="1">Yes</option>
						</select>
				  	</div>
					<div class="col-xs-12 col-lg-3 subCategoryAttributes cellphone" style="display: none;">
						<div class="form-group">
						    <label for="txtCellphoneProvider">Provider</label>
						    <input id="txtCellphoneProvider" name="CellphoneProvider" type="text" class="form-control subCatAttr" placeholder="">
					  	</div>
				  	</div>
					<div class="col-xs-12 col-lg-3 subCategoryAttributes tv" style="display: none;">
						<div class="form-group">
						    <label for="txtTVSize">Size (inches)</label>
						    <input id="txtTVSize" name="TVSize" type="number" class="form-control int subCatAttr">
					  	</div>
				  	</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-lg-3">
						<div class="form-group">
						    <label for="txtCompany">Manufacturer</label>
						    <input id="txtCompany" name="Company" type="text" class="form-control-plaintext" placeholder="Item Manufacturer" readonly>
					  	</div>
				  	</div>
				  	<div class="col-xs-12 col-lg-3">
						<div class="form-group">
						    <label for="txtYear">Year</label>
						    <input id="txtYear" name="Year" type="number" class="form-control-plaintext int" placeholder="Item Mfr Year" readonly>
					  	</div>
				  	</div>
				  	<div class="col-xs-12 col-lg-3">
						<div class="form-group">
						    <label for="txtColor">Color</label>
						    <input id="txtColor" name="Color" type="text" class="form-control-plaintext" placeholder="Item Color" readonly>
					  	</div>
				  	</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-lg-3">
						<div class="form-group">
						    <label for="txtStartTime">Started</label>
						    <input id="txtStartTime" name="Name" type="text" class="form-control-plaintext" placeholder="Start Time" readonly>
					  	</div>
				  	</div>
				  	<div class="col-xs-12 col-lg-3">
						<div class="form-group">
						    <label for="txtCloseTime">Ends</label>
						    <input id="txtCloseTime" name="Name" type="text" class="form-control-plaintext" placeholder="End Time" readonly>
					  	</div>
				  	</div>
				  	<div class="col-xs-12 col-lg-3">
						<div class="form-group">
							<label for="divCountdownTimer">Time Remaining</label>
							<div id="divCountdownTimer"></div>
					  	</div>
				  	</div>
				</div>
				<div class="row">
				<div class="col-xs-12 col-lg-3">
						<div class="form-group">
						    <label for="txtCurrentHighBid">Current High Bid</label>
						    <input id="txtCurrentHighBid" name="HighBid" type="number" class="form-control-plaintext currency" placeholder="Current High Bid" readonly>
					  	</div>
				  	</div>
				</div>
				
	
				<div class="row rowSubmitBtn">
					<div class="col-xs-12 col-lg-3">
						<button id="btnSubmitBid" class="btn btn-primary" type="submit">Submit Bid</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</form>

   <script> 
 //cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/css/bootstrapvalidator.min.css 
 
 $.when(
    $.getScript( "../js/auctionDetails.js?rev=" + Date.now() ),
    $.Deferred(function( deferred ){
        $( deferred.resolve );
    })
).done(function(){    
});

   </script>
</body>
</html>