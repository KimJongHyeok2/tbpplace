package com.web.TBP.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.TBP.command.CategoryPopularListCommand;
import com.web.TBP.command.MemberInfoFindCommand;

@Controller
@RequestMapping("/main")
public class MainController {
	
	// 메인 페이지
	@RequestMapping(value = "/index")
	public String home(Model model) {
		
		new CategoryPopularListCommand().execute(model);
		
		return "main/index";
	}
	
	// 로그인 페이지
	@RequestMapping(value = "/memberLogin")
	public String login(Model model) {
		return "main/memberLogin";
	}
	
	// 아이디/비밀번호 찾기 페이지
	@RequestMapping(value = "/memberFindInfo")
	public String find(String memberId, String memberName, String memberPnum, String type, Model model) {
		
		if(memberName != null && memberPnum != null && type != null) {
			model.addAttribute("type", type);
			model.addAttribute("memberName", memberName);
			model.addAttribute("memberPnum", memberPnum);
			if(type.equals("type-2")) {
				model.addAttribute("memberId", memberId);
			}
			
			new MemberInfoFindCommand().execute(model);
		}
		
		return "main/memberFindInfo";
	}
	
}