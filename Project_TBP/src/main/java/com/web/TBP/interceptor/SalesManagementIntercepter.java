package com.web.TBP.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SalesManagementIntercepter extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		int sessionMemberNo = (Integer)request.getSession().getAttribute("memberNo");
		int requestMemberNo = 0;
		if(request.getParameter("memberNo") != null) {			
			requestMemberNo = Integer.parseInt(request.getParameter("memberNo"));
			
			if(sessionMemberNo != requestMemberNo) {
				response.sendRedirect(request.getContextPath() + "/main/index");
				return false;
			}
		}
		
		return super.preHandle(request, response, handler);
	}

}
