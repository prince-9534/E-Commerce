package mycart.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import mycart.dao.CategoryDao;
import mycart.dao.ProductDao;
import mycart.entites.Category;
import mycart.entites.Product;
import mycart.helper.FactoryProvider;

@MultipartConfig

public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {

			// Servlet
			// Add Category
			// add Product

			String op = request.getParameter("opertation");

			if (op.trim().equals("addcategory")) {
				// Add Category
				// Fetching Category data
				String title = request.getParameter("catTitle");
				String description = request.getParameter("catDescription");

				Category category = new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(description);

				// Category database save

				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
				int catId = categoryDao.saveCategory(category);

				// out.println("Category Saved");

				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Category added successfully : " + catId);
				response.sendRedirect("admin.jsp");
				return;

			} else if (op.trim().equals("addproduct")) {
				// add Product
				// work

				String pName = request.getParameter("pName");
				String pDesc = request.getParameter("pDesc");
				int pPrice = Integer.parseInt(request.getParameter("pPrice"));
				int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
				int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
				int catId = Integer.parseInt(request.getParameter("catId").trim());
				Part part = request.getPart("pPic");

				Product p = new Product();
				p.setpName(pName);
				p.setpDesc(pDesc);
				p.setpPrice(pPrice);
				p.setpDiscount(pDiscount);
				p.setpQuantity(pQuantity);
				p.setpPhoto(part.getSubmittedFileName());

				// get Category by id
				CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
				Category category = cdao.getCategoryById(catId);

				p.setCategory(category);

				// product save

				ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
				pdao.saveProduct(p);

				String path = request.getRealPath("image")+ File.separator+ "products"+ File.separator +part.getSubmittedFileName();
     			System.out.println(path);
				
		//		String imageFilename = part.getSubmittedFileName();
		//		String path = "C:/Users/Prince Sharma/eclipse-workspace/mycart/target/classes/image/products/"+imageFilename;
				
			

				// Uploading code

				try {

					FileOutputStream fos = new FileOutputStream(path);

					InputStream is = part.getInputStream();

					// reading data

					byte[] data = new byte[is.available()];
					is.read(data);

					// Writing the data

					fos.write(data);

					fos.close();
					
					
				} catch (Exception e) {
					e.printStackTrace();
				}

				// out.println("Product save success...");

				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Product added successfully  : ");
				response.sendRedirect("admin.jsp");
				return;

			}
		}
	}

	public ProductOperationServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		processRequest(request, response);

	}
}
