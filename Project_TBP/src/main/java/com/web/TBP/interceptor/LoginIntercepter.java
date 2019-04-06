package com.web.TBP.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginIntercepter extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String loginCheck = (String)request.getSession().getAttribute("loginCheck");
		
		if(loginCheck == null) {
			String urlTemp = request.getRequestURL().toString() + "?" + request.getQueryString();
			
			if(urlTemp.substring(urlTemp.lastIndexOf("/")+1, urlTemp.length()-5).equals("order")) {
				request.getSession().setAttribute("productNo", request.getParameter("productNo"));	
			}
			if(urlTemp.indexOf("cart/insert") != -1) {
				request.getSession().setAttribute("productNo", request.getParameter("productNo"));
			}
			
			request.getSession().setAttribute("urlTemp", urlTemp);
			
			response.sendRedirect(request.getContextPath() + "/main/memberLogin");
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}

}