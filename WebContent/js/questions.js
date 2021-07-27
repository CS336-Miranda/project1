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
		email: $('#lblnavBarUserName').text()
	}
	
	return $.ajax({
		type:'POST',
		url:'/BuyMe/AjaxController',
		data: queryData
	});
}

function GetAllQuestions(){
	$.when(GetData('QuestionsAll')).done(function(data){
		//InitializeDataTable(JSON.parse(data).d);
		InitializeQuestionsGrid(JSON.parse(data).d);
		
	});
}

/*function InitializeDataTable(gridData){
	$('#tblQuestions').DataTable({
			data: gridData,
		    columns: [
		        { data: 'questionid' },
		        { data: 'question' },
		        { data: 'asktime' }
		    ]
		});
}*/

function ConvertUTCToLocalTime(dt){
	return dt;//.toLocaleDateString()
}

function InitializeQuestionsGrid(gridData){
	$("#grdQuestions").kendoGrid({
        dataSource: {
            data: gridData,
            schema: {
                model: {
                    fields: {
						questionid: { type: "number" },
                        question: { type: "string" },
                        asktime: { type: "date" }
                    }
                }
            },
            pageSize: 20,
  			sort: { field: "asktime", dir: "desc" },
        },
        height: 550,
        filterable: true,
        sortable: true,
        pageable: true,
        columns: [{
                field:"questionid",
				title: "Id",
                filterable: false,
				width: 100
            },
            {
                field: "asktime",
                title: "Asked on",
                format: "{0:MM/dd/yyyy H:mm tt}",
				template: "#: ConvertUTCToLocalTime(asktime) #"

            }, {
                field: "question",
                title: "Question"
            }
        ]
    });
}


