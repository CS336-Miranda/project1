$(document).ready(function(){
	InitializeEventHandlers();
});

function InitializeEventHandlers(){
	$('#btnCreateAuction').on('click', function(e){
		e.preventDefault();
		window.location.href='createAuction.jsp';
	});
	
	$('#btnViewAuctions').on('click', function(e){
		e.preventDefault();
		window.location.href='viewAuctions.jsp';
	});
	
	$('#btnQuestions').on('click', function(e){
		e.preventDefault();
		window.location.href='questions.jsp';
	});
	
	$('#btnAdminCenter').on('click', function(e){
		e.preventDefault();
		window.location.href='../Admin/adminCenter.jsp';
	});
	
	$('#btnCustomerRepCenter').on('click', function(e){
		e.preventDefault();
		window.location.href='../CustomerRep/customerRepCenter.jsp';
	});
}