$(document).ready(function(){
	InitializeEventHandlers();
});

function InitializeEventHandlers(){
	$('#btnViewaccounts').on('click', function(e){
		e.preventDefault();
		window.location.href='../CustomerRep/viewaccounts.jsp';
	});
	$('#btnDeleteauction').on('click', function(e){
		e.preventDefault();
		window.location.href='../CustomerRep/deleteauction.jsp';
	});
	$('#btnRemovebids').on('click', function(e){
		e.preventDefault();
		window.location.href='../CustomerRep/removebids.jsp';
	});
	
	}/**

 * 
 */