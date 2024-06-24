<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    // Invalidate the session
    session.invalidate();

    // Redirect to Azure AD logout URL
    String tenantId = "30bf9f37-d550-4878-9494-1041656caf27";  // Replace with your actual tenant ID
    String postLogoutRedirectUri = "https://javaterraform.azurewebsites.net/index.jsp";
    String logoutUrl = "https://login.microsoftonline.com/" + tenantId + "/oauth2/v2.0/logout?post_logout_redirect_uri=" + postLogoutRedirectUri;

    // Redirect the response to the logout URL
    response.sendRedirect(logoutUrl);
%>
