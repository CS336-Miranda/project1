$(document).ready(function(){
	try{
		
		$.when(GetSalesReport()).done(function(gridData){
	alert(gridData);
			gridData = JSON.parse(gridData).d;
			InitializeGrid(gridData);
		});
	}catch(e){
		console.log(e); 
		
	}
});


function GetSalesReport(){
	
	return $.ajax({
		type:'GET',
		url:'/BuyMe/SalesReportAjaxController?fn=getsalesreport',
	
		success: function(result){
			//$("#TotalEarnings").html(result);
			return result;
		}
	});
}
function InitializeGrid(gridData){
	
	var kendoGrid = $('#salesreport').data("kendoGrid");
	//Check if the element is already initialized with the Kendo Grid widget
	if (kendoGrid)//Grid is initialized
	{
	   kendoGrid.destroy();
	  $('#salesreport').empty();
	}
	
	$("#salesreport").kendoGrid({
        dataSource: {
            data: gridData,
            schema: {
                model: {
                    fields: {
                    	//auctionId: {type:"number"},
                    	//closeTime: { type: "date" },
                    	//startTime: { type: "date" },
						title: { type: "string" },
                       earningsperitem: { type: "number" },
						//title: { type: "string" },
						TotalEarnings: { type: "number"}
                    }
                }
            },


            pageSize: 12,
  			//sort: [{ field: "closeTime", dir: "asc" },{ field: "auctionId", dir: "desc" }]
	//sort: [{ field: "bidId", dir: "asc" }]
        },
        height: 800,
        filterable: true,
        sortable: true,
        pageable: true,

        columns: [{
                field: "title",
                title: "item"
            },
            /*{
                field: "description",
                title: "Description"
            },
            {
                field: "highest",
                title: "Current Bid",
				format: "{0:c2}"
            },*/
			{
                field: "earningsperitem",
                title: "Earnings Per Item",
                format: "{0:c2}",
    			
            },
			{
				field: "TotalEarnings",
				title: "Total Earnings",
				format:"{0:c2}",
				
				
			}
			
		  ]

    });
}


	/**
* 
 */