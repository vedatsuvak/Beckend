<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gms.model.Participants"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.RequestDispatcher"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
		function confirmDelete() {
		    return confirm("Are you sure to DELETE Batch?");
		}
	</script>
    <title>All Participants</title>
</head>
<body>
<%
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
rd.include(request, response);
List<Participants> list = (List<Participants>) request.getAttribute("listparticipant");
//Only for admin
if (isLoggedIn && username.equalsIgnoreCase("admin")) {
%>
    <div style="text-align: center;">
        <h1><i>List of All Participants</i></h1>
        <form action="addBatch.jsp">
            <input type="submit" value="Add Batch">
        </form><br>
        <table style="margin: 0 auto;" border="1">
            <tr>
            	<th>Batch ID</th>
                <th>Participant ID</th>
                <th>Participant Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Edit Action</th>
                <th>Delete Action</th>
            </tr>
             <% for (Participants p : list) { %>
                <tr>
               		<td><%= p.getBid() %></td>
                    <td><%= p.getPid() %></td>
                    <td><%= p.getPname().toUpperCase() %></td>
                    <td><%= p.getAge() %></td>
                    <td><%= p.getGender().toUpperCase() %></td>
                    <td><%= p.getPhone() %></td>
                    <td><%= p.getEmail().toLowerCase() %></td>
					<td><button onclick="window.location.href='editParticipant.jsp?pid=<%= p.getPid() %>'" value="<%= request.getParameter("pid") %>">Edit Participant</button></td>                    
					<td><button onclick="if(confirmDelete()) { window.location.href='deleteParticipant?pid=<%= p.getPid() %>'; }">Unregister Participant</button></td>
                </tr>
            <% } %>
        </table>
    </div>
    <p style="font-size: 10px; color: red;">Warning: If a participant deleted, you can not set that Participant ID anymore...!</p>
	<p style="font-size: 10px; color: red;">Warning: To delete a specific batch, you need to delete all participants inside the batch...!</p>    
<%
// Other users restricted
} else {
    response.sendRedirect("login.jsp");
}
%>
</body>
</html>