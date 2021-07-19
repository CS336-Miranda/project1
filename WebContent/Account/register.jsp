<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="/master.html"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Registration Form</title>
   </head>
   <body>
     <form action="registerNewUser.jsp" method="POST">
     
         <div id="divAuth">
            <img id="productLogo" src="${pageContext.request.contextPath}/Images/BuyMeLogo.png">
            <div class="divAppTitle">Group 10 - CS336 Summer 2021</div>
            <div class="register">
                <input id="username" type="text" placeholder="Username" name="username">  
                <input id="password" type="password" placeholder="password" name="password"> 
                 
              <input type="submit" id="btnSignIn" value="Register">
              <div class="registerLink"><a href="login.jsp">Return to log in</a></div>
            </div>
            <div class="shadow"></div>
        </div>
     
     </form>
   </body>
</html>