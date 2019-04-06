package com.web.TBP.command;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.ui.Model;

import com.web.TBP.beans.SearchCategoryDTO;
import com.web.TBP.beans.SearchDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.SearchDAO;

public class ReSearchListCommand extends Command {
	
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int categoryId = (Integer)map.get("categoryId");
		String searchValue = (String)map.get("searchValue");
		int page = (Integer)map.get("page");
		int allRow = (Integer)map.get("allRow");
		
		SearchDAO dao = C.sqlSession.getMapper(SearchDAO.class);
		int searchAllCount = dao.reSearchAllCount(searchValue, categoryId);
		
		List<SearchDTO> searchDto = dao.selectReSearch(categoryId, searchValue, (page-1)*allRow+1, allRow);
		
		Set<Integer> categoryCount = new HashSet<Integer>();
		for(SearchDTO list : searchDto) {
			categoryCount.add(list.getCategoryId());
		}

		Iterator<Integer> list = categoryCount.iterator();
		
		List<SearchCategoryDTO> categoryResult = new ArrayList<SearchCategoryDTO>();
		int i=0;
		while(list.hasNext()) {
			categoryResult.add(dao.searchCategoryCount(searchValue, list.next()));
			categoryResult.get(i).setSearchValue(searchValue);
			i++;
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
		model.addAttribute("pageType", "re");
	}

}
