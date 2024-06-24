<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    session.invalidate();
    String redirectUrl = "https://login.microsoftonline.com/YOUR_TENANT_ID/oauth2/logout?post_logout_redirect_uri=https://javaterraform.azurewebsites.net/index.jsp";
    response.sendRedirect(redirectUrl);
%>
