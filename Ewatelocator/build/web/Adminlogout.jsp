<%-- 
    Document   : Adminlogout
    Created on : 14-May-2024, 2:31:01 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout-Page</title>
    <a href="../../ewaste/web/Adminlogout.jsp"></a>
    </head>
    <body>
       <% 	session.invalidate(); 
	response.sendRedirect("index.html");%>
    </body>
</html>