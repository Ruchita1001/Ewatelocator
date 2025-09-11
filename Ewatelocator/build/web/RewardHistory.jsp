<%-- 
    Document   : RewardHistory
    Created on : 23-Mar-2025, 9:52:35 pm
    Author     : anike
--%>

<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reward History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #003e54;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
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
    <h1>Reward History</h1>
    <table>
        <tr>
            <th>History ID</th>
            <th>User ID</th>
            <th>Reward Description</th>
            <th>Points Used</th>
            <th>Timestamp</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
                PreparedStatement pst = con.prepareStatement("SELECT * FROM reward_history ORDER BY timestamp DESC");
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("history_id") %></td>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getString("reward_description") %></td>
            <td><%= rs.getInt("points_used") %></td>
            <td><%= rs.getTimestamp("timestamp") %></td>
        </tr>
        <%
                }
                con.close();
            } catch (Exception ex) {
                out.print("Error: " + ex.getMessage());
            }
        %>
    </table>

    <a href="adminhome.jsp" class="back-btn">Back to Admin Panel</a>
</div>

</body>
</html>
