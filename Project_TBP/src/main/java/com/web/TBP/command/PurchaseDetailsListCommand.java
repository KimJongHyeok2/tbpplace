package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.web.TBP.beans.PurchasesDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.MyPageDAO;

public class PurchaseDetailsListCommand extends Command {

	@Override
	public void execute2(Model model, HttpServletRequest request) {
		Map<String, Object> map = model.asMap();
		int time = (Integer)map.get("time");
		int page = (Integer)map.get("page");
		int allRow = (Integer)map.get("allRow");
		
		int memberNo = (Integer)request.getSession().getAttribute("memberNo");
		
		MyPageDAO dao = C.sqlSession.getMapper(MyPageDAO.class);
		
		int orderAllCount = dao.ordersAllCount(memberNo, time);
		int pageCount = 0;
		int pageBlock = 10;
		int startPage = 0;
		int endPage = 0;
		
		pageCount = orderAllCount/allRow + (orderAllCount%allRow==0? 0:1);
		startPage = ((page-1)/pageBlock)*pageBlock+1;
		endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		request.getSession().setAttribute("memberMoney", dao.selectMemberMoney(memberNo));
		
		List<PurchasesDTO> dto = dao.selectOrders(time, memberNo, (page-1)*allRow+1, allRow);
		model.addAttribute("purchasesDto", dto);
		model.addAttribute("time", time);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageBlock", pageBlock);
	}
	
}
