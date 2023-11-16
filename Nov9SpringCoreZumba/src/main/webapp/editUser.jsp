<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.gms.model.User"%> 
<%@ page import="com.gms.DAO.UsersDAO"%>   
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>

<!DOCTYPE html>
<html>
<head>
<%
String username = (String) session.getAttribute("username");
boolean isLoggedIn = session.getAttribute("username") != null;
String selectedUsername = request.getParameter("username");
RequestDispatcher rd=request.getRequestDispatcher("main.jsp");
rd.include(request, response);
ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
UsersDAO udao = ac.getBean(UsersDAO.class);
User user = udao.displayUser(selectedUsername);
%>
	<meta charset="UTF-8">
	<title>Edit User</title>
	<link href="<c:url value="/css/styles.css" />" rel="stylesheet"></link>
</head>
<body>
<% if (isLoggedIn && !selectedUsername.equalsIgnoreCase("admin")){ %>
	<div class="link-container">
		<h1 class="link-container">Edit User</h1>
		<form action='editUser' method='POST'>
			<input type="hidden" name="userName" value="<%=selectedUsername.toUpperCase() %>">
			<table class='container'>
				<tr class = 'label'><td>New User Name</td><td>:</td><td><input type='text' name='newUsername' value='<%=selectedUsername.toUpperCase() %>' pattern="^[A-Za-z0-9_-]{5,30}$" title="letters, numbers, underscores, and hyphens. Length between 5 and 30 characters." required></td></tr>
				<tr class = 'label'><td>New Password</td><td>:</td><td><input type='password' name='newPassword' value='<%= user.getPassword() %>' pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></td></tr>
				<tr class = 'label'><td>Confirm New Password</td><td>:</td><td><input type='password' name='confirmPassword' value='<%= user.getPassword() %>' pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></td></tr>
				<tr class = 'label'><td>New Email</td><td>:</td><td><input type='text' name='newEmail' value='<%= user.getEmail() %>' pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Enter a valid email address." required></td></tr>
				<tr class='link-container'><td colspan='3'><input type='submit' value='Save Changes'></td></tr>
			</table>
		</form>
	</div>
<% }else if (isLoggedIn && selectedUsername.equalsIgnoreCase("admin")) { %>
	<div class="link-container">
		<h1 class="link-container">Edit User</h1>
		<form action='editUser' method='POST'>
			<input type="hidden" name="userName" value="<%=selectedUsername.toUpperCase() %>">
			<table class='container'>
				<tr class = 'label'><td>User Name</td><td>:</td><td>Admin<input type='hidden' name='newUsername' value="<%=selectedUsername.toUpperCase()%>" pattern="^[A-Za-z0-9_-]{5,30}$" title="letters, numbers, underscores, and hyphens. Length between 5 and 30 characters."></td></tr>
				<tr class = 'label'><td>New Password</td><td>:</td><td><input type='password' name='newPassword' value='<%= user.getPassword() %>' pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></td></tr>
				<tr class = 'label'><td>Confirm New Password</td><td>:</td><td><input type='password' name='confirmPassword' value='<%= user.getPassword() %>' pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></td></tr>
				<tr class = 'label'><td>New Email</td><td>:</td><td><input type='text' name='newEmail' value='<%= user.getEmail() %>' pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Enter a valid email address." required></td></tr>
				<tr class='link-container'><td colspan='3'><input type='submit' value='Save Changes'></td></tr>
			</table>
		</form>
	</div>
<% } else {
    // User is not logged in
    response.sendRedirect("login.jsp");
} %>
</body>
</html>