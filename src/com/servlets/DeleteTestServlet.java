package com.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.json.JSONClient;

/**
 * Servlet implementation class MonitorServlet
 */
public class DeleteTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			JSONClient client = new JSONClient();
			
			String uri = "&id="+request.getParameter("id");
			
			System.out.println(uri);
			
			//get all the test names
			client.post(request, response, "test/delete", uri);
			
			//forward to monitor page after to run test
			request.getRequestDispatcher("manage").forward(request, response);
		} catch(Exception e) {
			request.setAttribute("errormessage", e.getMessage());
			//forward to view
			request.setAttribute("body", "/WEB-INF/error/error.jsp");
			request.getRequestDispatcher("/WEB-INF/includes/template.jsp").forward(request, response);
		}
	}
	
}
