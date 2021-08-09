$(document).ready(function(){
	InitializeEventHandlers();
	GetAllQuestions();
});

function InitializeEventHandlers(){
	$("#btnSubmit").click(function(){
		$.when(PostQuestion()).done(function(result){
			$('#txtQuestion').val('');
			GetAllQuestions();
		});
	});
	
	$('#filtering').on('click', function(){
		$.when(GetQuestionsBy()).done(function(gridData){
			gridData = JSON.parse(gridData).d;
			InitializeQuestionsGrid(gridData);
		});
	});
}

function PostQuestion(){
	var functionName = 'questionsAddNew';
	var userQuestion = $('#txtQuestion').val();
	var queryData = {
		fn: functionName,
		question: userQuestion,
		email: $('#lblnavBarUserName').text(),
		timestamp: new Date().toISOString().slice(0, 19).replace('T', ' ')
	}
	
	return $.ajax({
		type:'POST',
		url:'/BuyMe/QuestionsAjaxController',
		data: queryData
	});
}

function GetQuestionsBy(){
	
	var criteria = {val: $('#filter').val()}
	
	return $.ajax({
		type:'GET',
		url:'/BuyMe/QuestionsAjaxController?fn=QuestionsBy',
		data:criteria,
		success: function(result){
			return result;
		}
	});
}

function GetAllQuestions(){
	$.when(GetData('QuestionsAll','Questions')).done(function(data){
		//InitializeDataTable(JSON.parse(data).d);
		InitializeQuestionsGrid(JSON.parse(data).d);
		//$('#grdQuestions').text(data);
		
	});
}

function NormalizeGridData(gridData){
	
}

function InitializeQuestionsGrid(gridData){
	var kendoGrid = $('#grdQuestions').data("kendoGrid");

	//Check if the element is already initialized with the Kendo Grid widget
	if (kendoGrid)//Grid is initialized
	{
	   kendoGrid.destroy();
	   $('#grdQuestions').empty();
	}
	
	$("#grdQuestions").kendoGrid({
        dataSource: {
            data: gridData,
            schema: {
                model: {
                    fields: {
						questionId: { type: "number" },
                        question: { type: "string" },
                        askTime: { type: "date" },
						answer: { type: "string" },
						answerTime: { type: "date" }
                    }
                }
            },
            pageSize: 8,
  			sort: { field: "questionId", dir: "desc" },
        },
        height: 600,
        filterable: true,
        sortable: true,
        pageable: true,
        columns: [{
                field:"questionId",
				title: "Id",
                filterable: false,
				width: 100
            },
            {
                field: "askTime",
                title: "Asked on",
                format: "{0:MM/dd/yyyy H:mm tt}",
				template: "#: ConvertUTCToLocalTime(askTime) #"

            },{
                field: "question",
                title: "Question"
            },{
                field: "answer",
                title: "Answer"
            },{
                field: "answerTime",
                title: "Answered On"
            }
        ]
    });
}

