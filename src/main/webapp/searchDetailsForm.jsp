<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SearchDetails</title>
<style>
    table {
        border-collapse: collapse;
        width: 100%;
        border: none;
    }
    th, td {
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
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
</style>
</head>
<body>
<div style="height:auto; width:700px; margin:auto; background-color:pink; border-radius:15px; padding:50px;">
    <center>
    <div style="width:300px;">
<form method="post">
<h1>Search Your Details</h1>
<table>
<tr>
<td>Date:</td>
<td><input type="date" placeholder="YYYY-MM-DD" name="dates"></td>
</tr>
</table>
<center>
    <button type="button" onclick="window.location.href='index.jsp'">Back</button>
    <input type="submit" value="search">
</center>
</form>
</div>
</center>

<%
    boolean searchPerformed = request.getParameter("dates") != null;

    if (searchPerformed) {
        String date1 = request.getParameter("dates");

        if (date1 != null && !date1.isEmpty()) {
            String url = "jdbc:sqlserver://bhuvanaserver.database.windows.net:1433;databaseName=db-bhuvana-eus;user=bhuvana;password=Bhuvaneswari@15";
            String query = "SELECT * FROM snp WHERE date = ?";

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection connect = DriverManager.getConnection(url);
                PreparedStatement ps = connect.prepareStatement(query);
                ps.setString(1, date1);
                ResultSet rs = ps.executeQuery();

                if (!rs.isBeforeFirst()) { // Check if ResultSet is empty
                    out.println("<center><h1 style='color:red;'>Record not found</h1></center>");
                } else {
                    out.println("<center><h1 style='color:pink;'>Your details based on your date:</h1></center>");
                    out.println("<center><form method='post' action='updateComments.jsp'><table border='1'>");
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
                        out.println("<td><input type='text' name='newComment_" + id + "'></td>"); // Use unique name for each new comment input
                        out.println("</tr>");
                    }

                    out.println("</table>");
                    out.println("<input type='submit' value='Add Comment'></form></center>");

                    // Display updated comments if available in session
                    HttpSession currentSession = request.getSession(false);
                    if (currentSession != null) {
                        String updatedComments = (String) currentSession.getAttribute("updatedComments");
                        if (updatedComments != null && !updatedComments.isEmpty()) {
                            out.println("<center><p>" + updatedComments + "</p></center>");
                            currentSession.removeAttribute("updatedComments"); // Clear session attribute
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<center><h1 style='color:red;'>An error occurred while processing your request</h1></center>");
            }
        } else {
            out.println("<center><h1 style='color:red;'>Please enter a date</h1></center>");
        }
    }
%>
</div>
</body>
</html>
