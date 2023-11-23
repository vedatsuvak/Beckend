<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// Check if the action was successful
boolean success = request.getAttribute("success") != null;
//Restrict direct access
if (success) {
	String successMessage = (String) request.getAttribute("success");
   	RequestDispatcher rd=request.getRequestDispatcher("main.jsp");
   	rd.include(request, response);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous"></head>
	<link href="/Nov9SpringCoreZumba/css/styles.css" rel="stylesheet"></link>
    <title>Insert title here</title>
</head>
<body class="link-container text-center"><br>
    <h3 class="link-container text-white"><i>DONE...!!</i></h3>
    <h2 class="text-white"><%=successMessage %></h2>
</body>
</html>
<%
} else {
   // User is not logged in, redirect to login page
   response.sendRedirect("login.jsp");
}
%>
