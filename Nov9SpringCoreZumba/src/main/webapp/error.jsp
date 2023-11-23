<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous"></head>
	<link href="/Nov9SpringCoreZumba/css/styles.css" rel="stylesheet"></link>
<title>error</title>
</head>
<%
boolean error = request.getAttribute("error") != null;
//Restrict direct access to page
if (error) {
	String errorMessage = (String) request.getAttribute("error");
	RequestDispatcher rd=request.getRequestDispatcher("main.jsp");
   	rd.include(request, response);	 
%>
<body class="link-container text-center text-white">
	<h2 class="text-white">Oppps...!</h2>
	<h3 class="text-white"><%= errorMessage %></h3>
</body>
<%
} else {
    response.sendRedirect("login.jsp");
}
%>
</html>