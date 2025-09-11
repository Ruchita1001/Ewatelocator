<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>

<%
    // Retrieve form data
    String username = request.getParameter("uname");
    String email = request.getParameter("mail");
    String password = request.getParameter("pass");
    String phoneno = request.getParameter("phono");
    String address = request.getParameter("add");
    String date = request.getParameter("da");

    Connection con = null;
    PreparedStatement pst = null;

    try {
        // Database Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ewastelocator", "root", "");

        // Insert Query (Fixed)
        String query = "INSERT INTO ewaste (username, email, password, phoneno, address, date) VALUES (?, ?, ?, ?, ?, ?)";
        pst = con.prepareStatement(query);
        pst.setString(1, username);
        pst.setString(2, email);
        pst.setString(3, password);
        pst.setString(4, phoneno);
        pst.setString(5, address);
        pst.setString(6, date);

        int rowsInserted = pst.executeUpdate();

        if (rowsInserted > 0) {
            // If insert is successful, redirect to login page
            response.sendRedirect("login.html");
        } else {
            out.println("<h3 style='color:red;'>Registration failed. Please try again.</h3>");
        }

    } catch (Exception ex) {
        out.println("<h3 style='color:red;'>Error: " + ex.getMessage() + "</h3>");
        ex.printStackTrace();
    } finally {
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
