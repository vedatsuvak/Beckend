<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.gms.model.User"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous"></head>
	<link href="/Nov9SpringCoreZumba/css/styles.css" rel="stylesheet"></link>
	    <script>
		function confirmDelete() {
		    return confirm("Are you sure you want to DELETE your account?");
		    session.setAttribute("actionSuccessful", true);
		}
	</script>
</head>
<%		String username = (String) session.getAttribute("username");
		boolean isLoggedIn = session.getAttribute("username") != null;
		User user = (User) request.getAttribute("user");
		RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
		rd.include(request, response);
		if (isLoggedIn) { 
			String name = user.getUsername();
			String password = user.getPassword();
			String email = user.getEmail();
		%>
		
<body class="link-container">
<br>
	<div>
		<h2 class="text-center text-white">Profile</h2>
	</div>
	<section class="intro">
		<div class="gradient-custom-2 h-100">
			<div class="mask d-flex align-items-center h-100">
				<div class="container">
		        	<div class="row justify-content-center">
		          		<div class="col-6">
		            		<div class="table-responsive">
		              			<table class="table table-dark table-bordered mb-0">
		                			<thead>             			
										<tr>
											<th scope="col">User Name</th>
											<th scope="col"><%= name.toUpperCase() %></th>
										</tr>
										<tr>
											<th scope="col">Password</th>
											<th scope="col"><%= "*".repeat(password.length())  %></th>
										</tr>
										<tr>
											<th scope="col">Email</th>
											<th scope="col"><%= email %></th>
										</tr>
										<%if (!name.equalsIgnoreCase("admin")) { %>
										<tr>
											<th colspan="2" class="text-center">
												<form action="editUser.jsp">
											        <input type="hidden" name="username" value="<%=name %>">
											        <input type="submit" value="Edit User">
											    </form>
											</th>
										</tr>
										
										<tr>  
											<th colspan="2" class="text-center">
											    <form action="deleteUser?username=" method="get" onsubmit="return confirmDelete();">
											    	<input type="hidden" name="username" value="<%= name %>">
											       <p>Do you want to delete your account?</p>
											       <p>Please don't abandon us!</p>
											       <p>If you insist, then click the button below :</p>
											       <input type="submit" value="Destroy"> my account..!
											    </form>
											</th>
										</tr>
  								 		<% } else { %>
										<tr >
											<th colspan="2" class="text-center">
												<form action="editUser.jsp">
											        <input type="hidden" name="username" value="<%=name %>">
											       <input type="submit" value="Edit Email and Password">
											    </form>
											</th>
										</tr>
										<tr>
											<th colspan="2" class="text-center">
											   Admin Cannot be Deleted
											</th>
										</tr>
										<%  } %>
		 							</thead>
		 						</table>
		 					</div>
		 				</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
<%} else {
	HttpServletResponse httpResponse = (HttpServletResponse) response;
    httpResponse.sendRedirect("login.jsp"); }%>
</html>