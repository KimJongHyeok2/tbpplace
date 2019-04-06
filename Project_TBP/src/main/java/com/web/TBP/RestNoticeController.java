package com.web.TBP;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.RNoticeDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.NoticeDAO;

@RestController
@RequestMapping("/notice")
public class RestNoticeController {
	
	@RequestMapping("/select")
	public RNoticeDTO selectNotice(int memberNo) {		
		NoticeDAO dao = C.sqlSession.getMapper(NoticeDAO.class);
		
		RNoticeDTO dto = new RNoticeDTO();
		dto.setList(dao.selectNotices(memberNo));
		
		if(dto.getList() != null && dto.getList().size() != 0) {
			dto.setCount(dto.getList().size());
			dto.setNoticeCount(dao.selectNoticeCount(memberNo));
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	@RequestMapping("/read")
	public String readNotice(int noticeNo) {
		
		NoticeDAO dao = C.sqlSession.getMapper(NoticeDAO.class);
		
		int count = dao.readNotice(noticeNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	@RequestMapping("/delete")
	public String deleteNotice(int noticeNo) {
		
		NoticeDAO dao = C.sqlSession.getMapper(NoticeDAO.class);
		
		int count = dao.deleteNotice(noticeNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";	
	}
	
	@RequestMapping("/deleteAll")
	public String deleteAllNotice(int memberNo) {
		
		NoticeDAO dao = C.sqlSession.getMapper(NoticeDAO.class);
		
		int count = dao.deleteAllNotice(memberNo);
		
		if(count == 0) {
			return "Fail";
		}
		
		return "Ok";	
	}
}
