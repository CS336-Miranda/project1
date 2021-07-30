$(document).ready(function(){
	InitializeCurrencyFields();
	//InitializeFormValidator();
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
		InitializeFormValidator();
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
		CreateAuction();
		alert('Your auction has been created.');
		window.location.href = '/BuyMe/Member/viewAuctions.jsp';
	});
	
}

function InitializeCurrencyFields(){
	$('.currency').on('change', function(e){
		$(this).val(parseFloat($(this).val()).toFixed(2));
	});	
}

function InitializeFormValidator(){
	/*var bootstrapValidator = $('#validatedForm').data('bootstrapValidator');

	if(bootstrapValidator !== undefined){ 
		bootstrapValidator.destroy();
		$('#validatedForm').data('bootstrapValidator', null);
		$('#validatedForm').bootstrapValidator(); 	
	}*/
	$('#validatedForm').bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: requiredFields(),
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
}

function requiredFields(){
	switch($('#ddlSubCategory').val()){
		/*case 'cellphone':
			var fields = {
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
	            },
				CellphoneProvider: {
					validators: {
						notEmpty: {
							message: 'Provider is required.'
						}
					}
				}
			};

			break;*/
		default:
			var fields = {
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
				/*InitialPrice: {
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
	            },*/
				Description: {
	                validators: {
	                    notEmpty: {
	                        message: 'Description is required.'
	                    }
	                }
	            },
				CellphoneProvider: {
					validators: {
						notEmpty: {
							message: 'Provider is required.'
						}
					}
				}
			};
		}
	
	return fields;
	
}

