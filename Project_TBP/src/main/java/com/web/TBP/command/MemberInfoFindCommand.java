package com.web.TBP.command;

import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.constant.C;
import com.web.TBP.dao.MemberDAO;

public class MemberInfoFindCommand extends Command {

	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		
		String type = (String)map.get("type");		
		MemberDAO dao = C.sqlSession.getMapper(MemberDAO.class);
		
		if(type.equals("type-1")) {
			String memberName = (String)map.get("memberName");
			String memberPnum = (String)map.get("memberPnum");
			
			String memberId = dao.findId(memberName, memberPnum);
			
			model.addAttribute("memberId", memberId);
		} else {
			String memberId = (String)map.get("memberId");
			String memberName = (String)map.get("memberName");
			String memberPnum = (String)map.get("memberPnum");
		
			String memberPw = dao.findPw(memberId, memberName, memberPnum);
			
			model.addAttribute("memberPw", memberPw);
		}
		
	}
	
}
