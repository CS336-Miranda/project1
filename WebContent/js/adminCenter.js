$(document).ready(function(){
	InitializeEventHandlers();
});

function InitializeEventHandlers(){
	$('#btnRegisterrep').on('click', function(e){
		e.preventDefault();
		window.location.href='../Admin/registerrep.jsp';
	});
	
	}/**
 * 
 */