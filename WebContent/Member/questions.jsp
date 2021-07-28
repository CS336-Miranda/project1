<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/member.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<div class="content">
	<div class="row">
		<div class="col-10">
			<div class="mb-3">
			  <label for="txtQuestion" class="form-label"><h1>Ask a question</h1></label>
			  <textarea class="form-control" id="txtQuestion" rows="3"></textarea><br/>
			  <button id="btnSubmit" type="submit" class="btn btn-primary mb-3">Post</button>  
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-10">
			<div id="grdQuestions"></div>
			<table id="tblQuestions"></table>
		</div>
	</div>
</div>

   <script>   
   $.getScript("../js/questions.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	 });
   </script>
</body>
</html>