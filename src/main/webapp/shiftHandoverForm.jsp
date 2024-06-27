<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ShiftHandover</title>
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
    }
    .input-box {
        width: 300px; /* Increased width */
        padding: 10px;
        border: 2px solid navy; /* Increased border width */
        border-radius: 5px;
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
        height: 700px;
        width: 700px;
        margin: auto;
        background-color: lightsteelblue;
        border-radius: 15px;
        padding: 50px;
    }
    table {
        margin: auto;
    }
    .message {
        font-size: 1.2em;
        color: red; /* Default color is red */
    }
    .success-message {
        font-size: 1.2em;
        color: green;
    }
    .error-message {
        font-size: 1.2em;
        color: green;
    }
</style>
<script>
    window.onload = function() {
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();

        today = yyyy + '-' + mm + '-' + dd;
        document.getElementById('currentDate').value = today;
    }
</script>
</head>
<body>
<div class="container">
<center>
<form method="post">
    <h1>Shift Handover</h1>
    <table>
        <tr>
            <td>Date:</td>
            <td><input type="date" id="currentDate" name="date" class="input-box"></td>
        </tr>
        <tr>
            <td>Name:</td>
            <td><input type="text" name="name" value="<%= session.getAttribute("username") %>" class="input-box" readonly></td>
        </tr>
        <tr>
            <td>Department:</td>
            <td><input type="text" placeholder="Enter Your Team name" name="dep" class="input-box"></td>
        </tr>
        <tr>
            <td>Comments:</td>
            <td><input type="text" placeholder="Enter Your Comments" name="com" class="input-box"></td>
        </tr>
    </table>
    <center>
        <button type="button" class="btn" onclick="window.location.href='index.jsp'">Back</button>
        <input type="submit" class="btn" value="Submit">
    </center>
</form>
<%
    String date1 = request.getParameter("date");
    String name1 = request.getParameter("name");
    String dep1 = request.getParameter("dep");
    String com1 = request.getParameter("com");

    if (date1 != null && name1 != null && dep1 != null && com1 != null && !date1.isEmpty() && !name1.isEmpty() && !dep1.isEmpty() && !com1.isEmpty()) { 
        String url = "jdbc:sqlserver://bhuvanasho.database.windows.net:1433;databaseName=shodb;user=bhuvana;password=Bhuvaneswari@15";
        String query = "INSERT INTO dbo.snp (date, name, department, comments) VALUES (?, ?, ?, ?)";
        
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
                out.println("<center><p class='success-message'>Record Added..</p></center>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<center><p class='error-message'>An error occurred while processing your request.</p></center>");
        }
    } else {
        out.println("<center><p class='error-message'>Please Insert the Data...!!!</p></center>");
    }
%>
</center>
</div>
</body>
</html>
