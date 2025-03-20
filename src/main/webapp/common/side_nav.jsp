<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Testing Dashboard</title>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bootstrap Dashboard Sidebar</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://kit.fontawesome.com/e084da24f6.js" crossorigin="anonymous"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f8f9fa;
      background-image: url(<%=request.getContextPath() %>/static/image/back-img.jpg);
      background-size: cover;
      background-repeat: no-repeat;
      height: 100vh;
      margin: 0;
    }

	.main-content{
	width:auto;
	height:auto;
	padding-left:20%;
	
	}
    .sidebar {
      width: 18%;
      background-color: #f0f0f0;
      color: #000;
      height: 100vh;
      position: fixed;
      top:0;
      left:0;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 30px 0;
    }

    .logo-section {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 10px; /* Add a small margin below the logo */
    }

    .logo-section img {
      width: 80px;
      height: 80px;
    }

    .admin-dashboard {
      text-align: center;
      margin: 10px;
       /* Adjust space below the dashboard text */
    }

    .admin-dashboard h3 {
      font-size: 16px;
      color: #000;
      margin: 0;
    }

    .nav-item{
        margin:10px;
    }
    .nav-links {
      list-style: none;
      padding: 0;
      margin: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      flex-grow: 1; /* Ensures the nav links stay in the center */
      //justify-content: center; 
      gap:10px;/* Vertically center nav links */
    }

    .nav-links a {
      text-decoration: none;
      color: #000;
      display: flex;
      align-items: center;
      padding: 10px 20px;
      border-radius: 8px;
      transition: all 0.3s ease;
    }

    .nav-links a.active,
    .nav-links a:hover {
      background-color: #1e88e5;
      color: #fff;
    }

    .dropdown-menu a {
      font-size: 14px;
    }
    
    
    
    
     .profile-image-container {
    position: relative;
    width: 70px;
    height: 70px;
  }
  .profile-image {
    border-radius: 50%; /* Optional: make the profile image circular */
    cursor: pointer;
  }
  .edit-icon {
    background: #ffffff;
    border-radius: 50%;
    padding: 5px;
    font-size: 12px;
    color: #000;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
  }
  .edit-icon:hover {
    color: #007bff;
  }
  
  
    
    
    
  </style>
</head>

<body>
  <div class="sidebar">
    <!-- Logo Section -->
    <div class="logo-section">
      <img src="<%= request.getContextPath() %>/static/image/logo.png" alt="EDS Logo" class="img-fluid">
    </div>
    
 
    <%
    String currentUrl = request.getRequestURI();
	log(currentUrl);
    String user = (String)session.getAttribute("user"); 
    String empId = (String) session.getAttribute("empId");
    String empName = (String)session.getAttribute("empName");
    %>
	 <!-- Profile Section 
    <div class="profile-section text-center mb-3">
      <div class="profile-image-container position-relative">
        <img 
          src="<%= request.getContextPath() %>/static/profile-img/<%= 
            session.getAttribute("profileImage") != null ? 
            session.getAttribute("profileImage") : 
            "default-img.png" %>" 
          alt="Profile Image" width="70px" height="70px">
        
        <form action="../uploadProfileImage.jsp" method="post" enctype="multipart/form-data" style="display: none;">
          <input type="file" id="uploadProfileImage" name="profileImage" accept="image/*" onchange="this.form.submit();" />
        </form>
      </div>
    </div> -->
    
  
    <!-- new pofile  -->
    
    <div class="profile-section text-center mb-3">
	  <div class="profile-image-container position-relative" style="display: inline-block;">
	    <!-- Profile Image -->
	    
	    <%if(user.equals("finance")|| user.equals("admin")){%>
	    		<img 
	    	    
	  	      src="<%= request.getContextPath() %>/static/profile-img/<%= empId %>.png?ver=<%= System.currentTimeMillis() %>"  
	    		  onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/static/profile-img/default-img.png';" 
	  	      alt="Profile Image" width="70px" height="70px" class="profile-image" 
	  	      >
	  	
	    	<%} else{ 
	    	%>
	    <img 
	    
	      src="<%= request.getContextPath() %>/static/profile-img/<%= empId %>.png?ver=<%= System.currentTimeMillis() %>"  
  		  onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/static/profile-img/default-img.png';" 
	      alt="Profile Image" width="70px" height="70px" class="profile-image" 
	      onclick="document.getElementById('uploadProfileImage').click();">
	
	    <!-- Pencil Icon -->
	    <span 
	      class="edit-icon position-absolute" 
	      style="bottom: 5px; left: 5px; cursor: pointer;" 
	      onclick="document.getElementById('uploadProfileImage').click();">
	      <i class="fa fa-pencil" aria-hidden="true"></i>
	    </span>
	
	    <!-- Hidden File Input -->
	    <form action="uploadProfileImageServlet" id="profileForm" method="post" enctype="multipart/form-data" style="display: none;">
	      <input 
	        type="file" id="uploadProfileImage" name="profilePic" accept="image/*" 
	        onchange="this.form.submit();" />
	    </form> 
	    <%} %>
	  </div>
	</div>
    
    
    <!-- end of profile -->
	
    <!-- Admin Text Section -->
    <%
    if(user.equals("admin")){ 
    %>
    <div class="admin-dashboard">
    	
    
      <h3><%= user.toString().toUpperCase() %>&nbsp;&nbsp;<i class="fa-solid fa-pencil" onclick="document.getElementById('uploadProfileImage').click();" 
           style="<%= user.equals("admin") || user.equals("finance") ? "display:none;" : "" %>"></i></h3>
      <!-- <hr style="background-color: #000; height: 2px; width: 100%; margin-top: 10px;"> -->
    </div>
    <hr style="background-color: #000; height: 2px; width: 80%; margin:0px 0px 20px 0px"">

    <!-- Navigation Section -->
    <ul class="nav flex-column nav-links w-100">
      <li class="nav-item">
        <a href="adminDashboard.jsp" class="nav-link <%= currentUrl.contains("adminDashboard") ? "active" : "" %>">
          <i class="fa-solid fa-bars me-2"></i> Dashboard
        </a>
      </li>
      <li class="nav-item">
        <a href="adminUsers.jsp" class="nav-link <%= currentUrl.contains("User")? "active" : "" %>">
          <i class="fas fa-users me-2"></i> &nbsp;&nbsp;Users&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <!-- <li class="nav-item">
        <a href="editUser.jsp" class="nav-link">
          <i class="fas fa-user-edit me-2"></i> &nbsp;Edit User&nbsp;&nbsp;
        </a>
      </li> -->
      <li class="nav-item">
        <a href="adminHistory.jsp" class="nav-link <%= currentUrl.contains("adminHistory") ? "active" : "" %>">
         <i class="fa-sharp fa-solid fa-clock"></i> &nbsp;&nbsp;&nbsp;History&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="../change_Password.jsp" class="nav-link <%= currentUrl.contains("changePassword") ? "active" : "" %>">
          <i class="fa-solid fa-key"></i>&nbsp;&nbsp;Change Password&nbsp;
        </a>
      </li>
      
      <li class="nav-item">
        <a href="../logout.jsp" class="nav-link <%= currentUrl.contains("logout") ? "active" : "" %>">
          <i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout&nbsp;
        </a>
      </li>
    </ul>
  
  <%}else if(user.equals("finance")){
	  %>
    
    <div class="admin-dashboard">
    	
    
      <h3><%= user.toString().toUpperCase() %>&nbsp;&nbsp;<i class="fa-solid fa-pencil" onclick="document.getElementById('uploadProfileImage').click();" 
           style="<%= user.equals("admin") || user.equals("finance") ? "display:none;" : "" %>"></i></h3>
      <!-- <hr style="background-color: #000; height: 2px; width: 100%; margin-top: 10px;"> -->
    </div>
    	
    	<hr style="background-color: #000; height: 2px; width: 80%; margin:0px 0px 20px 0px"">
     
    <!-- Navigation Section -->
    <ul class="nav flex-column nav-links w-100">
      <li class="nav-item">
        <a href="financeDashboard.jsp" class="nav-link <%= currentUrl.contains("financeDashboard") ? "active" : "" %>">
          <i class="fa-solid fa-bars me-2"></i> Dashboard
        </a>
      </li>
    
      <li class="nav-item">
        <a href="financeHistory.jsp" class="nav-link <%= currentUrl.contains("financeHistory") ? "active" : "" %>">
          <i class="fa-sharp fa-solid fa-clock"></i> &nbsp;&nbsp;History&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      
      <li class="nav-item">
        <a href="../change_Password.jsp" class="nav-link <%= currentUrl.contains("changePassword") ? "active" : "" %>">
          <i class="fa-solid fa-key"></i>&nbsp;&nbsp;Change Password&nbsp;
        </a>
      </li>
      
      <li class="nav-item">
        <a href="../logout.jsp" class="nav-link <%= currentUrl.contains("logout") ? "active" : "" %>">
          <i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout&nbsp;
        </a>
      </li>
      
      
    </ul>
  <% } else if(user.equals("manager")){
  %> <div class="admin-dashboard">
    	
    
      <h3><%= empName.toString().toUpperCase() %>&nbsp;&nbsp;<i class="fa-solid fa-pencil" onclick="document.getElementById('uploadProfileImage').click();" 
           style="<%= user.equals("admin") || user.equals("finance") ? "display:none;" : "display:none" %>"></i></h3>
      <!-- <hr style="background-color: #000; height: 2px; width: 100%; margin-top: 10px;"> -->
    </div>
    <hr style="background-color: #000; height: 2px; width: 80%; margin:0px 0px 20px 0px"">
	
    <!-- Navigation Section -->
    <ul class="nav flex-column nav-links w-100">
      <li class="nav-item">
        <a href="managerDashboard.jsp" class="nav-link <%= currentUrl.contains("Dashboard") ? "active" : "" %>">
          <i class="fa-solid fa-bars me-2"></i> Dashboard
        </a>
      </li>
      
      <%if(!empId.equals("91101")) {%>
      <li class="nav-item">
        <a href="apply.jsp" class="nav-link <%= currentUrl.contains("apply") ? "active" : "" %>">
          <i class="fas fa-paper-plane me-2"></i> &nbsp;&nbsp;Apply&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="status.jsp" class="nav-link <%= currentUrl.contains("status") ? "active" : "" %>">
          <i class="fas fa-list-alt me-2"></i> &nbsp;&nbsp;Status&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <%} %>
      <li class="nav-item">
        <a href="managerHistory.jsp" class="nav-link <%= currentUrl.contains("History") ? "active" : "" %>">
          <i class="fa-sharp fa-solid fa-clock"></i> &nbsp;&nbsp;&nbsp;History&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="../change_Password.jsp" class="nav-link <%= currentUrl.contains("changePassword") ? "active" : "" %>">
          <i class="fa-solid fa-key"></i>&nbsp;&nbsp;Change Password&nbsp;
        </a>
      </li>
      
      <li class="nav-item">
        <a href="../logout.jsp" class="nav-link <%= currentUrl.contains("logout") ? "active" : "" %>">
          <i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout&nbsp;
        </a>
      </li>
    </ul>
    <%}else{ %>
    <div class="admin-dashboard">
    	
    
      <h3><%= empName.toString().toUpperCase() %>&nbsp;&nbsp;<i class="fa-solid fa-pencil" onclick="document.getElementById('uploadProfileImage').click();" 
           style="<%= user.equals("admin") || user.equals("finance") ? "display:none;" : "display:none" %>"></i></h3>
      <!-- <hr style="background-color: #000; height: 2px; width: 100%; margin-top: 10px;"> -->
    </div>
	<hr style="background-color: #000; height: 2px; width: 80%; margin:0px 0px 20px 0px">
    <!-- Navigation Section -->
    <ul class="nav flex-column nav-links w-100">
      <li class="nav-item">
        <a href="empDashboard.jsp" class="nav-link <%= currentUrl.contains("empDashboard") ? "active" : "" %>">
          <i class="fa-solid fa-bars me-2"></i> Dashboard
        </a>
      </li>
      <li class="nav-item">
        <a href="apply.jsp" class="nav-link <%= currentUrl.contains("apply") ? "active" : "" %>">
          <i class="fas fa-paper-plane me-2"></i> &nbsp;&nbsp;Apply&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="History.jsp" class="nav-link <%= currentUrl.contains("History") ? "active" : "" %>">
          <i class="fa-sharp fa-solid fa-clock"></i> &nbsp;History&nbsp;&nbsp;
        </a>
      </li>
      <!-- <li class="nav-item">
        <a href="view.jsp" class="nav-link">
          <i class="fas fa-eye me-2"></i> &nbsp;&nbsp;View&nbsp;&nbsp;
        </a>
      </li>
       -->
      <li class="nav-item">
        <a href="../change_Password.jsp" class="nav-link">
          <i class="fa-solid fa-key"></i>&nbsp;&nbsp;Change Password&nbsp;
        </a>
      </li>
      
      <li class="nav-item">
        <a href="../logout.jsp" class="nav-link">
          <i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout&nbsp;
        </a>
      </li>
    </ul>
    
    <%} %>
</div>
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  $(document).ready(function() {
	  $("#profileForm").on("submit", function() {
		  location.reload();		
		  
	  })
  })
  </script>
</body>

</html>
