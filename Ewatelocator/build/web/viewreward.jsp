<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<html>
<head>
    <title>Reward Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .container {
            width: 60%;
            margin: auto;
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            margin-top: 50px;
        }
        h1 {
            color: #003e54;
        }
        .reward-box {
            background-color: #003e54;
            color: white;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
        }
        .reward-history {
            margin-top: 20px;
            text-align: left;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #003e54;
            color: white;
        }
        
    </style>
</head>
<body>
    <div class="container">
        <h1>Reward Dashboard</h1>
        <div class="reward-box">
            <h2>Your Reward Points</h2>
            <% 
                HttpSession sessionUser = request.getSession(false);
                if (sessionUser != null && sessionUser.getAttribute("user_id") != null) {
                    int userId = (Integer) sessionUser.getAttribute("user_id");
                    //out.println("<p>Session User ID: " + userId + "</p>");

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
                        PreparedStatement pst = con.prepareStatement("SELECT total_points FROM rewards WHERE user_id = ?");
                        pst.setInt(1, userId);
                        ResultSet rs = pst.executeQuery();
                        if (rs.next()) {
                            int totalPoints = rs.getInt("total_points");
                            out.println("<h3>" + totalPoints + " Points</h3>");
                            //out.println("<p>Debug: Found points in DB</p>");
}                       else {
                            out.println("<h3>0 Points</h3>");
                            //out.println("<p>Debug: No points found for this user_id</p>");
}
                        con.close();
                    } catch (Exception e) {
                        out.println("<p>Error fetching rewards.</p>");
                    }
                } else {
                    response.sendRedirect("login.html");
                }
            %>
        </div>
        <a href="redeem.jsp" style="
    display: inline-block;
    margin-top: 10px;
    padding: 10px 20px;
    background-color: white;
    color: #003e54;
    text-decoration: none;
    font-weight: bold;
    border-radius: 5px;
    border: 2px solid #003e54;
    transition: 0.3s;">
    Redeem Rewards
</a>


        <div class="reward-history">
            <h2>Reward History</h2>
            <table>
                <tr>
                    <th>Date</th>
                    <th>Description</th>
                    <th>Points Used</th>
                </tr>
                <% 
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
                        PreparedStatement pst = con.prepareStatement("SELECT timestamp, reward_description, points_used FROM reward_history WHERE user_id = ? ORDER BY timestamp DESC");
                        pst.setInt(1, (Integer) sessionUser.getAttribute("user_id"));
                        ResultSet rs = pst.executeQuery();
                        boolean hasHistory = false;
                        while (rs.next()) {
                            hasHistory = true;
                %>
                <tr>
                    <td><%= rs.getTimestamp("timestamp") %></td>
                    <td><%= rs.getString("reward_description") %></td>
                    <td><%= rs.getInt("points_used") %></td>
                </tr>
                <%
                        }
                        if (!hasHistory) {
                %>
                <tr><td colspan="3">No reward history found.</td></tr>
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='3'>Error loading history.</td></tr>");
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
