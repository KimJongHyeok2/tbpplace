package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.OrderCancleDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.AdminsDAO;

public class OrderCancleListCommand extends Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		
		int page = (int)map.get("page");
		int allRow = (int)map.get("allRow");
		
		AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
		
		int orderCancleCount = dao.selectOrderCancleCount();
		int pageBlock = 10;
		int pageCount = orderCancleCount/allRow + (orderCancleCount%allRow==0? 0:1);
		int startPage = ((page-1)/pageBlock)*pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		List<OrderCancleDTO> dto = dao.selectOrderCancle((page-1)*allRow+1, allRow);
		
		model.addAttribute("orderCancleDto", dto);
		model.addAttribute("pageBlock", pageBlock);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
	}
	
}