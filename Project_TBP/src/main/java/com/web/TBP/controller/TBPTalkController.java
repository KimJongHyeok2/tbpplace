package com.web.TBP.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.TBP.beans.ShopDTO;
import com.web.TBP.command.ChatListCommand;
import com.web.TBP.constant.C;
import com.web.TBP.dao.TalkDAO;

@Controller
@RequestMapping("/tbptalk")
public class TBPTalkController {

	@RequestMapping("/chat/{memberNo}")
	public String chat(@PathVariable int memberNo, Model model, HttpServletRequest request) {
		
		TalkDAO dao = C.sqlSession.getMapper(TalkDAO.class);
		
		ShopDTO dto = dao.selectShopInfo(memberNo);
		
		int myMemberNo = 0;
		
		if(request.getSession().getAttribute("memberNo") != null) {
			myMemberNo = (int) request.getSession().getAttribute("memberNo");
		}
		
		if(myMemberNo == memberNo) {
			chat_list(request, model);
		}
		
		if(dto == null) {
			chat_list(request, model);
		}
		
		model.addAttribute("shopInfoDto", dto);
		
		return "tbptalk/chat";
	}
	
	@RequestMapping("/chat_list")
	public String chat_list(HttpServletRequest request, Model model) {
		
		new ChatListCommand().execute2(model, request);
		
		return "tbptalk/chat_list";
	}
	
}