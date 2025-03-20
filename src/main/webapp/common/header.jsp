<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.header {
   height: 100px;
   width: 100%;
   background: rgb(255,255,255);
   background: linear-gradient(90deg, rgba(255,255,255,1) 0%, rgba(13,146,244,1) 58%);
    
    display: block;
    
    
}
.header img{
    margin-left:95px;
    padding-top: 10px;
    float:left;
}
.header h1{
    padding-top: 10px;
    margin-right:80px;
    float:right;

}

.logo {
    max-width: 80px;
    margin-bottom: 10px;
}

.title {
    color: white;
    font-size: 1.5rem;
    font-weight: bold;
}
</style>
</head>
<body>
	<div class="header">
        	<!--  Using Context Path for Dynamic Web Application -->
            <img src="<%= request.getContextPath() %>/static/image/logo.png" alt="EDS Logo" class="logo">
            <h1 class="title">Travel Management System</h1>
        
    </div>
    
</body>
</html>