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
<form id="createAuctionForm" class="g-3">
<div class="content">
	<div class="row">
		<div class="col-3 d-none d-xl-block"></div>
		<div class="col-xs-12 col-lg-9">
		
			<div class="row">
			<div class="col-12"><h1>Create Auction</h1></div>
		</div>
			<div class="row">
				<div class="col-xs-12 col-lg-8">
					<div class="form-group">
					    <label for="txtTitle">Title*</label>
					    <input id="txtTitle" name="Title" type="text" class="form-control" placeholder="Auction Title">
				  	</div>
			  	</div>
			 </div>
			 <div class="row">
				<div class="col-xs-12 col-lg-8">
					<div class="mb-3">
					  <label for="txtDescription" class="form-label">Description:</label>
					  <textarea id="txtDescription" name="Description" class="form-control" rows="3"></textarea>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtName">Name*</label>
					    <input id="txtName" name="Name" type="text" class="form-control" placeholder="Item name">
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
				 	<label for="ddlCategory">Category*</label>
				  	<select id="ddlCategory" class="form-select">
					  <option selected>Electronics</option>
					</select>
				 </div>
				 <div class="col-xs-12 col-lg-2">
				 	<label for="ddlSubCategory">Subcategory*</label>
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
					    <label for="txtCompany">Manufacturer*</label>
					    <input id="txtCompany" name="Company" type="text" class="form-control" placeholder="Item Manufacturer">
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtYear">Year*</label>
					    <input id="txtYear" name="Year" type="number" class="form-control int" placeholder="Item Mfr Year">
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtColor">Color*</label>
					    <input id="txtColor" name="Color" type="text" class="form-control" placeholder="Item Color">
				  	</div>
			  	</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-lg-2">
					<label for="ddlAuctionLength">Auction Length (days)*</label>
				  	<select id="ddlAuctionLength" name="AuctionLength" class="form-select">
					  <option selected></option>
					  <option value="3">3</option>
					  <option value="5">5</option>
					  <option value="7">7</option>
					</select>
				</div>	
				<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtInitialPrice">Initial Price*</label>
					    <input id="txtInitialPrice" name="InitialPrice" type="number" class="form-control currency" placeholder="Initial Price">
				  	</div>
			  	</div>
			  	<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtBidIncrement">Bid Increment</label>
					    <input id="txtBidIncrement" name="BidIncrement" type="number" class="form-control currency" placeholder="Bid Increment">
				  	</div>
			  	</div>
		  		<div class="col-xs-12 col-lg-2">
					<div class="form-group">
					    <label for="txtMinPrice">Minimum Reserve Price</label>
					    <input id="txtMinPrice" name="MinPrice" type="number" class="form-control currency" placeholder="Minimum Reserve Price">
				  	</div>
			  	</div>
			</div>
			<div class="row rowSubmitBtn">
		<div class="col-12"><button id="btnCreateAuction" class="btn btn-primary" type="submit">Start Auction</button></div>

	</div>
		
		</div>
	</div>
</div>

  
  

  
</form>

   <script> 
 //cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/css/bootstrapvalidator.min.css 
 
 $.when(
    $.getScript( "//cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js" ),
    $.getScript( "../js/createAuction.js?rev=" + Date.now() ),
    $.Deferred(function( deferred ){
        $( deferred.resolve );
    })
).done(function(){    
});

   </script>
</body>
</html>