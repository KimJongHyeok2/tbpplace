package com.web.TBP;

import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.RTalkMessageDTO;
import com.web.TBP.beans.TalkDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.TalkDAO;

@RestController
@RequestMapping("/rTbptalk")
public class RestTBPTalkController {

	@RequestMapping("/send")
	public String send(TalkDTO dto) {
		
		TalkDAO dao = C.sqlSession.getMapper(TalkDAO.class);
		
		int count = 0;
		
		count = dao.checkTalkValidity(dto.getMemberNo1(), dto.getMemberNo2());
		
		if(!(count >= 1)) {
			C.transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					dao.insertTalkList(dto);
					dao.insertTalkContent1(dto);
					dao.updateTalkDate(dto.getTbptalkNo());
					System.out.println(dto.getTbptalkNo());
				}
			});
		} else {
			int count2 = dao.insertTalkContent2(dto);
			dao.updateTalkDate(dto.getTbptalkNo());
			if(count2 != 1) {
				return "Fail";
			}
		}
		
		return "Ok";
	}
	
	@RequestMapping("/call")
	public RTalkMessageDTO call(int memberNo1, int memberNo2) {
		
		TalkDAO dao = C.sqlSession.getMapper(TalkDAO.class);
		
		RTalkMessageDTO dto = new RTalkMessageDTO();
		
		dto.setList(dao.selectTalkContent(memberNo1, memberNo2));
		
		if(dto.getList() != null && dto.getList().size() != 0) {
			dao.updateTalkViewcnt(dto.getList().get(0).getTbptalkNo(), memberNo2);
			dto.setList(dao.selectTalkContent(memberNo1, memberNo2));
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
}