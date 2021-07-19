<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="/master.html"%>
<!DOCTYPE html>
<html>
   <head>
   </head>
   <body>
     <form action="checkLoginDetails.jsp" method="POST">
     
     	<div id="divAuth">
            <img id="productLogo" src="${pageContext.request.contextPath}/Images/BuyMeLogo.png">
            <div class="divAppTitle">Group 10 - CS336 Summer 2021</div>
            <div class="login">
                <input id="username" type="text" placeholder="Username" name="username">  
                <input id="password" type="password" placeholder="password" name="password"> 
                 
              <input type="submit" id="btnSignIn" value="Sign In">
              <div class="registerLink"><a href="register.jsp">New User? Register here</a></div>
            </div>
            <div class="shadow"></div>
        </div>
     </form>
     
   </body>
</html>