<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
// Check if the user is logged in
boolean isLoggedIn = session.getAttribute("username") != null;
if (!isLoggedIn) {
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous"></head>
	<link href="/Nov9SpringCoreZumba/css/styles.css" rel="stylesheet"></link>
	<title>Login Page</title>
</head>
<body style="background-image: url('views/loginspace.jpg'); background-size: cover;">
<br>
	<div class="text-center">
		<h2 style="color: aqua;"><i>Login form </i></h2>
	</div>
	<section class="intro">
		<div class="gradient-custom-2 h-100">
			<div class="mask d-flex align-items-center h-100">
				<div class="container">
		        	<div class="row justify-content-center">
		          		<div class="col-5">
		            		<div class="table-responsive">
		            			<form action="login" method="post">
				              		<table class="table table-dark table-bordered mb-0">
				                		<thead>
										  <tr class='label'>
										    <td style="color: yellow;">User Name</td>
										    <td><input type="text" name="user" pattern="^[A-Za-z0-9_-]{5,30}$" title="letters, numbers, underscores, and hyphens. Length between 5 and 30 characters." required></td>
										  </tr>
										  <tr class='label'>
										    <td style="color: yellow;">Password</td>
										    <td><input type="password" name="pwd" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*.?&])[A-Za-z\d@$!%*.?&]{8,}$" title="At least 8 characters long, Must contain at least one uppercase letter, one lowercase letter, one digit,one special character (@$!%*.?&)" required></td>
										  </tr>
										  <tr>
										    <td colspan="2" class="text-center"><input type="submit" value="Login"></td>
										  </tr>
										</thead>
			 						</table>
		 						</form>
		 					</div>
		 				</div>
					</div>
				</div>
			</div>
		</div>
	</section><br>										  
	<div style="text-align: center;">
		<form action="register.jsp" method="post">
			<p style="color: red">Still not registered?
			<input type="submit" value="Register Here!"></p>	
		</form>
	</div>
</body>
</html>
<%
} else {
	response.sendRedirect("profile");
}
%>