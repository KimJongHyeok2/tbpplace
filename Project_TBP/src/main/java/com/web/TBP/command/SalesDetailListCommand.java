package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.SalesDetailDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.MyPageDAO;

public class SalesDetailListCommand extends Command {

	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		
		int memberNo = (Integer)map.get("memberNo");
		int page = (Integer)map.get("page");
		int allRow = (Integer)map.get("allRow");
		
		MyPageDAO dao = C.sqlSession.getMapper(MyPageDAO.class);
		
		int pageBlock = 10;
		int startPage = 0;
		int endPage = 0;
		int salesAllCount = dao.salesAllCount(memberNo);
		
		int pageCount = salesAllCount/allRow + (salesAllCount%allRow==0? 0:1);
		startPage = ((page - 1)/pageBlock)*pageBlock + 1;
		endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		List<SalesDetailDTO> salesDetailDto = dao.selectSalesDetail(memberNo, (page-1)*allRow+1, allRow);
		
		model.addAttribute("salesDetailDto", salesDetailDto);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageBlock", pageBlock);
	}
	
}
