package com.web.TBP.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.TBP.command.CustomerAllNoticeListCommand;

@Controller
@RequestMapping("/customer")
public class CustomerController {

	// 고객센터 페이지
	@RequestMapping("/customerService")
	public String customerService(String noticeType, Integer page, Model model) {
		
		int allRow = 10;

		if(page == null) {
			page = 1;
		}
		
		if(noticeType == null) {
			noticeType = "all";
		}
		
		model.addAttribute("noticeType", noticeType);
		model.addAttribute("page", page);
		model.addAttribute("allRow", allRow);
		
		new CustomerAllNoticeListCommand().execute(model);
		
		return "customer/customerService";
	}
	
}