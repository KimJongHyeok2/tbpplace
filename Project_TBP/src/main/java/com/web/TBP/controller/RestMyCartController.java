package com.web.TBP.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.constant.C;
import com.web.TBP.dao.CartDAO;

@RestController
@RequestMapping("/cart")
public class RestMyCartController {
	
	@RequestMapping("/insert")
	public String insert(int productNo, int memberNo, int cartStock) {
		
		CartDAO dao = C.sqlSession.getMapper(CartDAO.class);
		
		int count = dao.insertCart(memberNo, productNo, cartStock);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	@RequestMapping("/delete")
	public String delete(int cartNo) {
		
		CartDAO dao = C.sqlSession.getMapper(CartDAO.class);
		
		int count = dao.deleteCart(cartNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
}
