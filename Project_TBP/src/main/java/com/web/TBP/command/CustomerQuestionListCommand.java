package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.CustomerQuestionDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.AdminsDAO;

public class CustomerQuestionListCommand extends Command {

	@Override
	public void execute(Model model) {
		AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
		Map<String, Object> map = model.asMap();
		
		int page = (int)map.get("page");
		int allRow = (int)map.get("allRow");
		
		List<CustomerQuestionDTO> dto = dao.selectAdminCQuestion((page-1)*allRow+1, allRow);
		
		int questionCount = dao.selectAdminCQuestionCount();
		int pageBlock = 10;
		int pageCount = questionCount/allRow + (questionCount%pageBlock==0? 0:1);
		int startPage = ((page-1)/pageBlock)*pageBlock+1;
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		model.addAttribute("cQuestionDto", dto);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBlock", pageBlock);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
	}
	
}
