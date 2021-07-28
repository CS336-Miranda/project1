$(document).ready(function(){
	InitializeEventHandlers_createAuction();
});

function InitializeEventHandlers_createAuction(){
	$("#btnCreateAuction").click(function(e){
		e.preventDefault();
		$.when(CreateAuction()).done(function(result){
			alert('Your auction has been created.');
			window.location.href = '/BuyMe/Member/viewAuctions.jsp';
		});
	});
}

Date.prototype.addDays = function(days) {
    var date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
}

function CreateAuction(){
	debugger;
	var startTime = new Date();
	startTime = startTime.addDays(parseInt($('#ddlAuctionLength').val()));
	startTime = kendo.toString(startTime, "yyyy-MM-dd HH:mm:ss");
	var queryData = {
		fn: 'auctionsAddNew',
		title: $('#txtTitle').val(),
		startTime: startTime,
		itemType: $('#ddlItemType').val(),
		initialPrice: $('#txtInitialPrice').val(),
		bidIncrement: $('#txtBidIncrement').val(),
		minPrice: $('#txtMinPrice').val(),
		description: $('#txtDescription').val(),
		owner: $('#lblnavBarUserName').text()
	}
	
	return $.ajax({
		type:'POST',
		url:'/BuyMe/CreateAuctionAjaxController',
		data: queryData
	});
}

