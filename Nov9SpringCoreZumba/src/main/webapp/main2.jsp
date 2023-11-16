<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Zumba</title>
	<link href="<c:url value="/css/styles.css" />" rel="stylesheet"></link>
</head>
<body style="background-image: url('views/main.jpg'); background-size: cover;">
	<h1 class ="link-container" style="color: aqua;"><i>Welcome to My Application</i></h1>
	<h3 class ="link-container" style="color: yellow;"><i>Zumba Company Inc®</i></h3>
<%
response.setContentType("text/html");
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
//admin
if (isLoggedIn && username.equalsIgnoreCase("admin")) {
%>
    <div class="welcome">
        <p>Welcome <%= username.toUpperCase() %>! You are logged in.</p>
    </div>
    <div class="link-container">
        <button class="link-button" onclick="window.location.href='profile';">Profile</button>
		<button class="link-button" onclick="window.location.href='batches';">Batches</button>
		<button class="link-button" onclick="window.location.href='registeredBtc';">Registered Batches</button>
		<button class="link-button" onclick="window.location.href='listParticipant';">All Participants</button>
		<button class="link-button" onclick="window.location.href='allUsers';">Show All Users</button>
		<button class="link-button" onclick="window.location.href='logout';">Logout</button>
    </div>
<%
//user
}else if (isLoggedIn && !username.equalsIgnoreCase("admin")) {
%>
   <div class="welcome">
       <p>Welcome <%= username.toUpperCase() %>! You are logged in.</p>
   </div>
   <div class="link-container">
        <button class="link-button" onclick="window.location.href='profile';">Profile</button>
		<button class="link-button" onclick="window.location.href='batches';">Batches</button>
		<button class="link-button" onclick="window.location.href='registeredBtc';">Registered Batches</button>
		<button class="link-button" onclick="window.location.href='logout';">Logout</button>
   </div>
<%
//not user or not logged in
} else {
%>
   <div class="link-container">
   		<button class="link-button" onclick="window.location.href='login.jsp';">Login</button>
		<button class="link-button" onclick="window.location.href='register.jsp';">Register</button>
   </div>
<% } %>
</body>
</html>