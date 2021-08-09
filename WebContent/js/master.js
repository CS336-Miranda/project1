$(document).ready(function(){

});

function GetData(functionName,controllerName){
	if(!controllerName) { controllerName = ''; }
	return $.ajax({
		type:'GET',
		url:'/BuyMe/' + controllerName + 'AjaxController?fn=' + functionName,
		success: function(result){
			return result;
		}
	});
}

function isEmail(email) {
  var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  return regex.test(email);
}
         


function validateLoginRegisterForm(){
	if(isEmail($('#email').val()) && $('#password').val().length > 0){
  		$('#btnSignIn').attr('disabled', false);
  	}else{
  		$('#btnSignIn').attr('disabled', true);
  	}
}

function ConvertUTCToLocalTime(datetime){
	var date = new Date(datetime + ' UTC');
	return kendo.toString(date, "g");
}