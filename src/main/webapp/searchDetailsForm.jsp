<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SearchDetails</title>
</head>
<body>
<div style="height:200px; width:250px; margin:auto; background-color:pink; border-radius:15px; padding:50px; margin-top:100px;">
<center>
<form method="post">
<h1>Search Your Details</h1>
<table>
<tr>
<td>Date:</td>
<td> <input type="date" placeholder="YYYY-MM-DD" name="dates"> <td>
</tr>
<tr>
<td>Name:</td>
<td><input type="text" placeholder="Enter Your Name" name="names"></td>
</tr>
</table>
<center>
    <button type="button" onclick="window.location.href='index.jsp'">Back</button>
    <input type="submit" value="search">
</center>
</form>
</center>
</div>

<%
    String date1 = request.getParameter("dates");
    String name1 = request.getParameter("names");

    if (date1 != null && name1 != null) {
        String url = "jdbc:sqlserver://bhuvanaserver.database.windows.net:1433;databaseName=db-bhuvana-eus;user=bhuvana;password=Bhuvaneswari@15";
        String query = "SELECT * FROM snp WHERE date = ? AND name = ?";

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connect = DriverManager.getConnection(url);
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setString(1, date1);
            ps.setString(2, name1);
            ResultSet rs = ps.executeQuery();

            out.println("<center><h1 style='color:pink;'>Your details based on your date and name:</h1></center>");
            out.println("<center><table border='1'>");
            out.println("<tr><th>Date</th><th>Name</th><th>Department</th><th>Comments</th></tr>");

            while (rs.next()) {
                String dt = rs.getString("date");
                String nm = rs.getString("name");
                String dp = rs.getString("department");
                String co = rs.getString("comments");
                out.println("<tr>");
                out.println("<td>" + dt + "</td>");
                out.println("<td>" + nm + "</td>");
                out.println("<td>" + dp + "</td>");
                out.println("<td>" + co + "</td>");
                out.println("</tr>");
            }

            out.println("</table></center>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
