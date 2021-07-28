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

function GetAllQuestions(){
	$.when(GetData('QuestionsAll','Questions')).done(function(data){
		//InitializeDataTable(JSON.parse(data).d);
		InitializeQuestionsGrid(JSON.parse(data).d);
		
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
            pageSize: 20,
  			sort: { field: "askTime", dir: "desc" },
        },
        height: 550,
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

function ConvertUTCToLocalTime(askTime){
	var date = new Date(askTime + ' UTC');
	return date;
}
