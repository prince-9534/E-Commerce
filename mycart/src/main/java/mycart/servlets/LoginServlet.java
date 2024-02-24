package mycart.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mycart.dao.UserDao;
import mycart.entites.User;
import mycart.helper.FactoryProvider;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {

			String email = request.getParameter("email");
			String password = request.getParameter("password");

			// Validation

			// Authenticating user

			UserDao userDao = new UserDao(FactoryProvider.getFactory());
			User user = userDao.getUserByEmailAndPassword(email, password);
			// System.out.println(user);

			HttpSession httpSession = request.getSession();

			if (user == null) {
				httpSession.setAttribute("message", "Invalid details !! Try with another one");
				response.sendRedirect("login.jsp");
				return;
			} else {
				out.println("<h1> Welcome " + user.getUserName() + " </h1> ");

				// login

				httpSession.setAttribute("current-user", user);

				if (user.getUserType().equals("admin")) {
					// admin:- admin.jsp
					response.sendRedirect("admin.jsp");
				} else if (user.getUserType().equals("normal")) {
					// normal:- normal.jsp
					response.sendRedirect("normal.jsp");
				} else {
					System.out.println("We have not identified user type");
				}
			}
		}
	}

	public LoginServlet() {
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
