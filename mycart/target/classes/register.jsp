<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New User</title>

<%@include file = "Components/common_css_js.jsp" %>

</head>
<body>

<%@include file = "Components/Navbar.jsp" %>

<div class ="container-fluid">

<div class ="row">
<div class="col-md-6 offset-md-3">

<div class="card">

<%@include file="Components/message.jsp" %>

<div class="card-body px-5">

<h3 class="text-center my-3">Sign up here  </h3>

<form action="RegisterServlets" method="post">

 <div class="form-group">
    <label for="name">Your Name</label>
    <input name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter Name">
  </div>
  
 <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
  </div>
  
  <div class="form-group">
    <label for="password">Create Password</label>
    <input name="user_password" type="Password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Create Strong Password">
    <small id="emailHelp" class="form-text text-muted">We'll never share your password with anyone else.</small>
  </div>
  
  <div class="form-group">
    <label for="phone">Phone number</label>
    <input name="user_phone" type="number" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter number">
  </div>
  
  <div class="form-group">
    <label for="address">Your address</label>
    <textarea name="user_address" class="form-control" placeholder="Enter Here"></textarea>
  </div>
  
  <div class="container text-center">
  <button class="btn btn-outline-success">Register</button>
  <button class="btn btn-outline-warning">Reset</button>
  </div>
  
  
</form>

</div>
</div>

</div>

</div>

</div>

</body>
</html>