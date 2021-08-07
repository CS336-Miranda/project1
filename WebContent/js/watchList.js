$(document).ready(function(){
	InitializeEventHandlers();
	$.when(GetWatchList()).done(function(gridData){
		gridData = JSON.parse(gridData).d;
		WatchListGrid(gridData);
	});
});

function InitializeEventHandlers(){
	$("#addItem").click(function(){
		$.when(PostItem()).done(function(result){
			$('#itemKeyword').val('');
			
			$.when(GetWatchList()).done(function(gridData){
				gridData = JSON.parse(gridData).d;
				WatchListGrid(gridData);
			});
		});
	});
}

function PostItem(){

	var itemKeyword = $('#itemKeyword').val();
	
	var itemData = {
		keyword: itemKeyword,
		email: $('#lblnavBarUserName').text(),
	}
	
	return $.ajax({
		type:'POST',
		url:'/BuyMe/WatchListAjaxController?fn=PostItem',
		data: itemData
	});

}

function GetWatchList(){
	
	var listData = {
		email: $('#lblnavBarUserName').text()	
	}
	
	return $.ajax({
		type:'GET',
		url:'/BuyMe/WatchListAjaxController?fn=GetWatchList',
		data: listData,
		success: function(result){
			return result;
		}
	});
}

function WatchListGrid(gridData){
	var kendoGrid = $('#grdWatchItems').data("kendoGrid");

	//Check if the element is already initialized with the Kendo Grid widget
	if (kendoGrid)//Grid is initialized
	{
	   kendoGrid.destroy();
	   $('#grdWatchItems').empty();
	}
	
	$("#grdWatchItems").kendoGrid({
        dataSource: {
            data: gridData,
            schema: {
                model: {
                    fields: {
						watchId: { type: "number" },
                        keywords: { type: "string" },
                        email: { type: "string" }
                        
                    }
                }
            },
            pageSize: 8,
  			sort: { field: "watchId", dir: "desc" },
        },
        height: 600,
        filterable: true,
        sortable: true,
        pageable: true,
        columns: [{
                field: "keywords",
                title: "Watching"
            }
        ]
    });
}

