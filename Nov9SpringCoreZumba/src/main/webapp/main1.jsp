<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous"></head>
	<link href="/Nov9SpringCoreZumba/css/styles.css" rel="stylesheet"></link>
	<title>Zumba Company Inc®</title>
</head>	
<body style="background-image: url('views/main.jpg'); background-size: cover;">
<%
response.setContentType("text/html");
boolean isLoggedIn = session.getAttribute("username") != null;
String username = (String) session.getAttribute("username");
//admin
if (isLoggedIn && username.equalsIgnoreCase("admin")) {
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
		        		<button class="dropdown-item" onclick="window.location.href='allUsers';">List All Users</button>
		        
		          	<div class="dropdown-divider"></div>
		          		<a class="dropdown-item" href="#">Something else here</a>
		        	</div>
		      	</li>
		      	<li class="nav-item active">
		      		<button class="nav-link bg-light" onclick="window.location.href='logout';">Logout</button>
		      	</li>
		   </ul>
		   		<form class="form-inline my-2 my-lg-0">
		      		<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      		<button class="btn btn-outline-success my-2 my-sm-0 bg-info text-white" type="submit">Search</button>
		    	</form>
		</div>
	</nav>
	
	
	<div class="vh-100 d-flex align-items-center position-fixed start-0 top-0" role="navigation">
        <div class="p-2">
          <div id="mainNav">
            <ul class="list-unstyled rounded ms-2">
              <li><a class="vlink rounded border-0" href="#"><i class="fas fa-home"></i> <span>Home</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-th"></i> <span>Services</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-headset"></i> <span>Call Us</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="far fa-calendar-alt"></i> <span>Schedule</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-user-circle"></i> <span>About Us</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-newspaper"></i> <span>News</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-photo-video"></i> <span>Gallery</span></a></li>
            </ul>
          </div>
        </div>
      </div>	
<% 
}else if (isLoggedIn && !username.equalsIgnoreCase("admin")) {
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
		      		<button class="nav-link bg-light" onclick="window.location.href='logout';">Logout</button>
		      	</li>
		   </ul>
		   		<form class="form-inline my-2 my-lg-0">
		      		<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      		<button class="btn btn-outline-success my-2 my-sm-0 bg-info text-white" type="submit">Search</button>
		    	</form>
		</div>
	</nav>
	
	
	<div class="vh-100 d-flex align-items-center position-fixed start-0 top-0" role="navigation">
        <div class="p-2">
          <div id="mainNav">
            <ul class="list-unstyled rounded ms-2">
              <li><a class="vlink rounded border-0" href="#"><i class="fas fa-home"></i> <span>Home</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-th"></i> <span>Services</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-headset"></i> <span>Call Us</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="far fa-calendar-alt"></i> <span>Schedule</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-user-circle"></i> <span>About Us</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-newspaper"></i> <span>News</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-photo-video"></i> <span>Gallery</span></a></li>
            </ul>
          </div>
        </div>
      </div>



<%
//not user or not logged in
} else {
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
	
	
	<div class="vh-100 d-flex align-items-center position-fixed start-0 top-0" role="navigation">
        <div class="p-2">
          <div id="mainNav">
            <ul class="list-unstyled rounded ms-2">
              <li><a class="vlink rounded border-0" href="#"><i class="fas fa-home"></i> <span>Home</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-th"></i> <span>Services</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-headset"></i> <span>Call Us</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="far fa-calendar-alt"></i> <span>Schedule</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-user-circle"></i> <span>About Us</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-newspaper"></i> <span>News</span></a></li>
              <li><a class="vlink rounded" href="#"><i class="fas fa-photo-video"></i> <span>Gallery</span></a></li>
            </ul>
          </div>
        </div>
      </div>

<% } %>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.6/dist/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</body>
</html>