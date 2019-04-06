package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.AllNoticeDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.CustomerServiceDAO;

public class CustomerAllNoticeListCommand extends Command {
	
	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		
		String noticeType = (String)map.get("noticeType");
		int page = (int)map.get("page");
		int allRow = (int)map.get("allRow");
		
		CustomerServiceDAO dao = C.sqlSession.getMapper(CustomerServiceDAO.class);
		
		List<AllNoticeDTO> dto = null;
		
		int pageBlock = 10;
		int pageCount = 0;
		
		int startPage = ((page-1)/pageBlock)*pageBlock+1;
		int endPage = startPage + pageBlock - 1;
		
		if(noticeType.equals("all")) {
			dto = dao.selectAllNotice1((page-1)*allRow+1, allRow);
			int allNoticeCount = dao.selectAllNoticeCount1();
			
			pageCount = allNoticeCount/allRow + (allNoticeCount%allRow==0? 0:1);
			if(endPage > pageCount) {
				endPage = pageCount;
			}
		} else if(noticeType.equals("normal")) {
			dto = dao.selectAllNotice2(1, (page-1)*allRow+1, allRow);
			int allNoticeCount = dao.selectAllNoticeCount2(1);
			
			pageCount = allNoticeCount/allRow + (allNoticeCount%allRow==0? 0:1);
			if(endPage > pageCount) {
				endPage = pageCount;
			}
		} else if(noticeType.equals("system")) {
			dto = dao.selectAllNotice2(2, (page-1)*allRow+1, allRow);
			int allNoticeCount = dao.selectAllNoticeCount2(2);
			
			pageCount = allNoticeCount/allRow + (allNoticeCount%allRow==0? 0:1);
			if(endPage > pageCount) {
				endPage = pageCount;
			}
		} else if(noticeType.equals("event")) {
			dto = dao.selectAllNotice2(3, (page-1)*allRow+1, allRow);
			int allNoticeCount = dao.selectAllNoticeCount2(3);
			
			pageCount = allNoticeCount/allRow + (allNoticeCount%allRow==0? 0:1);
			if(endPage > pageCount) {
				endPage = pageCount;
			}
		}
		
		model.addAttribute("allNoticeDto", dto);
		model.addAttribute("pageBlock", pageBlock);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
	}

}
