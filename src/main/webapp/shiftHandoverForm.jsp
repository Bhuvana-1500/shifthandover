<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ShiftHandover</title>
</head>
<body>
<div style="height:300px; width:250px; margin:auto; background-color:skyblue; border-radius:15px; padding:50px; margin-top:100px;">
<center>
<form method="post">
<h1>Shift Handover</h1>
<table>
<tr>
<td>Date:</td>
<td> <input type="date" placeholder="YYYY-MM-DD" name="date"> <td>
</tr>
<tr>
<td>Name:</td>
<td><input type="text" placeholder="Enter Your Name" name="name"></td>
</tr>
<tr>
<td>Department:</td>
<td><input type="text" placeholder="Enter Your Team name" name="dep"></td>
</tr>
<tr>
<td>Comments:</td>
<td><input type="text" placeholder="Enter Your Comments" name="com"></td>
</tr>
</table>
<center>
    <button type="button" onclick="window.location.href='index.jsp'">Back</button>
    <input type="submit" value="submit">
</center>
</form>
</center>
</div>

<%
    String date1 = request.getParameter("date");
    String name1 = request.getParameter("name");
    String dep1 = request.getParameter("dep");
    String com1 = request.getParameter("com");

    if (date1 != null && name1 != null && dep1 != null && com1 != null) {
        String url = "jdbc:sqlserver://bhuvanaserver.database.windows.net:1433;databaseName=db-bhuvana-eus;user=bhuvana;password=Bhuvaneswari@15";
        String query = "INSERT INTO snp VALUES (?, ?, ?, ?)";
        
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connect = DriverManager.getConnection(url);
            PreparedStatement ps = connect.prepareStatement(query);
            ps.setString(1, date1);
            ps.setString(2, name1);
            ps.setString(3, dep1);
            ps.setString(4, com1);
            int rs1 = ps.executeUpdate();
            if (rs1 > 0) {
                out.println("<center><h1 style='color:green;'>Record Added..</h1></center>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
