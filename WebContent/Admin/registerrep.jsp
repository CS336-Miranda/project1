<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="../MasterPages/master.html"%>
<%@include file="../MasterPages/adminMaster.html"%>
<%@include file="../MasterPages/navBar.html"%>
<!DOCTYPE html>
<html>
   <head>
   </head>
   <body>
     <form action="registerNewCustomerRep.jsp" method="POST">
     
         <div id="divAuth">
            <img id="productLogo" src="${pageContext.request.contextPath}/Images/BuyMeLogo.png">
            <div class="divAppTitle">Group 10 - CS336 Summer 2021</div>
            <div class="register">
                <input id="email" type="text" placeholder="Email" name="email" class="validate">  
                <input id="password" type="password" placeholder="Password" name="password" class="validate"> 
                 
              <input type="submit" id="btnSignIn" value="Register">
           
            </div>
            <div class="shadow"></div>
        </div>
     
     </form>
     <script>
	     $(document).ready(function(){
	    	 InitializeLoginRegisterEventHandlers(); 
	     });
	     function InitializeLoginRegisterEventHandlers(){
	    	 $('.validate').on('keyup', function(){
	    		 validateLoginRegisterForm(); 
	    	 });
     </script>
   </body>
</html>