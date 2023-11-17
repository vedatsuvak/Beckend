<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
	<link href="/Nov9SpringCoreZumba/css/styles.css" rel="stylesheet"></link>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
	<title>Zumba Company Inc®</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<script>
		function confirmLogout() {
		    return confirm("Are you sure you want to Log Out?");
		}
	</script>	
</head>	
<body style="background-image: url('views/main.jpg'); background-size: cover;">
<%
response.setContentType("text/html");
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
%>
<div class="pos-f-t">
	<div class="collapse" id="navbarToggleExternalContent">
		<div class="bg-dark p-4">
	      	<h5 class="text-white h4">Welcome to My Application</h5>
	      	<h6 class="text-white h4">This Application Prepared For Course End Project</h6>
	      	<span class="text-muted">Zumba Company Inc®</span>
		</div>
	</div>
	<nav class="navbar navbar-dark bg-dark">
		<div class="bg-dark p-0">
		    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		   	</button>
		</div>
		<div class="bg-dark p-0">
		   	<h6 class="text-white">Zumba Company Inc®</h6>
		</div>
	</nav>
</div>
<% if (isLoggedIn && username.equalsIgnoreCase("admin")) { %>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd;">
	<a class="navbar-brand" href="profile">User Profile</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
		      	<button class="nav-link bg-light" onclick="window.location.href='batches';">Batches <span class="sr-only">(current)</span></button>
		   	</li>
		    <li class="nav-item active">
		      	<button class="nav-link bg-light" onclick="window.location.href='registeredBtc';">Registered Batches</button>   
		   	</li>
		   	<li class="nav-item active dropdown">
		        <a class="nav-link dropdown-toggle bg-light" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">LISTS</a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		        	<button class="dropdown-item" onclick="window.location.href='listParticipant';">List All Participants</button>
		        	<div class="dropdown-divider"></div>
		        	<button class="dropdown-item" onclick="window.location.href='allUsers';">List All Users</button>
				</div>
		    </li>
		    <li class="nav-item active">
		      	<button class="nav-link bg-light" onclick="if(confirmLogout()) { window.location.href='logout';}">Logout</button>
		    </li>
		</ul>
			<form class="form-inline my-2 my-lg-0">
		      	<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      	<button class="btn btn-outline-success my-2 my-sm-0 bg-info text-white" type="submit">Search</button>
		    </form>
	</div>
</nav><br>
<div class="text-right text-white">
	<p>Welcome <%= username.toUpperCase() %> !</p>
	<p> You are logged in.</p>
</div>                  
<div class="vh-100 d-flex align-items-top position-fixed top-0" style="right: 0;" role="navigation">
    <div class="p-2">
        <div id="mainNav">
            <ul class="list-unstyled rounded ms-2">
                <li><a class="vlink rounded border-0" href="profile"><i class="fa fa-user"></i> <span>Profile</span></a></li>
                <li><a class="vlink rounded" href="batches"><i class="fa fa-home"></i> <span>Batches</span></a></li>
                <li><a class="vlink rounded" href="addBatch.jsp"><i class="fa fa-calendar-plus"></i> <span>Add Batch</span></a></li>
                <li><a class="vlink rounded" href="registeredBtc"><i class="fa fa-cart-plus"></i><span>My Batches</span></a></li>               
                <li><a class="vlink rounded" href="listParticipant"><i class="fa fa-users"></i> <span>Participants</span></a></li>
                <li><a class="vlink rounded" href="allUsers"><i class='fas fa-headset'></i> <span>All Users</span></a></li>
                <li><a class="vlink rounded" href="register.jsp"><i class="fa fa-user-plus"></i> <span>Add User</span></a></li>
               <li><a class="vlink rounded text-white" onclick="if(confirmLogout()) { window.location.href='logout';}"><i class="fa fa-sign-out"></i><span>Sign Out</span></a></li>
            </ul>
        </div>
    </div> 
</div>
<% 
}else if (isLoggedIn && !username.equalsIgnoreCase("admin")) {
%>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd;">
	<a class="navbar-brand" href="profile">User Profile</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
		    	<button class="nav-link bg-light" onclick="window.location.href='batches';">Batches <span class="sr-only">(current)</span></button>
		    </li>
		    <li class="nav-item active">
		      	<button class="nav-link bg-light" onclick="window.location.href='registeredBtc';">Registered Batches</button>   
		    </li>
		    <li class="nav-item active">
		      	<button class="nav-link bg-light" onclick="if(confirmLogout()) { window.location.href='logout';}">Logout</button>
		    </li>
		  	</ul>
		   	<form class="form-inline my-2 my-lg-0">
		      	<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      	<button class="btn btn-outline-success my-2 my-sm-0 bg-info text-white" type="submit">Search</button>
		    </form>
	</div>
</nav>
<div class="vh-100 d-flex align-items-top position-fixed top-0" style="right: 0;" role="navigation">
    <div class="p-2">
        <div id="mainNav">
            <ul class="list-unstyled rounded ms-2">
               <li><a class="vlink rounded border-0" href="profile"><i class="fa fa-user"></i> <span>Profile</span></a></li>
               <li><a class="vlink rounded" href="batches"><i class="fa fa-home"></i> <span>Batches</span></a></li>
               <li><a class="vlink rounded" href="registeredBtc"><i class="fa fa-cart-plus"></i><span>My Batches</span></a></li>               
               <li><a class="vlink rounded text-white" onclick="if(confirmLogout()) { window.location.href='logout';}"><i class="fa fa-sign-out"></i><span>Sign Out</span></a></li>
            </ul>
        </div>
    </div> 
</div>
<%
//not user or not logged in
} else {
%>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd;">		
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
  				<button class="link-button" onclick="window.location.href='login.jsp';">Login</button>
			</li>
			<li class="nav-item active">
				<button class="link-button" onclick="window.location.href='register.jsp';">Register</button>
			</li>
		</ul>
			<form class="form-inline my-2 my-lg-0">
		      	<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      	<button class="btn btn-outline-success my-2 my-sm-0 bg-info text-white" type="submit">Search</button>
		    </form>
	</div>
</nav>
<% } %>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.6/dist/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</body>
</html>