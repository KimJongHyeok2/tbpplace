package com.web.TBP;

import java.util.ArrayList;

import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.AllNoticeDTO;
import com.web.TBP.beans.CustomerRecomment;
import com.web.TBP.beans.RAllNoticeDTO;
import com.web.TBP.beans.RCustomerQuestionDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.AdminsDAO;

@RestController
@RequestMapping("/rAdmin")
public class RestAdminController {
	
	static int check = 1;
	
	@RequestMapping("/selectCQuestion")
	public RCustomerQuestionDTO selectCQuestion(int cQuestionNo) {
		
		AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
		
		RCustomerQuestionDTO dto = new RCustomerQuestionDTO();
		
		dto.setList(new ArrayList<>());
		
		dto.getList().add(dao.selectRAdminCQuestion(cQuestionNo));
		
		if(dto.getList().size() != 0) {
			dto.setCount(1);
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	@RequestMapping("/insertCRecomment")
	public String insertCRecomment(CustomerRecomment dto) {
		
		C.transactionTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
				
				check = dao.checkHasRecomment(dto.getcQuestionNo());
				
				if(check != 2) {
					dao.insertAdminCRecomment(dto);
					dao.updateCQuestionStatus(dto.getcQuestionNo());	
				}
				
			}
			
		});
		
		if(check == 2) {
			check = 1;
			return "hasRecomment";
		}
		
		return "Ok";
	}
	
	@RequestMapping("/insertNotice")
	public String insertNotice(AllNoticeDTO dto) {
		
		AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
		
		int count = dao.insertAllNotice(dto);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	@RequestMapping("/allNoticeView")
	public RAllNoticeDTO allNoticeView(int allNoticeNo) {
		
		AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
		
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
	
	@RequestMapping("/orderCancle/permission")
	public String permission(int orderNo) {
		
		AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
		
		C.transactionTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				dao.updateMemberMoney(orderNo);
				dao.updateProductStock(orderNo);
				dao.updateProductStatus(orderNo);
				dao.updateOrderStatus(orderNo);	
			}
		});
		
		return "Ok";
	}
	
	@RequestMapping("/orderCancle/returnOrder")
	public String returnOrder(int orderNo) {
		
		AdminsDAO dao = C.sqlSession.getMapper(AdminsDAO.class);
		
		int count = dao.updateOrderStatus2(orderNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
}
