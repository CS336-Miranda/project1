
	$(document).ready(function(){
		try{
			InitializeEventHandlers();
			$.when(GetAllAuctions()).done(function(gridData){
				gridData = JSON.parse(gridData).d;
				InitializeGrid(gridData);
			});
		}catch(e){
			console.log(e);
		}
	});

function InitializeEventHandlers(){
	
}

function GetAllAuctions(){
	return $.ajax({
		type:'GET',
		url:'/BuyMe/ViewAuctionsAjaxController?fn=AuctionsAll',
		success: function(result){
			return result;
		}
	});
}

function InitializeGrid(gridData){
	var kendoGrid = $('#auctions').data("kendoGrid");
	//Check if the element is already initialized with the Kendo Grid widget
	if (kendoGrid)//Grid is initialized
	{
	   kendoGrid.destroy();
	   $('#auctions').empty();
	}
	
	$("#auctions").kendoGrid({
        dataSource: {
            data: gridData,
            schema: {
                model: {
                    fields: {
                    	auctionId: {type:"number"},
                    	closeTime: { type: "date" },
                    	startTime: { type: "date" },
						title: { type: "string" },
                        description: { type: "string" },
						highest: { type: "number" }
                    }
                }
            },
            pageSize: 8,
  			sort: [{ field: "closeTime", dir: "asc" },{ field: "auctionId", dir: "desc" }]
        },
        height: 600,
        filterable: false,
        sortable: true,
        pageable: true,
        columns: [{
                field: "title",
                title: "Auction Title"
            },
            {
                field: "description",
                title: "Description"
            },
            {
                field: "highest",
                title: "Current Bid",
				format: "{0:c2}"
            },
			{
                field: "closeTime",
                title: "Auction Ends",
                format: "{0:MM/dd/yyyy hh:mm tt}",
    			width: 250
            },
			{ command: { text: "View Details", click: showDetails }, title: " ", width: "180px" }
        ]
        });
}

function showDetails(e){
	var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
	window.location.href = '/BuyMe/Member/auctionDetails.jsp?auctionId=' + dataItem.auctionId;
}


