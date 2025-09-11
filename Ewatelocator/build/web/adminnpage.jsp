<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String un = request.getParameter("uname");
            String ps= request.getParameter("psd");
             
            
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
               Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
                PreparedStatement  pst = con.prepareStatement("SELECT * FROM admin WHERE adminname=? AND adminpass=?");
                pst.setString(1, un);
                pst.setString(2, ps);
                ResultSet rs = pst.executeQuery();
                
                if (rs.next()) {
               
      %>
      <br>
      
     
      <%
                   PrintWriter pt=response.getWriter();
                   response.setContentType("text/html");
                   String str1=request.getParameter("uname");
                     session.setAttribute("str1",str1 );
                     
%>
<jsp:forward page="adminhome.jsp"></jsp:forward>
 <%
      }
                else {
                    out.print("Username and password are incorrect");
                 }
            } catch (Exception ex)
                {
                out.print("Error: " + ex.getMessage());
            
            }
        %>
        
    </body>
</html>
