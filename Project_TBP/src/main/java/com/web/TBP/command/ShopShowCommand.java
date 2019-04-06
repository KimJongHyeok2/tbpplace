package com.web.TBP.command;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.web.TBP.beans.ShopDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.MemberDAO;
import com.web.TBP.dao.ShopDAO;

public class ShopShowCommand extends Command {

	@Override
	public void execute4(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = model.asMap();
		int memberNo = (Integer)map.get("memberNo");
		
		ShopDAO dao = C.sqlSession.getMapper(ShopDAO.class);
		MemberDAO dao2 = C.sqlSession.getMapper(MemberDAO.class);

		boolean visitFlag = false;

		Cookie[] visitCookie = request.getCookies();
		if(visitCookie != null) {
			for(int i=0; i<visitCookie.length; i++) {
				if(visitCookie[i].getName().equals("visit" + memberNo) && visitCookie[i].getValue().equals("1")) {
					visitFlag = true;
				}
			}
			if(!visitFlag) {
				Cookie visitCheck = new Cookie("visit" + memberNo, "1");
				visitCheck.setMaxAge(21600);
				response.addCookie(visitCheck);
				dao.shopVisitCount(memberNo);
			}
		}
		
		ShopDTO dto = dao2.loginShop(memberNo);
		if(dto != null) {
			int openingDate = dao.shopOpeningDate(memberNo);
			Integer salesCount = dao.shopSalesCount(memberNo);
			if(salesCount == null) {
				salesCount = 0;
			}
			dto.setShopOpeningDate(openingDate);
			dto.setShopSalesCount(salesCount);
			model.addAttribute("shopInfo", dto);
		} else {
			try {
				response.sendRedirect(request.getContextPath() + "/main/index");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}	
	}

}
