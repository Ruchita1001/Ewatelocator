<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reward Table</title>
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
    <h1>Reward Table</h1>
    <table>
        <tr>
            <th>Reward ID</th>
            <th>User ID</th>
            <th>Total Points</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
                PreparedStatement pst = con.prepareStatement("SELECT * FROM rewards ORDER BY total_points DESC");
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("reward_id") %></td>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getInt("total_points") %></td>
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
