(function () {
	var formValidationOccurred = false;

	$(document).ready(function(){
		InitializeCurrencyFields();
		InitializeEventHandlers_createAuction();
	});
	
	function InitializeEventHandlers_createAuction(){
		$('input[type="number"].int').on('keydown', function(e){
			if(event.key==='.'){event.preventDefault();}
		});
		
		$('.restrictedMinimum').change(function() {
	          var min = parseInt($(this).attr('min'));          
			  if($(this).val() < min)
	          {
	              $(this).val(min);
				  $(this).val(parseFloat($(this).val()).toFixed(2));
	          }       
        });
		
		$('#ddlSubCategory').on('change',function(e){
			$('input.subCatAttr').val('');
			$('select.boolean').val(0);
			$('.subCategoryAttributes').hide();
			$('.' + $(this).val()).fadeIn();
		});
		
		$('#txtTVSize').on('keypress', function(e){
			if(this.value.length==5) return false;
		});
		
		$('#txtYear').on('keypress', function(e){
			if(this.value.length==4) return false;
		});
		
		$('#btnCreateAuction').on('click', function(e){
			e.preventDefault();
			if(validateForm()){
				CreateAuction();
				alert('Your auction has been created.');
				window.location.href = '/BuyMe/Member/viewAuctions.jsp';			
			}
		});	
	}
	
	function InitializeCurrencyFields(){
		$(".currency").attr({"min" : 1 });
		$(".currency").addClass('restrictedMinimum');
		$('.currency').on('change', function(e){
			$(this).val(parseFloat($(this).val()).toFixed(2));
		});	
	}
	
	Date.prototype.addDays = function(days) {
	    var date = new Date(this.valueOf());
	    date.setDate(date.getDate() + days);
	    return date;
	}
	
	function CreateAuction(){
		var startTime = new Date();
		closeTime = startTime.addDays(parseInt($('#ddlAuctionLength').val()));
		startTime = kendo.toString(startTime, 'yyyy-MM-dd HH:mm:ss');
		closeTime = kendo.toString(closeTime, 'yyyy-MM-dd HH:mm:ss');

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
			closeTime: closeTime,
			initialPrice: $('#txtInitialPrice').val(),
			minPrice: $('#txtMinPrice').val(),
			owner: $('#lblnavBarUserName').text()
		}
		
		return $.ajax({
			type:'POST',
			url:'/BuyMe/CreateAuctionAjaxController',
			data: queryData
		});
	}
	
	function validateForm(){
		var validated = true;
		var requiredFields = ['txtTitle','txtDescription','txtName','ddlCategory','ddlSubCategory','txtCompany','txtYear','txtColor','ddlAuctionLength','txtInitialPrice','txtMinPrice'];
		
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
	}
})();

