<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gms.DAO.ParticipantsDAO"%>
<%@ page import="com.gms.model.Participants"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
rd.include(request, response);
//Only for Admin
if (isLoggedIn && username.equalsIgnoreCase("admin")) {
	int pid = Integer.parseInt(request.getParameter("pid"));
	Participants selected = pdao.getParticipant(pid);
	if (selected != null) {
		int bid = selected.getBid();
		String pname = selected.getPname();
		int age = selected.getAge();
		String gender = selected.getGender();
		String phone = selected.getPhone();
		String email = selected.getEmail();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Update Participant</title>
	<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<br>
	<div>
		<h2 class="text-center text-white"><i>Updating Participant</i></h2>
	</div>
	<section class="intro">
		<div class="gradient-custom-2 h-100">
			<div class="mask d-flex align-items-center h-100">
				<div class="container">
		        	<div class="row justify-content-center">
		          		<div class="col-6">
		            		<div class="table-responsive">
			            		<form action="editParticipant" method="post">
			              			<table class="table table-dark table-bordered mb-0">
			                			<thead>
											<tr>
												<td class="right">Batch ID</td>
												<td><%= bid %><input type="hidden" value="<%= bid %>" name="bid"></td>
											</tr>
											<tr>
												<td class="right">Participant ID</td>
												<td><%= pid %><input type="hidden" value="<%= pid %>" name="pid"></td>
											</tr>
											<tr>
												<td class="right">Participant Name</td>
												<td><%= pname %><input type="hidden" name="pname" value="<%= pname.toUpperCase() %>" required></td>
											</tr>
											<tr>
												<td class="right">Age</td>
												<td><input type="text" name="age" value="<%= age %>" pattern="^(0?[1-9]|[1-9][0-9])$" title="Enter a valid age between 1 and 99." required></td>
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
												<td><input type="text" name="phone" value="<%= phone %>" pattern="^\+(?:\d{1,3}-)?\d{5,15}$" title="Enter a valid phone number with a country code. Examples: +1234567890 or +1-234567890." required></td>
											</tr>
											<tr>
												<td class="right">Email</td>
												<td><input type="hidden" name="email" value="<%= email.toLowerCase() %>" required><%= email.toLowerCase() %></td>
											</tr>
											<tr>
												<td colspan="2"  class="text-center"><input type="submit" value="Update"></td>
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
<%
	} else {
		session.setAttribute("editparticipant", true);
		session.setAttribute("error", true);
		response.sendRedirect("error.jsp");
	}
} else {
	// Other users restricted
	response.sendRedirect("login.jsp");
}
%>