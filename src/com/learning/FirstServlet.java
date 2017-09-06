package com.learning;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

public class FirstServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		synchronized (this) {
			doPost(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String details1Str = (String) request.getParameter("details1");
		String total1Str = (String) request.getParameter("total1");
		JSONArray details1 = new JSONArray(details1Str);
		JSONArray total1 = new JSONArray(total1Str);
		HttpSession session = request.getSession(true);
		session.setAttribute("details1", details1);
		session.setAttribute("total1", total1);
		response.getWriter().write(request.getContextPath() + "/second.jsp");
	}

}
