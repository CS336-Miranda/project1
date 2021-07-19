$(document).ready(function(){
	
});

function isEmail(email) {
  var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  return regex.test(email);
}

function InitializeLoginRegisterEventHandlers(){
	 $('.validate').on('keyup', function(){
		 validateLoginRegisterForm(); 
	 });
}
function validateLoginRegisterForm(){
	if(isEmail($('#email').val()) && $('#password').val().length > 0){
  		$('#btnSignIn').attr('disabled', false);
  	}else{
  		$('#btnSignIn').attr('disabled', true);
  	}
}