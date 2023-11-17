<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gms.DAO.UsersDAO"%>
<%@ page import="com.gms.model.User"%>
<%@ page import="java.util.List"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Participant</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<%
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
String bid = request.getParameter("bid");
RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
rd.include(request, response);
ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
UsersDAO udao = ac.getBean(UsersDAO.class);
List <User> userlist = udao.displayUsers();
%>
<body>

<br>
	<div>
		<h2 class="text-center text-white"><i>Adding Participant</i></h2>
	</div>
	<section class="intro">
		<div class="gradient-custom-2 h-100">
			<div class="mask d-flex align-items-center h-100">
				<div class="container">
		        	<div class="row justify-content-center">
		          		<div class="col-10">
		            		<div class="table-responsive">
		            			<form action="addParticipant" method="post">
				              		<table class="table table-dark table-bordered mb-0">
				                		<thead>
								         	<tr>
								                <td class="right">Batch ID</td>
								                <td><%= bid %><input type="hidden" value="<%= bid %>" name="bid"></td>
								            </tr>
								            <tr>
								                <td class="right">Participant ID</td>
								                <td>Auto Increment<input type="hidden" name="pid"></td>
								            </tr>               
											<% if (isLoggedIn && username.equalsIgnoreCase("admin")) { %>
											<tr>
								                <td class="right">Participant Name</td>
								                <td> <select name="name" size="3" required>
								                <% for(User user : userlist) { %>
								                     <option value="<%= user.getUsername() %>"><%= user.getUsername().toUpperCase() %></option>
								                <% } %>
								                </select></td>
								            </tr>
											<% } else if(isLoggedIn && !username.equalsIgnoreCase("admin")) { %>
								            <tr>            
								            	<td class="right">Participant Name</td>
											    <td><%= username.toUpperCase() %><input type="hidden" name="name" value="<%= username %>" required></td>
											</tr>
											<% } else {
												// User is not logged in
												response.sendRedirect("login.jsp");
											}%>     
								            <tr>
								                <td class="right">Age</td>
								                <td><input type="text" name="age" pattern="^(0?[1-9]|[1-9][0-9])$" title="Enter a valid age between 1 and 99." required></td>
								            </tr>
											<tr>
											    <td class="right">Gender</td>
											    <td>
											        <select name="gender" required>
											            <option value="male">Male</option>
											            <option value="female">Female</option>
											            <option value="other">Other</option>
											        </select>
											    </td>
											</tr>
								            <tr>
								                <td class="right">Phone</td>
								                <td><input type="text" name="phone" pattern="^\+(?:\d{1,3}-)?\d{5,15}$" title="Enter a valid phone number with a country code. Examples: +1234567890 or +1-234567890." required></td>
								            </tr>
								            <tr>
								                <td class="right">Email</td>
								                <td>Auto selected</td>
								            </tr>
								            <tr>
								                <td colspan="2" class="text-center"><input type="submit" value="Add Participant"></td>
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
	</section>								            
</body>
</html>