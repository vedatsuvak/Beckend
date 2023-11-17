<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gms.model.Batch" %>
<%@ page import="com.gms.DAO.BatchDAO"%>   
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <title>Zumba</title>
</head>
<body class ="link-container">
<%
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
BatchDAO bdao = ac.getBean(BatchDAO.class);
//Include main.jsp page
RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
rd.include(request, response);
//Admin
if (isLoggedIn && username.equalsIgnoreCase("admin")) {
	// Get the product ID from the request parameter
	int batchId = 0;
	try {
		batchId = Integer.parseInt(request.getParameter("bid"));
	} catch (NumberFormatException e) {
		 // Handle the case when "bid" parameter is not a valid integer
		 out.println("Invalid batch ID");
         session.setAttribute("error", true);
         session.setAttribute("editbatch", true);
		 response.sendRedirect("error.jsp");
		 return;
	}
	Batch selectedBatch = bdao.displayBatch(batchId);
%>       
<br>
	<div>
		<h2 class="text-center text-white"><i>Edit Batch: <%= batchId %></i></h2>
	</div>
	<section class="intro">
		<div class="gradient-custom-2 h-100">
			<div class="mask d-flex align-items-center h-100">
				<div class="container">
		        	<div class="row justify-content-center">
		          		<div class="col-6">
		            		<div class="table-responsive">
			            		<form action = "editBatch" method="POST">
			              			<table class="table table-dark table-bordered mb-0">
			                			<thead>
											<tr>
												<th scope="col">Batch ID</th>
												<th scope="col">Immutable<input type="hidden" name="bid" value="<%= request.getParameter("bid") %>"></td></tr>
											<tr>
												<th scope="col">Batch Name</th>
												<th scope="col"><input type="text" name="bname" value="<%= selectedBatch.getBname() %>" pattern="^[A-Za-z0-9_-]{5,30}$" title="letters, numbers, underscores, and hyphens. Length between 5 and 30 characters." required></td></tr>
											<tr>
											    <th scope="col">Instructor</th>
											    <th scope="col"> <!-- Setting instructor table and getting data from DB is optional -->
											        <select name="instructor" required>
											            <option value="VEDAT">VEDAT</option>
											            <option value="KARTHIK">KARTHIK</option>
											            <option value="KAMAL">KAMAL</option>
											            <option value="SURAJ">SURAJ</option>
											            <option value="ANITA">ANITA</option>
											            <option value="SWATI">SWATI</option>
											        </select>
											    </th>
											</tr>
											<tr><th scope="col">Start Time</th>
												<th scope="col"><input type="time" name="startTime" value="<%= selectedBatch.getStartTime()  %>" required></th></tr>
											<tr><th scope="col">Start Date</th>
												<th scope="col"><input type="date" name="startDate" value="<%= selectedBatch.getStartDate()  %>" required></th></tr>
											<tr><th scope="col" colspan = "2" class="text-center"><input type="submit" value="Edit"></th></tr>
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
<%
} else {
    // Other users restricted
    response.sendRedirect("login.jsp");
}
%>
</body>
</html>