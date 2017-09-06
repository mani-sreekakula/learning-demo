package com.learning;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

public class SecondServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		synchronized (this) {
			doPost(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String details2Str = (String) request.getParameter("details2");
		String total2Str = (String) request.getParameter("total2");
		JSONArray details2 = new JSONArray(details2Str);
		JSONArray total2 = new JSONArray(total2Str);
		HttpSession session = request.getSession(true);
		session.setAttribute("details2", details2);
		session.setAttribute("total2", total2);
		response.getWriter().write(request.getContextPath() + "/final.jsp");
	}

}
