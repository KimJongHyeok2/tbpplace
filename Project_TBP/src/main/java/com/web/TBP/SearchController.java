package com.web.TBP;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.TBP.command.CategorySearchListCommand;
import com.web.TBP.command.ReSearchListCommand;
import com.web.TBP.command.SearchListCommand;

@Controller
@RequestMapping("/search")
public class SearchController {
	
	@RequestMapping("/product")
	public String searchProduct(String searchValue, Integer page, Model model) {
		
		if(page == null) {
			page = 1;
		}
		
		int allRow = 10;
		
		model.addAttribute("page", page);
		model.addAttribute("allRow", allRow);
		model.addAttribute("searchValue", searchValue);
		new SearchListCommand().execute(model);
		
		return "search/productSearch";
	}
	
	@RequestMapping("/product/reSearch")
	public String reSearchProduct(int categoryId, String searchValue, Integer page, Model model) {
		
		if(page == null) {
			page = 1;
		}
		
		int allRow = 10;
		
		model.addAttribute("page", page);
		model.addAttribute("allRow", allRow);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("categoryId", categoryId);
		new ReSearchListCommand().execute(model);
		
		return "search/productSearch";
	}
	
	@RequestMapping("/product/category")
	public String depth3Product(int categoryId, Integer page, String type, Model model) {
		
		if(page == null) {
			page = 1;
		}
		
		if(type == null) {
			type = "depth3";
		}
		
		int allRow = 10;
		
		model.addAttribute("type", type);
		model.addAttribute("page", page);
		model.addAttribute("allRow", allRow);
		model.addAttribute("categoryId", categoryId);
		new CategorySearchListCommand().execute(model);
	
		return "search/productSearch";
	}
	
}