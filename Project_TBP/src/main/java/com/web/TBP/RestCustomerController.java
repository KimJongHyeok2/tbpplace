package com.web.TBP;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.CustomerQuestionDTO;
import com.web.TBP.beans.RAllNoticeDTO;
import com.web.TBP.beans.RCustomerQuestionDTO;
import com.web.TBP.beans.RCustomerRecomment;
import com.web.TBP.constant.C;
import com.web.TBP.dao.CustomerServiceDAO;

@RestController
@RequestMapping("/rCustomer")
public class RestCustomerController {

	@RequestMapping("/questionWrite")
	public String questionWrite(CustomerQuestionDTO dto) {
		
		CustomerServiceDAO dao = C.sqlSession.getMapper(CustomerServiceDAO.class);
		
		int count = dao.cQuestionWrite(dto);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	@RequestMapping("/questionSelect")
	public RCustomerQuestionDTO questionSelect(int memberNo, Integer allRow) {
		
		int page = 1;
		
		if(allRow == null) {
			allRow = 10;
		}
		
		RCustomerQuestionDTO dto = new RCustomerQuestionDTO();
		
		CustomerServiceDAO dao = C.sqlSession.getMapper(CustomerServiceDAO.class);
		
		dto.setList(dao.selectCQuestion(memberNo, (page-1)*allRow+1, allRow));
		
		if(dto.getList() != null && dto.getList().size() != 0) {
			dto.setStatus("Ok");
			dto.setCount(dto.getList().size());
			dto.setcQuestionCount(dao.selectCQuestionCount(memberNo));
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	@RequestMapping("/recommentSelect")
	public RCustomerRecomment recommentSelect(int memberNo, Integer allRow) {
		
		int page = 1;
		
		if(allRow == null) {
			allRow = 10;
		}
		
		RCustomerRecomment dto = new RCustomerRecomment();
		
		CustomerServiceDAO dao = C.sqlSession.getMapper(CustomerServiceDAO.class);
		
		dto.setList(dao.selectCRecomment(memberNo, (page-1)*allRow+1, allRow));
		
		if(dto.getList() != null && dto.getList().size() != 0) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		}
		
		return dto;
	}
	
	@RequestMapping("/allNoticeView")
	public RAllNoticeDTO allNoticeView(int allNoticeNo) {
		
		CustomerServiceDAO dao = C.sqlSession.getMapper(CustomerServiceDAO.class);
		
		RAllNoticeDTO dto = new RAllNoticeDTO();
		
		dto.setList(new ArrayList<>());
		dto.getList().add(dao.allNoticeView(allNoticeNo));
		
		if(dto.getList().size() != 0) {
			dto.setCount(1);
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
}