<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ShiftHandover</title>
<style>
    .btn {
        height: 100px;
        width: 120px;
        padding: 10px 20px;
        margin: 10px;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s, color 0.3s;
    }
    .btn:hover {
        background-color: #ccc;
        color: #fff;
    }
    .top-right-container {
        position: absolute;
        top: 10px;
        right: 10px;
        text-align: right;
    }
    .top-right-container .btn {
        height: auto;
        width: auto;
        padding: 5px 10px;
        margin: 0;
        border: none;
        background-color: transparent;
        color: black;
        font-size: 16px;
    }
    .top-right-container .btn:hover {
        background-color: transparent;
        color: black;
        text-decoration: underline;
    }
    body {
        background-color: blueviolet;
        margin: 0;
        padding: 0;
    }
    .center-content {
        text-align: center;
        margin-top: 150px;
    }
</style>
</head>
<body>
<div class="top-right-container">
    <%
        String user = request.getRemoteUser();
        if (user != null) {
            out.println("<span>" + user + "</span><br><br>"); 
            out.println("<div>Welcome, " + user + "!<br><button class='btn' onclick=\"window.location.href='logout.jsp'\">Sign Out</button></div>");
        }
    %>
</div>
<center>
<div class="center-content">
    <h1>Welcome to Service Portal</h1>
    <%
        if (user != null) {
            out.println("<span>Welcome, " + user + "!</span><br><br>");
            out.println("<button class='btn' onclick=\"window.location.href='shiftHandoverForm.jsp'\">Shift Handover Form</button>");
            out.println("<button class='btn' onclick=\"window.location.href='searchDetailsForm.jsp'\">Search Details</button>");
        } else {
            out.println("<button class='btn' onclick=\"window.location.href='/.auth/login/aad'\">Sign In</button>");
        }
    %>
</div>
</center>
</body>
</html>
