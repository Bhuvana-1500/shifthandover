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
</style>
</head>
<body style="background-color: aqua;">
<center>
<div style="text-align:center; margin-top:100px;">
    <h1>Welcome to Service Portal</h1>
    <%
        String user = request.getRemoteUser();
        if (user != null) {
            out.println("<p>Welcome, " + user + "!</p>");
            out.println("<button class='btn' onclick=\"window.location.href='shiftHandoverForm.jsp'\">Shift Handover Form</button>");
            out.println("<button class='btn' onclick=\"window.location.href='searchDetailsForm.jsp'\">Search Details</button>");
            out.println("<button class='btn' onclick=\"window.location.href='logout.jsp'\">Sign Out</button>");
        } else {
            out.println("<button class='btn' onclick=\"window.location.href='/.auth/login/aad'\">Sign In</button>");
        }
    %>
</div>
</center>
</body>
</html>
