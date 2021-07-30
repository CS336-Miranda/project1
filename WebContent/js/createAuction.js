$(document).ready(function(){
	InitializeCurrencyFields();
	InitializeFormValidator();
	InitializeEventHandlers_createAuction();
});

function InitializeEventHandlers_createAuction(){
	$('input[type="number"].int').on('keydown', function(e){
		if(event.key==='.'){event.preventDefault();}
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
	
}

function ModifyFormValidatedFields(){
	

}

function InitializeCurrencyFields(){
	$('.currency').on('change', function(e){
		$(this).val(parseFloat($(this).val()).toFixed(2));
	});	
}

function InitializeFormValidator(){
	$('#validatedForm').bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            Title: {
                validators: {
                    notEmpty: {
                        message: 'Title is required and cannot be empty'
                    }
                }
            },
			AuctionLength: {
                validators: {
                    notEmpty: {
                        message: 'Auction Length is required.'
                    }
                }
            },
			SubCategory: {
                validators: {
                    notEmpty: {
                        message: 'Subcategory is required.'
                    }
                }
            },
			InitialPrice: {
                validators: {
                    notEmpty: {
                        message: 'Initial Price is required.'
                    }
                }
            },
			BidIncrement: {
                validators: {
                    notEmpty: {
                        message: 'Bid Increment is required.'
                    }
                }
            },
			MinPrice: {
                validators: {
                    notEmpty: {
                        message: 'Min. Reserve Price is required.'
                    }
                }
            },
			Description: {
                validators: {
                    notEmpty: {
                        message: 'Description is required.'
                    }
                }
            }
        },
        submitHandler: function(validator, form, submitButton) {
            CreateAuction();
			alert('Your auction has been created.');
			window.location.href = '/BuyMe/Member/viewAuctions.jsp';
        }
    });

}


Date.prototype.addDays = function(days) {
    var date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
}

function CreateAuction(){
	var startTime = new Date();
	startTime = startTime.addDays(parseInt($('#ddlAuctionLength').val()));
	startTime = kendo.toString(startTime, 'yyyy-MM-dd HH:mm:ss');
	var queryData = {
		fn: 'auctionsAddNew',
		title: $('#txtTitle').val(),
		startTime: startTime,
		itemType: $('#ddlSubCategory').val(),
		initialPrice: $('#txtInitialPrice').val(),
		bidIncrement: $('#txtBidIncrement').val(),
		minPrice: $('#txtMinPrice').val(),
		description: $('#txtDescription').val(),
		owner: $('#lblnavBarUserName').text(),
		category: $('#ddlCategory').val(),
		subcategory: $('#ddlSubCategory').val(),
		laptopTouchscreen: $('#ddlLaptopTouchScreen').val(),
		cellphoneProvider: $('#txtCellphoneProvider').val(),
		tvSize: $('#txtTVSize').val()
	}
	
	return $.ajax({
		type:'POST',
		url:'/BuyMe/CreateAuctionAjaxController',
		data: queryData
	});
}


