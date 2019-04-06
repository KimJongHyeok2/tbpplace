package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.web.TBP.beans.TalkDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.TalkDAO;

public class ChatListCommand extends Command {

	@Override
	public void execute2(Model model, HttpServletRequest request) {
		Map<String, Object> map = model.asMap();
		
		int memberNo = (Integer)request.getSession().getAttribute("memberNo");
		
		TalkDAO dao = C.sqlSession.getMapper(TalkDAO.class);
		
		List<TalkDTO> dto = dao.selectTalkList(memberNo);
		
		for(int i=0; i<dto.size(); i++) {
			if(dto.get(i).getMemberNo1() != memberNo) {
				int withMember = dto.get(i).getMemberNo1();
				dto.set(i, dao.selectTalkInfo(dto.get(i).getTbptalkNo(), dto.get(i).getMemberNo1()));
				dto.get(i).setMemberNo(withMember);
			} else if(dto.get(i).getMemberNo2() != memberNo) {
				int withMember = dto.get(i).getMemberNo2();
				dto.set(i, dao.selectTalkInfo(dto.get(i).getTbptalkNo(), dto.get(i).getMemberNo2()));
				dto.get(i).setMemberNo(withMember);
			}
		}
		
		model.addAttribute("talkListDto", dto);
	}
	
}
