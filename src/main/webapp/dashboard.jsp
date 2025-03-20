<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://kit.fontawesome.com/e084da24f6.js" crossorigin="anonymous"></script>
<!-- <script>
  document.addEventListener("DOMContentLoaded", function () {
    const sidebar = document.getElementById("sidebar");

    fetch("<%= request.getContextPath() %>/GetSidebarServlet")
      .then(response => {
        if (!response.ok) {
          throw new Error("Failed to load sidebar. Status: " + response.status);
        }
        return response.json();
      })
      .then(navItems => {
        let html = `
          <div class="logo-section">
            <img src="<%= request.getContextPath() %>/static/image/logo.png" alt="EDS Logo" class="img-fluid">
          </div>
          <div class="admin-dashboard">
            <h3>DASHBOARD</h3>
          </div>
          <ul class="nav flex-column nav-links w-100">`;

        navItems.forEach(item => {
          if (item.isDropdown) {
            html += `
              <li class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                  <i class="${item.icon} me-2"></i> ${item.title}
                </a>
                <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="changePassword.jsp"><i class="fa-solid fa-key"></i> Change Password</a></li>
                  <li><a class="dropdown-item" href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
                </ul>
              </li>`;
          } else {
            html += `
              <li class="nav-item">
                <a href="${item.link}" class="nav-link">
                  <i class="${item.icon} me-2"></i> ${item.title}
                </a>
              </li>`;
          }
        });

        html += `</ul>`;
        sidebar.innerHTML = html;
      })
      .catch(error => {
        console.error("Error loading sidebar:", error);
        sidebar.innerHTML = `<p style="color:red;">Failed to load sidebar.</p>`;
      });
  });
</script>  -->

<style>
/* Add styles for the sidebar here */
.sidebar {
    width: 250px;
    background: #f8f9fa;
    padding: 15px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}
.sidebar ul {
    list-style: none;
    padding: 0;
}
.sidebar ul li {
    margin: 10px 0;
}
.sidebar ul li a {
    text-decoration: none;
    color: #333;
    display: block;
    padding: 8px;
    border-radius: 4px;
}
.sidebar ul li a:hover {
    background: #007bff;
    color: white;
}
</style>
</head>
<body>
<div class="sidebar">
    <div class="logo-section">
        <img src="static/image/logo.png" alt="EDS Logo" class="img-fluid">
    </div>
    <!-- <div class="admin-dashboard">
        <h3>DASHBOARD</h3>
    </div>
    <ul class="nav flex-column nav-links w-100">
        <%
            // Fetch session attributes
            String user = (String) session.getAttribute("user");
            

            // Generate sidebar links based on roles
            if (user.equals("admin")) {
        %>
        <li><a href="dashboard.jsp"><i class="fa-solid fa-bars"></i> Dashboard</a></li>
        <li><a href="users.jsp"><i class="fas fa-users"></i> Users</a></li>
        <li><a href="editUser.jsp"><i class="fas fa-user-edit"></i> Edit User</a></li>
        <li><a href="view.jsp"><i class="fas fa-eye"></i> View</a></li>
        <li><a href="changePassword.jsp"><i class="fa-solid fa-key"></i> Change Password</a></li>
        <li><a href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
        <% } else if (user.equals("finance")) { %>
        <li><a href="dashboard.jsp"><i class="fa-solid fa-bars"></i> Dashboard</a></li>
        <li><a href="view.jsp"><i class="fas fa-eye"></i> View</a></li>
        <li><a href="changePassword.jsp"><i class="fa-solid fa-key"></i> Change Password</a></li>
        <li><a href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
        <% } else if (user.equals("manager")) { %>
        <li><a href="dashboard.jsp"><i class="fa-solid fa-bars"></i> Dashboard</a></li>
        <li><a href="apply.jsp"><i class="fas fa-paper-plane"></i> Apply</a></li>
        <li><a href="status.jsp"><i class="fas fa-list-alt"></i> Status</a></li>
        <li><a href="view.jsp"><i class="fas fa-eye"></i> View</a></li>
        <li><a href="changePassword.jsp"><i class="fa-solid fa-key"></i> Change Password</a></li>
        <li><a href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
        <% } else { %>
        <li><a href="dashboard.jsp"><i class="fa-solid fa-bars"></i> Dashboard</a></li>
        <li><a href="apply.jsp"><i class="fas fa-paper-plane"></i> Apply</a></li>
        <li><a href="status.jsp"><i class="fas fa-list-alt"></i> Status</a></li>
        <li><a href="changePassword.jsp"><i class="fa-solid fa-key"></i> Change Password</a></li>
        <li><a href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
        <% } %>
    </ul>  -->
    
    
    <!--  -->
    <!--  -->
    
    
    <%String usr = (String)session.getAttribute("user"); 
    
    if(usr.equals("admin")){
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
  
  <%}else if(usr.equals("finance")){
	  %><div class="admin-dashboard">
    
      <h3>FINANCE<br>DASHBOARD</h3>
    </div>

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
  <% } else if(usr.equals("manager")){
  %> <div class="admin-dashboard">
    
      <h3>MANAGER<br>DASHBOARD</h3>
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
          <i class="fas fa-list-alt me-2"></i> &nbsp;Status &nbsp;&nbsp;
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>