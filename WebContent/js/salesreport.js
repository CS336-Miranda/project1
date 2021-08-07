$(document).ready(function(){
	GetSalesReport();
});


function GetSalesReport(){
	return $.ajax({
		type:'GET',
		url:'/BuyMe/SalesReportAjaxController?fn=getsalesreport',
		success: function(result){
			return result;
		}
	});
}
	/**
 * 
 */