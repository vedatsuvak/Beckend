<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="com.gms.model.User"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="<c:url value="/css/styles.css" />" rel="stylesheet"></link>
	    <script>
		function confirmDelete() {
		    return confirm("Are you sure you want to DELETE your account?");
		    session.setAttribute("actionSuccessful", true);
		}
		function confirmDelete() {
		    return confirm("Dont fucking delete your shitty account..!");
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
	<div>
	<h2 class="link-container">Profile</h2>
	<table class="container">
		<tr><td class="label">User Name</td><td>:</td><td class='label'><%= name.toUpperCase() %></td></tr>
		<tr><td class="label">Password</td><td>:</td><td class='label'><%= "*".repeat(password.length())  %></td></tr>
		<tr><td class="label">Email</td><td>:</td><td class='label'><%= email %></td></tr>
	</table>
	</div>
	<%if (!name.equalsIgnoreCase("admin")) { %>
      
    <form action="editUser.jsp">
        <input type="hidden" name="username" value="<%=name %>">
        <input type="submit" value="Edit User">
    </form><br>
       
    <form action="deleteUser?username=" method="get" onsubmit="return confirmDelete();">
    	<input type="hidden" name="username" value="<%= name %>">
       <p>Do you want to delete your account?</p>
       <p>Please don't abandon us!</p>
       <p>If you insist, then click the button below :</p>
       <input type="submit" value="Destroy"> my account..!
    </form>
        
   <% } else { %>
    <form action="editUser.jsp">
        <input type="hidden" name="username" value="<%=name %>">
       <input type="submit" value="Edit Email and Password">
    </form><br>
    <h3 class="link-container">Admin Cannot be Deleted</h3>
       
   <%  } %>

</body>
<%} else {
	HttpServletResponse httpResponse = (HttpServletResponse) response;
    httpResponse.sendRedirect("login.jsp"); }%>
</html>