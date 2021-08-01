(function () {
	$(document).ready(function(){
		try{
			InitializeEventHandlers();
			$.when(GetAllAlerts()).done(function(gridData){
				gridData = JSON.parse(gridData).d;
				InitializeGrid(gridData);
			});
		}catch(e){
			console.log(e);
		}
	});

function InitializeEventHandlers(){
	
}

function GetAllAlerts(){
	return $.ajax({
		type:'GET',
		url:'/BuyMe/MyAlertsAjaxController?fn=AlertsAll&email=' + $('#lblnavBarUserName').text(),
		success: function(result){
			return result;
		}
	});
}

function InitializeGrid(gridData){
	var kendoGrid = $('#grdAlerts').data("kendoGrid");

	//Check if the element is already initialized with the Kendo Grid widget
	if (kendoGrid)//Grid is initialized
	{
	   kendoGrid.destroy();
	   $('#grdAlerts').empty();
	}
	
	$("#grdAlerts").kendoGrid({
        dataSource: {
            data: gridData,
            schema: {
                model: {
                    fields: {
						alertId: { type: "number" },
                        auctionId: { type: "number" },
						title: { type: "string" },
                        date: { type: "date" },
						markasread: { type: "bool" }
                    }
                }
            },
            pageSize: 8,
  			sort: { field: "alertId", dir: "desc" },
        },
        height: 600,
        filterable: false,
        sortable: true,
        pageable: true,
        columns: [{
                field: "date",
                title: "Alert Date",
                format: "{0:MM/dd/yyyy H:mm tt}",
				template: "#: ConvertUTCToLocalTime(date) #",
				width: 250
            },
            {
                field: "title",
                title: "Auction"
            },
            {
                field: "alertId",
                title: "Message",
				template: "#: generateAlertMessage() #"
            },
			{
                field: "markasread",
                title: " ",
				hidden: true
            },
			{ command: { text: "View Details", click: showDetails }, title: " ", width: "180px" },
			{ command: { text: "Mark as read", click: MarkAsRead }, title: " ", width: "180px", visible: function(dataItem) {
		         return dataItem.markasread;
		       } }
        ],
          dataBound: function(e) {
            // iterate the table rows and apply custom row and cell styling
            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
			  var row = $(rows[j]);
			  var dataItem = e.sender.dataItem(row);
			  var markasread = dataItem.get("markasread");
			
			  if (!markasread) {
			    row.addClass("boldGridRow");
			  }else{
				row.addClass('unReadRow');
	          }
            }
			$('tr.unReadRow a[role="button"].k-grid-Markasread').hide();
          }
    });
}

function generateAlertMessage(){
	return "You have been outbid on this item. Don't let it get away! Bid again today!";
}

function showDetails(e){
	var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
	window.location.href = '/BuyMe/Member/auctionDetails.jsp?auctionId=' + dataItem.auctionId;
}

function MarkAsRead(e){
	var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
	var alertId = dataItem.alertId;

	
	$.when(_markAsRead(alertId)).done(function(result){
		$.when(GetAllAlerts()).done(function(gridData){
			gridData = JSON.parse(gridData).d;
			InitializeGrid(gridData);
		});
	});
}

function _markAsRead(alertId){
	var functionName = 'myAlertsMarkAsRead';
	var queryData = {
		fn: functionName,
		alertId: alertId
	}
	
	return $.ajax({
		type:'POST',
		url:'/BuyMe/MyAlertsAjaxController',
		data: queryData
	});
}

})();
