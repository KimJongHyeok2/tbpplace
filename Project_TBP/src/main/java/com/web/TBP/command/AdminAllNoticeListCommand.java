package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.AllNoticeDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.AdminsDAO;

public class AdminAllNoticeListCommand extends Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		
		int page = (int)map.get("page");
		int allRow = (int)map.get("allRow");
		
		AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
		
		List<AllNoticeDTO> dto = dao.selectAllNotice((page-1)*allRow+1, allRow);
		
		int pageBlock = 10;
		int allNoticeCount = dao.selectAllNoticeCount();
		int pageCount = allNoticeCount/allRow + (allNoticeCount%allRow==0? 0:1);
		int startPage = ((page-1)/pageBlock)*pageBlock+1;
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		model.addAttribute("allNoticeDto", dto);
		model.addAttribute("pageBlock", pageBlock);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
	}
	
}
