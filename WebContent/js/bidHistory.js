
$(document).ready(function(){
	try{
		var auctionId = GetParameterByName('auctionId');

		$.when(GetAllBids(auctionId)).done(function(gridData){
			gridData = JSON.parse(gridData).d;
			InitializeGrid(gridData);
		});
	}catch(e){
		console.log(e);
	}
});

function GetAllBids(auctionId){
	return $.ajax({
		type:'GET',
		url:'/BuyMe/BidHistAjaxController?fn=BidsAll&auctionId=' + GetParameterByName('auctionId'),
		success: function(result){
			return result;
		}
	});
}

function InitializeGrid(gridData){
	var kendoGrid = $('#bids').data("kendoGrid");

	//Check if the element is already initialized with the Kendo Grid widget
	if (kendoGrid)//Grid is initialized
	{
	   kendoGrid.destroy();
	   $('#bids').empty();
	}
	
	$("#bids").kendoGrid({
        dataSource: {
            data: gridData,
            schema: {
                model: {
                    fields: {
						bidId: { type: "number" },
                        date: { type: "date" },
						email: { type: "string" },
                        auctionId: { type: "number" },
						upperLimit: { type: "number" },
						bidIncrement: { type: "number" },
						higherBidAlert: {type: "bool"},
						autoBid: {type:"bool"},
						bidAmount: {type:"number"}
                    }
                }
            },
            pageSize: 8,
  			sort: { field: "bidId", dir: "desc" },
        },
        height: 600,
        filterable: true,
        sortable: true,
        pageable: true,
        columns: [{
                field: "date",
                title: "Bid Date",
                format: "{0:MM/dd/yyyy hh:mm:ss tt}",
				width: 250
            },
            {
                field: "bidAmount",
                title: "Bid Amount"
            },
            {
                field: "email",
                title: "User"
            }
        ]
    });
}

function GetParameterByName(name){
    try{
        name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
        var regexString = "[\\?&]" + name + "=([^&#]*)";
        var regex = new RegExp(regexString);
        var found = regex.exec(window.location.search);
        if(found == null) { return ""; }
        return decodeURIComponent(found[1].replace(/\+/g," "));
    } catch (e) {
        console.log(e);
        return "";
    }
}

