package com.web.TBP.command;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.SearchCategoryDTO;
import com.web.TBP.beans.SearchDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.SearchDAO;

public class CategorySearchListCommand extends Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int categoryId = (Integer)map.get("categoryId");
		int page = (Integer)map.get("page");
		int allRow = (Integer)map.get("allRow");
		String type = (String)map.get("type");
		
		SearchDAO dao = C.sqlSession.getMapper(SearchDAO.class);
		int searchAllCount = 0;
		
		List<SearchDTO> searchDto = null;
		List<SearchCategoryDTO> categoryResult = new ArrayList<SearchCategoryDTO>();
		if(type.equals("depth3")) {
			searchAllCount = dao.categorySearchAllCount(categoryId);
			searchDto = dao.selectDepth3Search(categoryId, (page-1)*allRow+1, allRow);
			categoryResult.add(dao.searchCategoryCount2(categoryId));
		} else if(type.equals("depth2")) {
			searchAllCount = dao.categorySearchAllCount2(categoryId);
			searchDto = dao.selectDepth2Search(categoryId, (page-1)*allRow+1, allRow);
			categoryResult = dao.searchCategoryCount3(categoryId);
		} else {
			searchAllCount = dao.categorySearchAllCount3(categoryId);
			searchDto = dao.selectDepth1Search(categoryId, (page-1)*allRow+1, allRow);
			categoryResult = dao.searchCategoryCount4(categoryId);
		}

		int pageCount = searchAllCount/10 + (searchAllCount%10==0? 0:1);
		int pageBlock = 10;
		int startPage = ((page - 1)/pageBlock)*pageBlock + 1;
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBlock", pageBlock);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("searchAllCount", searchAllCount);
		model.addAttribute("searchDto", searchDto);
		model.addAttribute("categoryResult", categoryResult);
		model.addAttribute("pageType", "category");
	}
	
}
