//(function () {
	var formValidationOccurred = false;

	$(document).ready(function(){
		var auctionId = GetParameterByName('auctionId');
		$.when(GetAuction(auctionId)).done(function(auctionData){
			auctionData = JSON.parse(auctionData).d[0];
			PopulateAuctionDetails(auctionData)
			InitializeCurrencyFields();
			DisableSelectFields();
			InitializeEventHandlers();	
			$('.auctionDetails').fadeIn();
		});
	});
	
	function PopulateAuctionDetails(data){
		$('#txtTitle').val(data.title);
		$('#txtDescription').text(data.description);
		$('#txtStartTime').val(kendo.toString(kendo.parseDate(data.startTime), "ddd MMM dd, yyyy h:mm tt" ));
		$('#txtCloseTime').val(kendo.toString(kendo.parseDate(data.closeTime), "ddd MMM dd, yyyy h:mm tt" ));
		if(!data.highestBid){
			$('#txtCurrentHighBid').val('No bids yet... Get things started!');
		}else{
			$('#txtCurrentHighBid').val(data.highestBid);
		}
		$('#txtCurrentHighBid').val(data.highestBid);
		
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
	
	/*function CreateAuction(){
		var startTime = new Date();
		startTime = startTime.addDays(parseInt($('#ddlAuctionLength').val()));
		startTime = kendo.toString(startTime, 'yyyy-MM-dd HH:mm:ss');
		var queryData = {
			fn: 'auctionsAddNew',
			title: $('#txtTitle').val(),
			description: $('#txtDescription').val(),
			name: $('#txtName').val(),
			category: $('#ddlCategory').val(),
			subcategory: $('#ddlSubCategory').val(),
			laptopTouchscreen: $('#ddlLaptopTouchScreen').val(),
			cellphoneProvider: $('#txtCellphoneProvider').val(),
			tvSize: $('#txtTVSize').val(),
			company: $('#txtCompany').val(),
			year: $('#txtYear').val(),
			color: $('#txtColor').val(),
			startTime: startTime,
			initialPrice: $('#txtInitialPrice').val(),
			bidIncrement: $('#txtBidIncrement').val(),
			minPrice: $('#txtMinPrice').val(),
			owner: $('#lblnavBarUserName').text()
		}
		
		return $.ajax({
			type:'POST',
			url:'/BuyMe/CreateAuctionAjaxController',
			data: queryData
		});
	}*/
	
	/*function validateForm(){
		var validated = true;
		var requiredFields = ['txtTitle','txtDescription','txtName','ddlCategory','ddlSubCategory','txtCompany','txtYear','txtColor','ddlAuctionLength','txtInitialPrice','txtBidIncrement','txtMinPrice'];
		
		if($('#ddlSubCategory').val() === 'laptop'){ requiredFields.push('ddlLaptopTouchScreen'); }
		else if($('#ddlSubCategory').val() === 'cellphone'){ requiredFields.push('txtCellphoneProvider'); }
		else if($('#ddlSubCategory').val() === 'tv'){ requiredFields.push('txtTVSize'); }
		
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
	}*/
//})();

