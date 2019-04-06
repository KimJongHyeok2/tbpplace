package com.web.TBP.interceptor;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.web.TBP.beans.ProductOrderDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.NoticeDAO;

public class NoticeIntercepter extends HandlerInterceptorAdapter {
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		int productNo = 0;
		if(request.getParameter("productNo") != null) {
			productNo = Integer.parseInt(request.getParameter("productNo"));
		}
		
		NoticeDAO dao = C.sqlSession.getMapper(NoticeDAO.class);
		
		String requestURI = request.getRequestURI().substring(request.getContextPath().length());
		
		if(requestURI.equals("/product/question/insert")) {			
			int memberNo = dao.selectMemberNo(productNo);
			dao.insertNotice(memberNo, productNo, 1);
		} else if(requestURI.equals("/product/qRecomment/insert")) {
			int questionNo = 0;
			if(request.getParameter("questionNo") != null) {
				questionNo = Integer.parseInt(request.getParameter("questionNo"));
			}
			
			int memberNo = dao.selectQMemberNo(questionNo);
			dao.insertNotice(memberNo, productNo, 2);
		} else if(requestURI.equals("/product/orderPayment")) {
			Map<String, Object> map = modelAndView.getModel();
			ProductOrderDTO dto = (ProductOrderDTO)map.get("dto");
			Set<Integer> productNoOverlap = new HashSet<Integer>();
			
			for(int i=0; i<dto.getProductNo().length; i++) {
				productNoOverlap.add(dto.getProductNo()[i]);
			}

			for(Integer list : productNoOverlap) {
				int memberNo = dao.selectMemberNo(list);
				dao.insertNotice(memberNo, list, 3);
			}
		} else if(requestURI.equals("/purchases/decision")) {
			int orderNo = 0;
			if(request.getParameter("orderNo") != null) {
				orderNo = Integer.parseInt(request.getParameter("orderNo"));
			}
			
			int memberNo = dao.selectOMemberNo(orderNo);
			productNo = dao.selectOProductNo(orderNo);
			dao.insertNotice(memberNo, productNo, 5);
		} else if(requestURI.equals("/purchases/review")) {
			int orderNo = Integer.parseInt(request.getParameter("reviewOrderNo"));
			int memberNo = dao.selectOMemberNo(orderNo);
			productNo = dao.selectOProductNo(orderNo);
			dao.insertNotice(memberNo, productNo, 7);
		} else if(requestURI.equals("/rAdmin/insertCRecomment")) {
			int cQuestionNo = 0;
			if(request.getParameter("cQuestionNo") != null) {
				cQuestionNo = Integer.parseInt(request.getParameter("cQuestionNo"));
			}
			
			if(cQuestionNo != 0) {
				int memberNo = dao.selectCMemberNo(cQuestionNo);
				dao.insertNotice(memberNo, productNo, 8);
			}
		} else if(requestURI.equals("/purchases/cancle")) {
			int orderNo = 0;
			if(request.getParameter("orderNo") != null) {
				orderNo = Integer.parseInt(request.getParameter("orderNo"));
			}
			
			if(orderNo != 0) {
				int memberNo = dao.selectOMemberNo(orderNo);
				dao.insertNotice(memberNo, productNo, 9);
			}
		} else if(requestURI.equals("/product/orderCancle")) {
			int orderNo = 0;
			if(request.getParameter("orderNo") != null) {
				orderNo = Integer.parseInt(request.getParameter("orderNo"));
			}
			
			if(orderNo != 0) {
				int memberNo = dao.selectOMemberNo2(orderNo);
				dao.insertNotice(memberNo, productNo, 10);
			}
		} else if(requestURI.equals("/rAdmin/orderCancle/permission")) {
			int orderNo = 0;
			if(request.getParameter("orderNo") != null) {
				orderNo = Integer.parseInt(request.getParameter("orderNo"));
			}
			
			if(orderNo != 0) {
				int memberNo_B = dao.selectOMemberNo(orderNo);
				int memberNo_S = dao.selectOMemberNo2(orderNo);
				
				dao.insertNotice(memberNo_B, productNo, 11);
				dao.insertNotice(memberNo_S, productNo, 11);
			}
		} else if(requestURI.equals("/rAdmin/orderCancle/returnOrder")) {
			int orderNo = 0;
			if(request.getParameter("orderNo") != null) {
				orderNo = Integer.parseInt(request.getParameter("orderNo"));
			}
			
			if(orderNo != 0) {
				int memberNo_B = dao.selectOMemberNo(orderNo);
				int memberNo_S = dao.selectOMemberNo2(orderNo);
				
				dao.insertNotice(memberNo_B, productNo, 12);
				dao.insertNotice(memberNo_S, productNo, 12);
			}
		} else if(requestURI.equals("/rTbptalk/send")) {
			int memberNo = 0;
			if(request.getParameter("memberNo2") != null) {
				memberNo = Integer.parseInt(request.getParameter("memberNo2"));
			}
			
			if(memberNo != 0) {
				dao.insertNotice(memberNo, productNo, 13);
			}
		}
		
		super.postHandle(request, response, handler, modelAndView);
	}
	
}