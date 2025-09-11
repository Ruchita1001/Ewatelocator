<%-- 
    Document   : UserProfile
    Created on : 14-May-2024, 2:34:25 pm
    Author     : DELL
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 800px;
        margin: 50px auto;
        background-color: #fff;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h1 {
        text-align: center;
        margin-bottom: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
    

<div class="container">
    <h1>User Profile</h1>
    <table>
        <tr>
            <th>Username</th>
            <th>Email</th>
            <th>Password</th>
            <th>Phone Number</th>
            <th>Address</th>
            <th>Date</th>
        </tr>
        <tr>
            <% 
       try {
                Class.forName("com.mysql.cj.jdbc.Driver");
               Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
                PreparedStatement  pst = con.prepareStatement("select * from ewaste");
                ResultSet rs=pst.executeQuery();
               while(rs.next())
               {
                String uname=rs.getString(1);
                String email =rs.getString(2);
                String pass=rs.getString(3);
                String pno =rs.getString(4);
                String add=rs.getString(5);
                String dat=rs.getString(6);
                
        %>
        <tr>
            <td><%=uname%></td>
            <td><%=email%></td>
            <td><%=pass%></td>
            <td><%=pno%></td>
            <td><%=add%></td>
            <td><%= dat%></td>
           
        </tr>
        <%
            }
      }
            catch (Exception ex)
                {
                out.print("Error: " + ex.getMessage());
            
            }
%>
        </tr>
        <!-- Add more rows for additional users -->
    </table>
</div>
       
</body>
</html>
