(function () {
	var formValidationOccurred = false;
	var bidId = 0;
	var winnerAlerted = 0;
	var minPrice = 0;
	
	$(document).ready(function(){
		var auctionId = GetParameterByName('auctionId');
		$.when(GetAuction(auctionId)).done(function(auctionData){
			auctionData = JSON.parse(auctionData).d[0];			
			PopulateAuctionDetails(auctionData);
			EstablishMinimumBidAmount(auctionData);
			InitializeCurrencyFields();
			DisableSelectFields();
			OnlyAllowUpdateLimitIfUserIsHighBidder(auctionData);
			InitializeEventHandlers();
			$('.auctionDetails').fadeIn();
		});
	});
	
	function OnlyAllowUpdateLimitIfUserIsHighBidder(auctionData){
		if($('#txtCurrentHighBidder').val() !== $('#lblnavBarUserName').text()){ 
			$('.rowUpdateLimitBtn').remove(); 
			return true; 
		}else if($('#txtCurrentHighBidder').val() === $('#lblnavBarUserName').text()){ 
			//Erwin: I know this else if is redundant after the return above but I prefer to double check the condition here
			bidId = auctionData.bidId;
			$('.rowSubmitBtn').hide();
			$('#txtUpdateBidLimit').val(auctionData.upperLimit);
			$('#txtUpdateBidLimit').attr('placeholder',auctionData.upperLimit);
			$("txtUpdateBidLimit").attr({"min" : auctionData.upperLimit });
			$('#txtUpdateBidIncrement').val(auctionData.highBidderBidIncrement);
			$('#txtUpdateBidIncrement').attr('placeholder',auctionData.highBidderBidIncrement);
			$("txtUpdateBidIncrement").attr({"min" : 0 });
			$('#chkUpdateHighBidAlert').prop('checked',auctionData.higherBidAlert);
			$('.rowUpdateLimitBtn').show();
		}
	}
	
	function EstablishMinimumBidAmount(data){
		var bidIncrement = 1;
		$("#txtBidIncrement").attr({"min" : bidIncrement });
		
		var minBidAmount = data.highestBid ? parseFloat(data.highestBid) +  parseFloat(bidIncrement) : parseFloat(bidIncrement);
		$('#txtBidAmount').attr('placeholder', minBidAmount.toFixed(2));
		$("#txtBidAmount").attr({"min" : minBidAmount });
	}
	
	function PopulateAuctionDetails(data){
		$('#lblTitle').text(data.title);
		$('#txtDescription').text(data.description);
		$('#txtStartTime').val(kendo.toString(kendo.parseDate(data.startTime), "ddd MMM dd, yyyy h:mm tt" ));
		$('#txtCloseTime').val(kendo.toString(kendo.parseDate(data.closeTime), "ddd MMM dd, yyyy h:mm tt" ));

		if(!data.highestBid){
			$('#lblCurrentHighBid').text('No bids');
			$('#txtCurrentHighBid').hide();
		}else{
			//$('#lblCurrentHighBid').hide();
			$('#txtCurrentHighBid').val(data.highestBid);
			$('#txtCurrentHighBidder').val(data.highBidder);
		}
		
		var closeTime = kendo.parseDate(data.closeTime);
		InitializeCountdownTimer(closeTime);
		
		$('#txtName').val(data.name);
		$('#txtCategory').val('Electronics');
		var subCategory = data.provider.length > 0 ? 'Cellphone' : data.size.length > 0 ? 'TV' : 'Laptop';
		$('#txtSubCategory').val(subCategory);
		
		$('#txtCompany').val(data.company);
		
		$('#txtYear').val(data.year);
		$('#txtColor').val(data.color);
		
		winnerAlerted = data.winnerAlerted;
		minPrice = data.minPrice;
	}
	
	function InitializeCountdownTimer(closeTime){
		$('#divCountdownTimer').countdown({
			until: closeTime, 
			padZeroes: true,
			expiryText: 'Auction has ended!',
			onExpiry: AuctionEnded
		});
		
	}
	
	function AuctionEnded(){
		$('.rowSubmitBtn').remove();
		$('.rowUpdateLimitBtn').remove();	
		$('#lblCurrentHighBid2').text('Winning Bid:');
		$('#lblCurrentHighBidder').val('Winner:');
		
		if(parseFloat($('txtCurrentHighBid').val()) < minPrice){
			$('#lblCurrentHighBid').text('Reserve not met');
			$('#lblCurrentHighBid').show();
			$('#txtCurrentHighBid').hide();
			$('#txtCurrentHighBidder').val('No Winner');
		}else{
			if(!winnerAlerted){
				AlertWinner();
			}	
		}
	}
	
	function DisableSelectFields(){
		$('select option:not(:selected)').attr('disabled',true);
	}
	
	function InitializeEventHandlers(){
		$('.currency').on('change', function(e){
			$(this).val(parseFloat($(this).val()).toFixed(2));
		});
		
		$('#btnSubmitBid').on('click', function(e){
			e.preventDefault();
			if(validateForm('bid')){
				$.when(SubmitBid()).done(function(result){
					alert('Your bid has been submitted');
					window.location.href = window.location.href;
				});
			}			
		});
		
		$('#btnUpdateBid').on('click',function(e){
			e.preventDefault();
			if(validateForm('update')){
				$.when(UpdateBid()).done(function(result){
					alert('Your bid has been updated');
					window.location.href = window.location.href;
				});
			}	
		});
		
		$('#btnViewBidHistory').on('click', function(e){
			window.location.href = '/BuyMe/Member/viewbidhistory.jsp?auctionId=' + GetParameterByName('auctionId');
		});
	}
	
	function GetAuction(auctionId){
		return $.ajax({
			type:'GET',
			url:'/BuyMe/BiddingAjaxController?fn=GetAuction&auctionId=' + auctionId,
			success: function(result){
				return result;
			}
		});
	}
	
	function InitializeCurrencyFields(){
		$.each($('.currency'), function(i, field){
			$(field).val(parseFloat($(field).val()).toFixed(2));
		});
	}
	
	Date.prototype.addDays = function(days) {
	    var date = new Date(this.valueOf());
	    date.setDate(date.getDate() + days);
	    return date;
	}
	
	function GetParameterByName(name){
        try{
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexString = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexString);
            var found = regex.exec(window.location.search);
            if(found == null) { return ""; }
            return decodeURIComponent(found[1].replace(/\+/g," "));
        } catch (e) {
            console.log(e);
            return "";
        }
    }
	
	function AlertWinner(){		
		var queryData = {
			fn: 'bidAlertWinner',
			winner: $('#lblnavBarUserName').text(),
			auctionId: GetParameterByName('auctionId'),
			timestamp: kendo.toString(new Date(), 'yyyy-MM-dd HH:mm:ss'),
		}
		return $.ajax({
			type:'POST',
			url:'/BuyMe/BiddingAjaxController',
			data: queryData
		});
	}
	
	function SubmitBid(){
		var previousHighBid = $('#txtCurrentHighBid').val().length === 0 ? 0 : $('#txtCurrentHighBid').val();
		var upperLimit = $('#txtBidAmount').val().length === 0 ? $('#txtBidAmount').attr('placeholder') : $('#txtBidAmount').val();
		var bidIncrement = $('#txtBidIncrement').val().length === 0 ? 1 : $('#txtBidIncrement').val();
		
		var queryData = {
			fn: 'bidAddNew',
			bidder: $('#lblnavBarUserName').text(),
			auctionId: GetParameterByName('auctionId'),
			higherBidAlert: !$('#chkHighBidAlert').is(':checked') ? 0 : 1,
			upperLimit: upperLimit,
			bidIncrement: bidIncrement,
			timestamp: kendo.toString(new Date(), 'yyyy-MM-dd HH:mm:ss'),
			previousHighBid: previousHighBid
		}
		return $.ajax({
			type:'POST',
			url:'/BuyMe/BiddingAjaxController',
			data: queryData
		});
	}
	
	function UpdateBid(){
		var upperLimit = $('#txtUpdateBidLimit').val().length === 0 ? $('#txtUpdateBidLimit').attr('placeholder') : $('#txtUpdateBidLimit').val();
		var bidIncrement = $('#txtUpdateBidIncrement').val().length === 0 ? 1 : $('#txtUpdateBidIncrement').val();
		
		var queryData = {
			fn: 'bidUpdate',
			bidder: $('#lblnavBarUserName').text(),
			higherBidAlert: !$('#chkUpdateHighBidAlert').is(':checked') ? 0 : 1,
			upperLimit: upperLimit,
			bidIncrement: bidIncrement,
			bidId: bidId
		}
		return $.ajax({
			type:'POST',
			url:'/BuyMe/BiddingAjaxController',
			data: queryData
		});
	}
	
	function validateForm(submitType){
		var validated = true;
		//var requiredFields = ['txtBidAmount','txtBidIncrement'];
		requiredFields = [];
		
		$.each(requiredFields, function(i, fieldName){
			var field = $('#' + fieldName);
			if(field && field.val().length === 0){
				field.addClass('is-invalid');
				validated = false;
			}else{
				field.removeClass('is-invalid');
			}
		});
		
		if(!formValidationOccurred){
			$('#createAuctionForm').on('change', function(e){
				validateForm();
			});	
			formValidationOccurred = true;
		}
		
		return validated;
	}
})();

