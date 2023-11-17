<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gms.model.Batch"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
		function confirmDelete() {
		    return confirm("Are you sure to unregister Batch?");
		}
	</script>
    <title>Batches</title>
</head>
<body>
<%
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
List<Batch> blist = (List<Batch>) request.getAttribute("batchlist");
if (isLoggedIn) {
%>
  <br>
	<div>
		<h2 class="text-center text-white"><i>List of Registered Batches</i></h2>
	</div>
	<section class="intro">
		<div class="gradient-custom-2 h-100">
			<div class="mask d-flex align-items-center h-100">
				<div class="container">
		        	<div class="row justify-content-center">
		          		<div class="col-15">
		            		<div class="table-responsive">
		              			<table class="table table-dark table-bordered mb-0">
									<thead>
							            <tr>
							                <th>Batch ID</th>
							                <th>Batch Name</th>
							                <th>Instructor</th>
							                <th>Start Time</th>
							                <th>Start Date</th>
							                <th>Action</th>
							            </tr>
							            <% for (Batch b : blist) { %>
							                <tr>
							                    <td><%= b.getBid() %></td>
							                    <td><%= b.getBname().toUpperCase() %></td>
							                    <td><%= b.getInstructor().toUpperCase() %></td>
							                    <td><%= b.getStartTime() %></td>
							                    <td><%= b.getStartDate() %></td>
							                    <td><button onclick="if(confirmDelete()) { window.location.href='unregisterParticipant?bid=<%= b.getBid() %>&username=<%= username %>'; }">Unregister Batch</button></td>
							                </tr>
							            <% } 
							            RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
										rd.include(request, response);%>
									</thead>
			 					</table>
		 					</div>
		 				</div>
					</div>
				</div>
			</div>
		</div>
	</section>											
<%
//If not logged in
} else {
	// User is not logged in
	response.sendRedirect("login.jsp");
}
%>
</body>
</html>