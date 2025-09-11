<%-- 
    Document   : showfeedbacks
    Created on : 23-Mar-2025, 11:45:40 pm
    Author     : anike
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Feedback List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #003e54;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #003e54;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .back-btn {
            display: block;
            width: 150px;
            text-align: center;
            padding: 10px;
            margin: 20px auto;
            background-color: #003e54;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }
        .back-btn:hover {
            background-color: #00263a;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Feedback Submissions</h2>

    <table>
        <tr>
            <th>Feedback ID</th>
            <th>User Name</th>
            <th>Email</th>
            <th>Rating</th>
            <th>Feedback</th>
            <th>Submitted On</th>
        </tr>
        
        <%
            // Database connection
            String url = "jdbc:mysql://localhost:3306/ewastelocator";
            String user = "root";  // Change if needed
            String password = "";  // Change if password exists

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);
                String sql = "SELECT * FROM feedback ORDER BY timestamp DESC";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("feedback_id") %></td>
            <td><%= rs.getString("user_name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getInt("rating") %> / 5</td>
            <td><%= rs.getString("feedback_text") %></td>
            <td><%= rs.getTimestamp("timestamp") %></td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <tr>
            <td colspan="6" style="text-align:center; color:red;">Error loading feedback.</td>
        </tr>
        <%
            }
        %>
    </table>

    <a href="adminhome.jsp" class="back-btn">Back to Admin Panel</a>
</div>

</body>
</html>

