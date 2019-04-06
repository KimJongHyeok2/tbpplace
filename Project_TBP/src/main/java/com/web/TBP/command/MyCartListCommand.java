package com.web.TBP.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.web.TBP.beans.CartDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.CartDAO;

public class MyCartListCommand extends Command {

	@Override
	public void execute2(Model model, HttpServletRequest request) {
		
		CartDAO dao = C.sqlSession.getMapper(CartDAO.class);
		
		int memberNo = (Integer)request.getSession().getAttribute("memberNo");
		
		List<CartDTO> cartDto = dao.selectCart(memberNo);
		
		model.addAttribute("cartDto", cartDto);
	}
	
}
