package com.web.TBP;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/join")
public class JoinController {

	// 약관동의 페이지
	@RequestMapping("/memberClause")
	public String memberClause() {
		return "join/memberClause";
	}
	
	// 회원정보 입력 페이지
	@RequestMapping(value = "/memberJoin", method = {RequestMethod.GET, RequestMethod.POST})
	public String memberJoin(String clauseCheck) {
		// 회원정보 입력 페이지 이동 전 약관동의 Parameter 검증
		if(clauseCheck == null || !(clauseCheck.equals("Ok"))) {			
			return "redirect:/main/index";
		}
		return "join/memberJoin";
	}
	
}