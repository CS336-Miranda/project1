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
</style>
</head>
<body>
<form id="createAuctionForm" class="g-3">
<div class="content">
	<div class="row">
		<div class="col-3 d-none d-xl-block"></div>
		<div class="col-xs-12 col-lg-9">
		
			<div class="row">
			<div class="col-12"><h1>View Auction</h1></div>
		</div>
			<div class="row">
				<div class="col-xs-12 col-lg-8">
					<div class="form-group">
					    <label for="txtTitle">Title</label>
					    <input id="txtTitle" name="Title" type="text" class="form-control-plaintext" placeholder="Auction Title" readonly>
				  	</div>
			  	</div>
			 </div>
			 <div class="row">
				<div class="col-xs-12 col-lg-8">
					<div class="mb-3">
					  <label for="txtDescription" class="form-label">Description:</label>
					  <textarea id="txtDescription" name="Description" class="form-control-plaintext" rows="3" readonly></textarea>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtStartTime">Started</label>
					    <input id="txtStartTime" name="Name" type="text" class="form-control-plaintext" placeholder="Start Time" readonly>
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtCloseTime">Ends</label>
					    <input id="txtCloseTime" name="Name" type="text" class="form-control-plaintext" placeholder="End Time" readonly>
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtCurrentHighBid">Current High Bid</label>
					    <input id="txtCurrentHighBid" name="HighBid" type="number" class="form-control-plaintext currency" placeholder="Current High Bid" readonly>
				  	</div>
			  	</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtName">Name</label>
					    <input id="txtName" name="Name" type="text" class="form-control-plaintext" placeholder="Item name" readonly>
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
				 	<label for="ddlCategory">Category</label>
				  	<select id="ddlCategory" class="form-select">
					  <option selected>Electronics</option>
					</select>
				 </div>
				 <div class="col-xs-12 col-lg-2">
				 	<label for="ddlSubCategory">Subcategory</label>
				  	<select id="ddlSubCategory" name="SubCategory" class="form-select">
					  <option selected></option>
					  <option value="cellphone">Cell Phone</option>
					  <option value="laptop">Laptop</option>
					  <option value="tv">TV</option>
					</select>
				 </div>
 				<div class="col-xs-12 col-lg-2 subCategoryAttributes laptop" style="display: none;">
					<label for="ddlLaptopTouchScreen">Touchscreen?</label>
				  	<select id="ddlLaptopTouchScreen" name="LaptopTouchScreen" class="form-select subCatAttr boolean">
					  <option value="0" selected>No</option>
					  <option value="1">Yes</option>
					</select>
			  	</div>
				<div class="col-xs-12 col-lg-2 subCategoryAttributes cellphone" style="display: none;">
					<div class="form-group">
					    <label for="txtCellphoneProvider">Provider</label>
					    <input id="txtCellphoneProvider" name="CellphoneProvider" type="text" class="form-control subCatAttr" placeholder="">
				  	</div>
			  	</div>
				<div class="col-xs-12 col-lg-2 subCategoryAttributes tv" style="display: none;">
					<div class="form-group">
					    <label for="txtTVSize">Size (inches)</label>
					    <input id="txtTVSize" name="TVSize" type="number" class="form-control int subCatAttr">
				  	</div>
			  	</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtCompany">Manufacturer</label>
					    <input id="txtCompany" name="Company" type="text" class="form-control" placeholder="Item Manufacturer">
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtYear">Year</label>
					    <input id="txtYear" name="Year" type="number" class="form-control int" placeholder="Item Mfr Year">
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtColor">Color</label>
					    <input id="txtColor" name="Color" type="text" class="form-control" placeholder="Item Color">
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
    $.getScript( "../js/bid.js?rev=" + Date.now() ),
    $.Deferred(function( deferred ){
        $( deferred.resolve );
    })
).done(function(){    
});

   </script>
</body>
</html>