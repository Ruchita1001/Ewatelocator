<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #003e54;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
        }
        input[type="text"], input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        button {
            background-color: #003e54;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        button:hover {
            background-color: #45a049;
        }
        .profile-pic {
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: center;
            margin-bottom: 15px;
        }
        .profile-pic img {
            border-radius: 50%;
            width: 120px;
            height: 120px;
            object-fit: cover;
            border: 3px solid #003e54;
        }
    </style>
</head>
<body>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user_id") == null) {
        response.sendRedirect("login.html");
        return;
    }
    int userId = (int) userSession.getAttribute("user_id");
    
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    byte[] imageBytes = null;
    String profilePic = "default-profile.png";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");
        
        String query = "SELECT username, email, password, phoneno, address, date, photo FROM ewaste WHERE user_id=?";
        pst = con.prepareStatement(query);
        pst.setInt(1, userId);
        rs = pst.executeQuery();

        if (rs.next()) {
            imageBytes = rs.getBytes("photo");
            if (imageBytes != null) {
                profilePic = "data:image/jpeg;base64," + new String(java.util.Base64.getEncoder().encode(imageBytes));
            }
%>

<div class="container">
    <h2>User Profile</h2>

    <!-- Profile Picture Section -->
    <div class="profile-pic">
        <img src="<%= profilePic %>" alt="Profile Picture">
    </div>

    <form action="UserProfileServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="user_id" value="<%= userId %>">

        <div class="form-group">
            <label>Change Profile Photo:</label>
            <input type="file" name="profile_photo" accept="image/*">
        </div>

        <div class="form-group">
            <label>Username:</label>
            <input type="text" name="username" value="<%= rs.getString("username") %>" disabled>
        </div>

        <div class="form-group">
            <label>Email:</label>
            <input type="text" name="email" value="<%= rs.getString("email") %>">
        </div>

        <div class="form-group">
            <label>Password:</label>
            <input type="text" name="password" value="<%= rs.getString("password") %>">
        </div>

        <div class="form-group">
            <label>Phone No:</label>
            <input type="text" name="phoneno" value="<%= rs.getString("phoneno") %>">
        </div>

        <div class="form-group">
            <label>Address:</label>
            <input type="text" name="address" value="<%= rs.getString("address") %>">
        </div>

        <button type="submit">Update Profile</button>
    </form>
</div>

<%
        }
    } catch (Exception ex) {
        out.println("<h3 style='color:red;'>Error: " + ex.getMessage() + "</h3>");
        ex.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>

</body>
</html>
