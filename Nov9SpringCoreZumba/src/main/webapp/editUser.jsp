<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<br>
	<div>
		<h2 class="text-center text-white">Edit User</h2>
	</div>
	<section class="intro">
		<div class="gradient-custom-2 h-100">
			<div class="mask d-flex align-items-center h-100">
				<div class="container">
		        	<div class="row justify-content-center">
		          		<div class="col-6">
		            		<div class="table-responsive">
			            		<form action='editUser' method='POST'>
			              			<table class="table table-dark table-bordered mb-0">
			                			<thead>
			                			<% if (isLoggedIn && !selectedUsername.equalsIgnoreCase("admin")){ %>
			                				<tr>
												<th scope="col">User Name</th>
												<th scope="col" ><%=selectedUsername.toUpperCase() %><input type='hidden' name='userName' value='<%=selectedUsername.toUpperCase() %>' pattern="^[A-Za-z0-9_-]{5,30}$" title="letters, numbers, underscores, and hyphens. Length between 5 and 30 characters." required></th>
											</tr>
											<tr>
												<th scope="col">New User Name</th>
												<th scope="col"><input type='text' name='newUsername' value='<%=selectedUsername.toUpperCase() %>' pattern="^[A-Za-z0-9_-]{5,30}$" title="letters, numbers, underscores, and hyphens. Length between 5 and 30 characters." required></th>
											</tr>
											<tr>
												<th scope="col">New Password</th>
												<th scope="col"><input type='password' name='newPassword' value='<%= user.getPassword() %>' pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></th>
											</tr>
											<tr>
												<th scope="col">Confirm New Password</th>
												<th scope="col"><input type='password' name='confirmPassword' value='<%= user.getPassword() %>' pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></th>
											</tr>
											<tr>
												<th scope="col">New Email</th>
												<th scope="col"><input type='text' name='newEmail' value='<%= user.getEmail() %>' pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Enter a valid email address." required></th>
											</tr>
											<tr>
												<th scope="col" colspan='3' class="text-center"><input type='submit' value='Save Changes'></th>
											</tr>
										<% }else if (isLoggedIn && selectedUsername.equalsIgnoreCase("admin")) { %>
			                				<tr>
												<th scope="col">User Name</th>
												<th scope="col"><%=selectedUsername.toUpperCase() %><input type='hidden' name='userName' value='<%=selectedUsername.toUpperCase() %>' ><input type='hidden' name='newUsername' value='<%=selectedUsername.toUpperCase() %>'></th>
											</tr>
											
											<tr>
												<th scope="col">New Password</th>
												<th scope="col"><input type='password' name='newPassword' value='<%= user.getPassword() %>' pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></th>
											</tr>
											<tr>
												<th scope="col">Confirm New Password</th>
												<th scope="col"><input type='password' name='confirmPassword' value='<%= user.getPassword() %>' pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></th>
											</tr>
											<tr>
												<th scope="col">New Email</th>
												<th scope="col"><input type='text' name='newEmail' value='<%= user.getEmail() %>' pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" title="Enter a valid email address." required></th>
											</tr>
											<tr>
												<th scope="col" colspan='3' class="text-center"><input type='submit' value='Save Changes'></th>
											</tr>
										<% } else {
										    // User is not logged in
										    response.sendRedirect("login.jsp");
										} %>
			 							</thead>
			 						</table>
		 						</form>
		 					</div>
		 				</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>