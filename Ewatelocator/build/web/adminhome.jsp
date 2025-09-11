<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home Page</title>
    <link rel="stylesheet" href="adminhome.css">
</head>
<body>
    <%
        String str=(String)session.getAttribute("str1");
        
    %>
    <div class="container">
        <header>
            <h1>
            <%
                out.print("Welcom "+str+" !");
            %>
            </h1>
        </header>
        <nav>
            <ul> 
              
                <li><a href="UserProfile.jsp">User Profile</a></li>
                <li><a href="RewardTable.jsp">Reward Table</a></li>
                <li><a href="RewardHistory.jsp">Reward history</a></li>
                <li><a href="TotalScans.jsp">Total Scan</a></li>
                <li><a href="showfeedbacks.jsp">Feedbacks</a></li>
                <li><a href="Adminlogout.jsp">Logout</a></li>
            </ul>
        </nav>
        <section class="image-section">
            <img src="admin2.webp" alt=" Image">
            <img src="admin 4.jpg" alt=" Image">
            <img src="admin3.jpg" alt=" Image">
        </section>
    </div>
</body>
</html>
