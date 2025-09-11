<%-- 
    Document   : TotalScans
    Created on : 23-Mar-2025, 9:56:01 pm
    Author     : anike
--%>

<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Total Scans</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1000px;
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
    <h1>Total Scans</h1>
    <table>
        <tr>
            <th>Scan ID</th>
            <th>User ID</th>
            <th>Center ID</th>
            <th>Timestamp</th>
            <th>Latitude</th>
            <th>Longitude</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
                PreparedStatement pst = con.prepareStatement("SELECT * FROM scans ORDER BY timestamp DESC");
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("scan_id") %></td>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getInt("center_id") %></td>
            <td><%= rs.getTimestamp("timestamp") %></td>
            <td><%= rs.getDouble("latitude") %></td>
            <td><%= rs.getDouble("longitude") %></td>
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
