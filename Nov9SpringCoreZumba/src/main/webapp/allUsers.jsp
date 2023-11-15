<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.gms.model.User"%>
<%@ page import="java.util.*"%>

<%
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
//Admin Access Only
if (isLoggedIn && username.equalsIgnoreCase("admin")) {
    
    List<User> list = (List<User>) request.getAttribute("userlist");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Users</title>
</head>
<body>
	<div style="text-align: center;">
		<h1><i>List of Users</i></h1>
		<form action="register.jsp">
			<input type="submit" value="Add a new User">
		</form><br>
		<table style="margin: 0 auto;" border="1">
			<tr>
				<th>User Name</th>
				<th>User Password</th>
				<th>User Email</th>
				<th>Edit Action</th>
				<th>Delete Action</th>
			</tr>
			<% for(User u : list) { %>
			<tr>
		    	<td><%= u.getUsername().toUpperCase() %></td>
		        <td><%= u.getPassword() %></td>
		        <td><%= u.getEmail().toLowerCase() %></td>
			<%if (u.getUsername().equalsIgnoreCase("admin")){ %>
				<td><form action="./editUser.jsp?username=" method="get">
					<input type="hidden" name="username" value="<%= u.getUsername() %>">
				    <button type="submit">Edit Password and Email</button></form></td>
				<td>Admin Cannot be Deleted</td>
			<% } %>
			<%if (!u.getUsername().equalsIgnoreCase("admin")){ %>
				<td><form action="./editUser.jsp?username=" method="get">
					<input type="hidden" name="username" value="<%= u.getUsername() %>">
				    <button type="submit">Edit User</button></form></td>
				<td><form action="deleteUser?username=" method="get">
					<input type="hidden" name="username" value="<%= u.getUsername() %>">
					<button type="submit">Delete User</button></form></td>
			<% } %>
			</tr>
			<% } 	       
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
			rd.include(request, response);%>
		</table>
	</div>
</body>
</html>
<%
} else {
    // Other Users restricted
    response.sendRedirect("login.jsp");
}
%>