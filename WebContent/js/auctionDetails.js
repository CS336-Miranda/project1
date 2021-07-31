//(function () {
	var formValidationOccurred = false;
	//var bidIncrement = 0;
	//var minBidAmount = 0;
	
	$(document).ready(function(){
		var auctionId = GetParameterByName('auctionId');
		$.when(GetAuction(auctionId)).done(function(auctionData){
			auctionData = JSON.parse(auctionData).d[0];
			console.log(auctionData);
			PopulateAuctionDetails(auctionData);
			EstablishMinimumBidAmount(auctionData);
			InitializeCurrencyFields();
			DisableSelectFields();
			InitializeEventHandlers();	
			$('.auctionDetails').fadeIn();
		});
	});
	
	function EstablishMinimumBidAmount(data){
		var bidIncrement = 1;//parseFloat(data.bidIncrement);
		//minBidAmount = data.highestBid ? parseFloat(data.highestBid) +  parseFloat(data.bidIncrement) : parseFloat(data.bidIncrement);
		var minBidAmount = data.highestBid ? parseFloat(data.highestBid) +  parseFloat(bidIncrement) : parseFloat(bidIncrement);
		$('#txtBidAmount').attr('placeholder', minBidAmount.toFixed(2));
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
			$('#lblCurrentHighBid').hide();
			$('#txtCurrentHighBid').val(data.highestBid);
			$('#txtCurrentHighBidder').val(data.email);
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
	}
	
	function InitializeCountdownTimer(closeTime){
		$('#divCountdownTimer').countdown({until: closeTime, padZeroes: true});
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
			if(validateForm()){
				$.when(SubmitBid()).done(function(result){
					alert('Your bid has been submitted');
					window.location.href = window.location.href;
					/*$.when(GetHighBid()).done(function(highBid){
						highBid = JSON.parse(highBid).d[0];
						SetNewHighBid(highBid);
						alert('Your bid has been submitted');
						//window.location.href = window.location.href;
					});*/
				});
			}			
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
	
	/*function GetHighBid(){
		return $.ajax({
			type:'GET',
			url:'/BuyMe/BiddingAjaxController?fn=GetHighBid&auctionId=' + GetParameterByName('auctionId'),
			success: function(result){
				return result;
			}
		});
	}*/
	
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
	
	function SubmitBid(){
		var previousHighBid = $('#txtCurrentHighBid').val().length === 0 ? 0 : $('#txtCurrentHighBid').val();
		var upperLimit = $('#txtBidAmount').val().length === 0 ? $('#txtBidAmount').attr('placeholder') : $('#txtBidAmount').val();
		var bidIncrement = $('#txtBidIncrement').val().length === 0 ? 1 : $('#txtBidIncrement').val();
		//var bidAmount = parseFloat(previousHighBid) + parseFloat(bidIncrement);
		
		var queryData = {
			fn: 'bidAddNew',
			bidder: $('#lblnavBarUserName').text(),
			auctionId: GetParameterByName('auctionId'),
			higherBidAlert: !$('#chkHighBidAlert').is(':checked') ? 0 : 1,
			upperLimit: upperLimit,
			bidIncrement: bidIncrement,
			//bidAmount: bidAmount,
			timestamp: kendo.toString(new Date(), 'yyyy-MM-dd HH:mm:ss'),
			previousHighBid: previousHighBid
		}
		return $.ajax({
			type:'POST',
			url:'/BuyMe/BiddingAjaxController',
			data: queryData
		});
	}
	
	function validateForm(){
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
//})();

