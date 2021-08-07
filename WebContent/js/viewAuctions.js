
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
	$('#email-filter').on('click', function(){
		$.when(GetUserAuctions()).done(function(gridData){
			gridData = JSON.parse(gridData).d;
			UserAuctionsGrid(gridData);
		});
	});	
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

function GetUserAuctions(){
	
	var user = { email: $('#userEmail').val()}
	
	return $.ajax({
		type:'GET',
		url:'/BuyMe/ViewAuctionsAjaxController?fn=UserAuctions',
		data:user,
		success: function(result){
			return result;
		}
	});
}

function UserAuctionsGrid(gridData){
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
                        description: { type: "string" }
                    }
                }
            },
            pageSize: 12,
  			sort: [{ field: "closeTime", dir: "asc" },{ field: "auctionId", dir: "desc" }]
        },
        height: 800,
        filterable: true,
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
                field: "closeTime",
                title: "Auction Ends",
                format: "{0:MM/dd/yyyy hh:mm tt}",
    			width: 250
            },
			{ command: { text: "View Details", click: showDetails }, title: " ", width: "180px" }
        ]
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
            pageSize: 12,
  			sort: [{ field: "closeTime", dir: "asc" },{ field: "auctionId", dir: "desc" }]
        },
        height: 800,
        filterable: true,
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


