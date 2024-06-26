<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Comments</title>
</head>
<body>
<%
    String[] ids = request.getParameterValues("id");
    String[] newComments = new String[ids.length];

    for (int i = 0; i < ids.length; i++) {
        newComments[i] = request.getParameter("newComment_" + ids[i]);
    }

    String url = "jdbc:sqlserver://bhuvanaserver.database.windows.net:1433;databaseName=db-bhuvana-eus;user=bhuvana;password=Bhuvaneswari@15";
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
        //out.println("<center><h1 style='color:green;'>Comments updated successfully</h1></center>");

        // Set session attribute with updated comments
        HttpSession sessionObject = request.getSession();
        sessionObject.setAttribute("updatedComments", "Comments updated successfully");
    } catch (Exception e) {
        e.printStackTrace();
        //out.println("<center><h1 style='color:red;'>An error occurred while processing your request</h1></center>");
    }
%>
</body>
</html>
