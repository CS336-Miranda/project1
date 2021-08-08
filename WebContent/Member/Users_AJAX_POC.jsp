<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/member.html"%>
<%@include file="../MasterPages/navBar.html"%>


<%@ page import = "org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script type="text/javascript">
	$(document).ready(function(){
		$.when(GetData('ListAllUsers')).done(function(result){
			$('#lblResult').text(result);
		});
	});
</script>
</head>
<body>
	<label id="lblResult"></label>
</body>
</html>