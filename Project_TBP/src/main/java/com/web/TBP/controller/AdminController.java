package com.web.TBP.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.TBP.command.AdminAllNoticeListCommand;
import com.web.TBP.command.CustomerQuestionListCommand;
import com.web.TBP.command.OrderCancleListCommand;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	// 관리자 페이지 이동
	@RequestMapping("/tbpManagement")
	public String adminHome(String pageType, Integer page, Model model) {
		
		int allRow = 20;
		
		if(page == null) {
			page = 1;
		}
		
		if(pageType == null) {
			pageType = "noticeList";
		}
		
		model.addAttribute("page", page);
		model.addAttribute("allRow", allRow);
		
		if(pageType.equals("question")) {
			new CustomerQuestionListCommand().execute(model);
		} else if(pageType.equals("noticeList")) {
			new AdminAllNoticeListCommand().execute(model);
		} else if(pageType.equals("orderCancle")) {
			new OrderCancleListCommand().execute(model);
		}
		
		return "admin/tbpManagement";
	}
	
	// 관리자 로그인 페이지 이동
	@RequestMapping("/loginForm")
	public String loginForm() {
		return "admin/adminLoginForm";
	}
	
}
