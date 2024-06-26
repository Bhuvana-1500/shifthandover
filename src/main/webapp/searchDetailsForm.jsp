<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SearchDetails</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-weight: bold;
    }
    h1 {
        background-color: darkblue;
        color: white;
        padding: 10px;
        border-radius: 5px;
        height: 50px;
        width: 300px;
    }
    .input-box {
        width: 300px;
        padding: 10px;
        border: 2px solid navy;
        border-radius: 5px;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        border: 2px solid darkblue;
    }
    .tb1 {
        border: 0px;
    }
    th, td {
        padding: 8px;
        text-align: center;
        border: 1px solid darkblue;
    }
    th {
        background-color: darkblue;
        color: white;
    }
    form {
        text-align: left;
    }
    table input[type="date"], table input[type="text"] {
        width: calc(100% - 18px);
        padding: 6px;
        margin: 0;
        box-sizing: border-box;
    }
    .btn {
        background-color: darkblue;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s, color 0.3s;
    }
    .btn:hover {
        background-color: navy;
    }
    .container {
        height: auto;
        width: 700px;
        margin: auto;
        background-color: lightsteelblue;
        border-radius: 15px;
        padding: 50px;
    }
    .green-text {
        color: green;
    }
</style>
</head>
<body>
<div class="container">
    <center>
    <div style="width:300px;">
    <form method="post">
        <h1>Search Your Details</h1>
        <table class="tb1">
            <tr>
                <td>Date:</td>
                <td><input type="date" class="input-box" placeholder="YYYY-MM-DD" name="dates"></td>
            </tr>
        </table> <br> <br>
        <center>
            <button type="button" onclick="window.location.href='index.jsp'" class="btn">Back</button>
            <input type="submit" value="Search" class="btn">
        </center>
    </form>
    </div>
    </center>

    <%
    boolean searchPerformed = request.getParameter("dates") != null;
    boolean updatePerformed = request.getParameterValues("id") != null;

    if (updatePerformed) {
        // Code from updateComments.jsp
        String[] ids = request.getParameterValues("id");
        String[] newComments = new String[ids.length];

        for (int i = 0; i < ids.length; i++) {
            newComments[i] = request.getParameter("newComment_" + ids[i]);
        }

        String url = "jdbc:sqlserver://bhuvanasho.database.windows.net:1433;databaseName=shodb;user=bhuvana;password=Bhuvaneswari@15";
        String selectQuery = "SELECT comments FROM snp WHERE id = ?";
        String updateQuery = "UPDATE snp SET comments = ? WHERE id = ?";

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connect = DriverManager.getConnection(url);
            connect.setAutoCommit(false);

            for (int i = 0; i < ids.length; i++) {
                String id = ids[i];
                String newComment = newComments[i];

                if (newComment != null && !newComment.isEmpty()) {
                    // Retrieve existing comments
                    PreparedStatement psSelect = connect.prepareStatement(selectQuery);
                    psSelect.setString(1, id);
                    ResultSet rs = psSelect.executeQuery();

                    if (rs.next()) {
                        String existingComments = rs.getString("comments");
                        String updatedComments = existingComments + " " + newComment;

                        // Update comments in the database
                        PreparedStatement psUpdate = connect.prepareStatement(updateQuery);
                        psUpdate.setString(1, updatedComments);
                        psUpdate.setString(2, id);
                        psUpdate.executeUpdate();
                    }
                }
            }

            connect.commit();
            connect.setAutoCommit(true);
            out.println("<center><h2 style='color:green;'>Comments updated successfully</h2></center>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<center><h2 style='color:red;'>An error occurred while processing your request</h2></center>");
        }
    }

    if (searchPerformed) {
        String date1 = request.getParameter("dates");

        if (date1 != null && !date1.isEmpty()) {
            String url = "jdbc:sqlserver://bhuvanasho.database.windows.net:1433;databaseName=shodb;user=bhuvana;password=Bhuvaneswari@15";
            String query = "SELECT * FROM snp WHERE date = ?";

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection connect = DriverManager.getConnection(url);
                PreparedStatement ps = connect.prepareStatement(query);
                ps.setString(1, date1);
                ResultSet rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) { // Check if ResultSet is empty
                    out.println("<center><h2 style='color:red;'>Record not found</h2></center>");
                } else {
                    out.println("<center><h2 class='green-text'>Your details based on your date:</h2></center>");
                    out.println("<center><form method='post'><table border='1' class='tb1'>");
                    out.println("<tr><th>ID</th><th>Date</th><th>Name</th><th>Department</th><th>Comments</th><th>New Comments</th></tr>");

                    while (rs.next()) {
                        String id = rs.getString("id");
                        String dt = rs.getString("date");
                        String nm = rs.getString("name");
                        String dp = rs.getString("department");
                        String co = rs.getString("comments");
                        out.println("<tr>");
                        out.println("<td>" + id + "</td>");
                        out.println("<td><input type='hidden' name='id' value='" + id + "'>" + dt + "</td>");
                        out.println("<td>" + nm + "</td>");
                        out.println("<td>" + dp + "</td>");
                        out.println("<td>" + co + "</td>");
                        out.println("<td><input type='text' name='newComment_" + id + "'></td>");
                        out.println("</tr>");
                    }

                    out.println("</table>");
                    out.println("<center><input type='submit' value='Add Comment' class='btn'></center></form></center>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<center><h2 style='color:red;'>An error occurred while processing your request</h2></center>");
            }
        } else {
            out.println("<center><h2 style='color:red;'>Please enter a date</h2></center>");
        }
    }
    %>
</div>
</body>
</html>
