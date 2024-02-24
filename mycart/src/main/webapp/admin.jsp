<%@page import="mycart.helper.Helper"%>
<%@page import="java.util.Map"%>
<%@page import="mycart.entites.Category"%>
<%@page import="java.util.List"%>
<%@page import="mycart.helper.FactoryProvider"%>
<%@page import="mycart.dao.CategoryDao"%>
<%@page import="mycart.entites.User"%>
<%
User user = (User) session.getAttribute("current-user");
if (user == null) {

	session.setAttribute("message", "You are not looged in !! Login first");
	response.sendRedirect("login.jsp");
	return;
} else {
	if (user.getUserType().equals("normal")) {

		session.setAttribute("message", "You are not admin !  Do not access this page");
		response.sendRedirect("login.jsp");
		return;
	}
}
%>

<%
CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
List<Category> list = cdao.getCategories();

// getting count

Map<String, Long> m = Helper.getCounts(FactoryProvider.getFactory());

%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Panel</title>

<%@include file="Components/common_css_js.jsp"%>

</head>
<body>

	<%@include file="Components/Navbar.jsp"%>
	<div class="container admin">

		<div class="container-fluid mt-3">
			<%@include file="Components/message.jsp"%>
		</div>

		<div class="row mt-3">
			<!-- first column  -->
			<div class="col-md-4">

				<!-- first box -->
				<div class="card" data-toggle="tooltip" data-placement="top" title="Number of users on this website">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 125px;" class="img-fluid rounded-circle"
								src="image/multiple-users.png" alt="user_icob">
						</div>
						<h1><%= m.get("userCount") %></h1>
						<h1 class="text-uppercase text-muted">User</h1>

					</div>
				</div>

			</div>


			<!-- 2nd Colunm -->
			<div class="col-md-4" data-toggle="tooltip" data-placement="top" title="Total Categories">

				<!-- 2nd box -->
				<div class="card">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 125px;" class="img-fluid rounded-circle"
								src="image/view.png" alt="list_icon">
						</div>

						<h1><%=list.size()%></h1>
						<h1 class="text-uppercase text-muted">Category</h1>
					</div>
				</div>

			</div>

			<!-- 3rd Column -->
			<div class="col-md-4" data-toggle="tooltip" data-placement="top" title="Total Number of Products">

				<!-- 3rd Box -->
				<div class="card">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 125px;" class="img-fluid rounded-circle"
								src="image/service.png" alt="product_icon">

						</div>

						<h1><%= m.get("productCount") %></h1>
						<h1 class="text-uppercase text-muted">Products</h1>
					</div>

				</div>

			</div>

		</div>

		<div class="row mt-3">
			<!-- 2nd row : first column -->
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-category-modal">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 125px;" class="img-fluid rounded-circle"
								src="image/category.png" alt="category_icon">
						</div>

						<p class=mt-2>Click here to add new Category</p>
						<h1 class="text-uppercase text-muted">Add Category</h1>

					</div>
				</div>

			</div>

			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-product-modal">
					<div class="card-body text-center">

						<div class="container">
							<img style="max-width: 125px;" class="img-fluid rounded-circle"
								src="image/plus-sign.png" alt="add_category_icon">
						</div>
						<p class="mt-2">Click here to add Product</p>
						<h1 class="text-uppercase text-muted">Add Products</h1>

					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- Add Category model -->

	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill Category
						details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form action="ProductOperationServlet" method="post">

						<input type="hidden" name="opertation" value="addcategory">

						<div class="form-group">
							<input type="text" class="form-control" name="catTitle"
								placeholder="Enter category title" required />
						</div>

						<div class="form-group">
							<textarea style="height: 300px;" class="form-control"
								placeholder="Enter category Description" name="catDescription"
								required></textarea>
						</div>

						<div class="container text-center">
							<button class="btn btn-outline-success">Add Category</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>

					</form>

				</div>

			</div>
		</div>
	</div>

	<!-- End Category model -->

	<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

	<!-- Add Product modal -->


	<!-- Modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<!-- form -->

					<form action="ProductOperationServlet" method="post"
						enctype="multipart/form-data">

						<input type="hidden" name="opertation" value="addproduct" />

						<!-- Product title -->

						<div class="form-group">
							<input type="text" class="form-control"
								placeholder="Enter Title of Product" name="pName" required />
						</div>

						<!-- product description -->

						<div class="form-group">
							<textarea style="height: 150px;" class="form-control"
								placeholder="Enter product description" name="pDesc"></textarea>
						</div>

						<!-- Product price -->

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Enter Product Price" name="pPrice" required />
						</div>

						<!-- Product Discount -->

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Enter Prodct Discount" name="pDiscount" required />
						</div>

						<!--  Product Quantity -->

						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Enter Product Quantity" name="pQuantity" required />
						</div>

						<!-- Product Category -->

						<div class="form-group">
							<select name="catId" class="form-control" id="">

								<%
								for (Category c : list) {
								%>

								<option value="<%=c.getCategoryId()%> ">
									<%=c.getCategoryTitle()%>
								</option>


								<%
								}
								%>

							</select>
						</div>

						<!-- Product file -->

						<div class="form-group">
							<label for="pPic">Select Picture of product </label> <br> <input
								type="file" id="pPic" name="pPic" required />
						</div>

						<!--  Submit button -->
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Product</button>
						</div>

					</form>

					<!-- End form -->

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- End Product modal -->

	<%@include file="Components/common_modals.jsp"%>
	
	<script>
	$(function(){
		$('[data-toggle="tooltip"]').tooltip()
	})
	
	</script>


</body>
</html>