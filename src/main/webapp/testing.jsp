<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
       background-image: url(static/image/back-img.jpg);
      background-size: cover;
      background-repeat: no-repeat;
      height: 100vh;
      margin: 0;
    }

	.main-content{
	width:auto;
	height:auto;
	
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
      padding: 20px 0;
    }

    .logo-section {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 20px; /* Add a small margin below the logo */
    }

    .logo-section img {
      width: 80px;
      height: 80px;
    }

    .admin-dashboard {
      text-align: center;
      margin-top: 20px;
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
      justify-content: center; 
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
  </style>
</head>

<body>
  <div class="sidebar">
    <!-- Logo Section -->
    <div class="logo-section">
      <img src="<%= request.getContextPath() %>/static/image/logo.png"" alt="EDS Logo" class="img-fluid">
    </div>

    <!-- Admin Text Section -->
    <%String user = (String)session.getAttribute("user"); 
    
    if(user.equals("admin")){
    %>
    <div class="admin-dashboard">
    
      <h3>ADMIN<br>DASHBOARD</h3>
    </div>

    <!-- Navigation Section -->
    <ul class="nav flex-column nav-links w-100">
      <li class="nav-item">
        <a href="dashboard.jsp" class="nav-link active">
          <i class="fa-solid fa-bars me-2"></i> Dashboard
        </a>
      </li>
      <li class="nav-item">
        <a href="users.jsp" class="nav-link">
          <i class="fas fa-users me-2"></i> &nbsp;&nbsp;Users&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="editUser.jsp" class="nav-link">
          <i class="fas fa-user-edit me-2"></i> &nbsp;Edit User&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="view.jsp" class="nav-link">
          <i class="fas fa-eye me-2"></i> &nbsp;&nbsp;View&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" id="profileToggle" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fas fa-user me-2"></i> &nbsp;&nbsp;Profile&nbsp;&nbsp;
        </a>
        <ul class="dropdown-menu" aria-labelledby="profileToggle">
          <li><a class="dropdown-item" href="changePassword.jsp"><i class="fa-solid fa-key"></i>&nbsp;&nbsp;Change Password</a></li>
          <li><a class="dropdown-item" href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout</a></li>
        </ul>
      </li>
    </ul>
  
  <%}else if(user.equals("finance")){
	  %><div class="admin-dashboard">
    
      <h3>FINANCE<br>DASHBOARD</h3>
    </div>
	<hr>
    <!-- Navigation Section -->
    <ul class="nav flex-column nav-links w-100">
      <li class="nav-item">
        <a href="dashboard.jsp" class="nav-link active">
          <i class="fa-solid fa-bars me-2"></i> Dashboard
        </a>
      </li>
      <!-- <li class="nav-item">
        <a href="users.jsp" class="nav-link">
          <i class="fas fa-users me-2"></i> &nbsp;&nbsp;Users&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="editUser.jsp" class="nav-link">
          <i class="fas fa-user-edit me-2"></i> &nbsp;Edit User&nbsp;&nbsp;
        </a>
      </li>
       -->
      <li class="nav-item">
        <a href="view.jsp" class="nav-link">
          <i class="fas fa-eye me-2"></i> &nbsp;&nbsp;View&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" id="profileToggle" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fas fa-user me-2"></i> &nbsp;&nbsp;Profile&nbsp;&nbsp;
        </a>
        <ul class="dropdown-menu" aria-labelledby="profileToggle">
          <li><a class="dropdown-item" href="changePassword.jsp"><i class="fa-solid fa-key"></i>&nbsp;&nbsp;Change Password</a></li>
          <li><a class="dropdown-item" href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout</a></li>
        </ul>
      </li>
    </ul>
  <% } else if(user.equals("manager")){
  %> <div class="admin-dashboard">
    
      <h3>MANAGER<br>DASHBOARD</h3>
    </div>
	<hr style="background-color:#000">
    <!-- Navigation Section -->
    <ul class="nav flex-column nav-links w-100">
      <li class="nav-item">
        <a href="dashboard.jsp" class="nav-link active">
          <i class="fa-solid fa-bars me-2"></i> Dashboard
        </a>
      </li>
      <li class="nav-item">
        <a href="apply.jsp" class="nav-link">
          <i class="fas fa-paper-plane me-2"></i> &nbsp;&nbsp;Users&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="status.jsp" class="nav-link">
          <i class="fas fa-list-alt me-2"></i> &nbsp;Edit User&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="view.jsp" class="nav-link">
          <i class="fas fa-eye me-2"></i> &nbsp;&nbsp;View&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" id="profileToggle" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fas fa-user me-2"></i> &nbsp;&nbsp;Profile&nbsp;&nbsp;
        </a>
        <ul class="dropdown-menu" aria-labelledby="profileToggle">
          <li><a class="dropdown-item" href="changePassword.jsp"><i class="fa-solid fa-key"></i>&nbsp;&nbsp;Change Password</a></li>
          <li><a class="dropdown-item" href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout</a></li>
        </ul>
      </li>
    </ul>
    <%}else{ %>
    <div class="admin-dashboard">
    
      <h3>USER<br>DASHBOARD</h3>
    </div>
	
    <!-- Navigation Section -->
    <ul class="nav flex-column nav-links w-100">
      <li class="nav-item">
        <a href="dashboard.jsp" class="nav-link active">
          <i class="fa-solid fa-bars me-2"></i> Dashboard
        </a>
      </li>
      <li class="nav-item">
        <a href="apply.jsp" class="nav-link">
          <i class="fas fa-paper-plane me-2"></i> &nbsp;&nbsp;Apply&nbsp;&nbsp;&nbsp;&nbsp;
        </a>
      </li>
      <li class="nav-item">
        <a href="status.jsp" class="nav-link">
          <i class="fas fa-list-alt me-2"></i> &nbsp;Status&nbsp;&nbsp;
        </a>
      </li>
      <!-- <li class="nav-item">
        <a href="view.jsp" class="nav-link">
          <i class="fas fa-eye me-2"></i> &nbsp;&nbsp;View&nbsp;&nbsp;
        </a>
      </li>
       -->
      <li class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" id="profileToggle" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fas fa-user me-2"></i> &nbsp;&nbsp;Profile&nbsp;&nbsp;
        </a>
        <ul class="dropdown-menu" aria-labelledby="profileToggle">
          <li><a class="dropdown-item" href="changePassword.jsp"><i class="fa-solid fa-key"></i>&nbsp;&nbsp;Change Password</a></li>
          <li><a class="dropdown-item" href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout</a></li>
        </ul>
      </li>
    </ul>
    
    <%} %>
</div>
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
