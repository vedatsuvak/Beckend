<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.gms.model.Participants"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
		function confirmDelete() {
		    return confirm("Are you sure to Unregister Participant?");
		}
	</script>
    <title>Zumba</title>
</head>
<body>
<%
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
rd.include(request, response);
Participants participant = new Participants();
List<Participants> list = (List<Participants>) request.getAttribute("participantslist");
int bid =(Integer) request.getAttribute("bid");
%>
<br>
	<div>
		<h2 class="text-center text-white"><i>List of Participants in Batch :<%= bid %></i></h2>
	</div>
	<section class="intro">
		<div class="gradient-custom-2 h-100">
			<div class="mask d-flex align-items-center h-100">
				<div class="container">
		        	<div class="row justify-content-center">
		          		<div class="col-10">
		            		<div class="table-responsive">
			              		<table class="table table-dark table-bordered mb-0">
			                		<thead>
	       					 			<% if (isLoggedIn && username.equalsIgnoreCase("admin")) { %>
								            <tr>
											    <th scope="col" colspan="8" class="text-center">
											        <form action="addParticipant.jsp" method="POST">
											            <input type="hidden" id="bid" name="bid" value="<%= bid %>">
											            <button type="submit">Add Participant</button>
											        </form>
											    </th>
											</tr>
								            <tr>
								                <th scope="col">Participant ID</th>
								                <th scope="col">Participant Name</th>
								                <th scope="col">Age</th>
								                <th scope="col">Gender</th>
								                <th scope="col">Phone</th>
								                <th scope="col">Email</th>
								                <th scope="col">Edit Action</th>
								                <th scope="col">Unregister</th>
								            </tr>
							            <% for (Participants p : list) { %>
							                <tr>
							                    <td><%= p.getPid() %></td>
							                    <td><%= p.getPname().toUpperCase() %></td>
							                    <td><%= p.getAge() %></td>
							                    <td><%= p.getGender().toUpperCase() %></td>
							                    <td><%= p.getPhone() %></td>
							                    <td><%= p.getEmail().toLowerCase() %></td>
												<td><button onclick="window.location.href='editParticipant.jsp?pid=<%= p.getPid() %>'" value="<%= request.getParameter("pid") %>">Edit Participant</button></td>                    
												<td><button onclick="if(confirmDelete()) { window.location.href='deleteParticipant?pid=<%= p.getPid() %>'; }">Unregister Participant</button></td>
							                </tr>
							            <% } } else if (isLoggedIn && !username.equalsIgnoreCase("admin")) { %>
							            	<tr>
								            	<th scope="col" colspan='8' class="text-center">
									            	<form action="addParticipant.jsp" method="POST">
													    <input type="hidden" id="bid" name="bid" value="<%= bid %>"><br>			    
													    <input type="submit" value="Register to this Batch">
													</form>
								            	</th>
								            </tr>  
								            <tr>
								                <th>Participant ID</th>
								                <th>Participant Name</th>
								                <th>Age</th>
								                <th>Gender</th>
								            </tr>
								            <% for (Participants p : list) { %>
											<tr>	
								                <td><%= p.getPid() %></td>
								                <td><%= p.getPname().toUpperCase() %></td>
								                <td><%= p.getAge() %></td>
								                <td><%= p.getGender().toUpperCase() %></td>
											</tr>
								            <% } } else {
												    HttpServletResponse httpResponse = (HttpServletResponse) response;
												    httpResponse.sendRedirect("login.jsp"); } %>		            
			 						</thead>
			 					</table>
		 					</div>
		 				</div>
					</div>
				</div>
			</div>
		</div>
	</section>									            
   	<p style="font-size: 10px; color: red;">Warning: If a Participant unregistered, you can not see that Participant ID anymore...!</p>
</body>
</html>