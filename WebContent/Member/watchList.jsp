<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/member.html"%>
<%@include file="../MasterPages/navBar.html"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

</head>
<body>
<div class="content">
	<div class="row">
		<div class="col-10">
			<h1>My Watch List</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-10">
			<div class="mb-3">
			  <label for="txtQuestion" class="form-label">What would you like to watch?</label>
			  <textarea class="form-control" id="txtWatch" rows="3"></textarea><br/>
			  <button id="btnSubmit" type="submit" class="btn btn-primary mb-3">Watch</button>  
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-10">
			<div id="grdWatchItems"></div>
			<table id="tblWatchItems"></table>
		</div>
	</div>
</div>

   <script>   
   $.getScript("../js/watchList.js?rev=" + Date.now(), function( data, textStatus, jqxhr ) {
	 });
   </script>
</body>
</html>