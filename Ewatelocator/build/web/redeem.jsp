<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<html>
<head>
    <title>Redeem Rewards</title>
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
        select, button {
            margin-top: 10px;
            padding: 10px;
            border: none;
            border-radius: 5px;
        }
        button {
            background-color: #003e54;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #00506b;
        }
    </style>
    <script>
        function updateRewardInfo() {
            var rewardSelect = document.getElementById("rewardSelect");
            var selectedOption = rewardSelect.options[rewardSelect.selectedIndex];
            document.getElementById("rewardName").value = selectedOption.getAttribute("data-name");
            document.getElementById("rewardPoints").value = selectedOption.getAttribute("data-points");
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Redeem Rewards</h1>
        <div class="reward-box">
            <h2>Your Reward Points</h2>
            <% 
                HttpSession sessionUser = request.getSession(false);
                if (sessionUser != null && sessionUser.getAttribute("user_id") != null) {
                    int userId = (Integer) sessionUser.getAttribute("user_id");
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
                        PreparedStatement pst = con.prepareStatement("SELECT total_points FROM rewards WHERE user_id = ?");
                        pst.setInt(1, userId);
                        ResultSet rs = pst.executeQuery();
                        if (rs.next()) {
                            out.println("<h3>" + rs.getInt("total_points") + " Points</h3>");
                        } else {
                            out.println("<h3>0 Points</h3>");
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

        <h2>Select a Reward</h2>
       <form action="RedeemServlet" method="POST">
    <select name="reward" required>
        <option value="">-- Select Reward --</option>
        <option value="Free Recycling Pickup,30">Free Recycling Pickup (30 Points)</option>
        <option value="Discount Coupon,50">Discount Coupon (50 Points)</option>
        <option value="Gift Card,100">Gift Card (100 Points)</option>
    </select>
    <button type="submit">Redeem</button>
</form>


    </div>
</body>
</html>
