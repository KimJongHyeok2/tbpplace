package com.web.TBP.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.PurchasesInfoDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.MyPageDAO;

@RestController
@RequestMapping("/purchases")
public class RestMyPageController {
	
	// 거래정보
	@RequestMapping("/orderInfo")
	public PurchasesInfoDTO orderInfo(int productNo) {
		
		MyPageDAO dao = C.sqlSession.getMapper(MyPageDAO.class);
		PurchasesInfoDTO dto = dao.selectOrderInfo(productNo);
		
		return dto;
	}
	
	// 구매확정
	@RequestMapping(value = "/decision", produces = "application/text; charset=utf8")
	public String decision(int orderNo, HttpServletRequest request) {
		
		MyPageDAO dao = C.sqlSession.getMapper(MyPageDAO.class);
		
		int checkOrderStatus = dao.selectOrderStatus(orderNo);
		
		if(checkOrderStatus != 1) {
			return "이미 확정되었거나 취소진행/완료된 상품입니다.";
		}
		
		int count = dao.orderStatusUpdate(2, orderNo);
		if(count == 1) {			
			int count2 = dao.purchasesDecision(orderNo);
			if(count2 == 1) {
				int beginningStock = dao.selectBeginningStock(orderNo);
				int orderCompleteCount = dao.selectOrederCompleteCount(orderNo);
				if(beginningStock == orderCompleteCount) {
					int count3 = dao.updateProductStatus(2, orderNo);
					if(count3 != 1) {
						return "ProductStatus Update Fail";
					}
				}
			} else {
				return "ProductStock Select Fail";
			}
			int memberBGrade = 0;
			int memberSGrade = 0;
			int bGradeMoney = dao.checkBGrade(orderNo);
			int sGradeMoney = dao.checkSGrade(orderNo);
			
			if(bGradeMoney >= 1000000 && bGradeMoney < 2000000) {
				dao.updateMemberBGrade(1, orderNo);
				memberBGrade = 1;
			} else if(bGradeMoney >= 2000000 && bGradeMoney < 4000000) {
				dao.updateMemberBGrade(2, orderNo);
				memberBGrade = 2;
			} else if(bGradeMoney >= 4000000 && bGradeMoney < 8000000) {
				dao.updateMemberBGrade(3, orderNo);
				memberBGrade = 3;
			} else if(bGradeMoney >= 8000000) {
				dao.updateMemberBGrade(4, orderNo);
				memberBGrade = 4;
			}
			
			if(sGradeMoney >= 1000000 && sGradeMoney < 2000000) {
				dao.updateMemberSGrade(1, orderNo);
				memberSGrade = 1;
			} else if(sGradeMoney >= 2000000 && sGradeMoney < 4000000) {
				dao.updateMemberSGrade(2, orderNo);
				memberSGrade = 2;
			} else if(sGradeMoney >= 4000000 && sGradeMoney < 8000000) {
				dao.updateMemberSGrade(3, orderNo);
				memberSGrade = 3;
			} else if(sGradeMoney >= 8000000) {
				dao.updateMemberSGrade(4, orderNo);
				memberSGrade = 4;
			}
			
			if(memberBGrade != 0 && memberSGrade != 0) {
				request.getSession().setAttribute("memberBgrade", memberBGrade);
			}
		} else {
			return "PurchasesDecision Fail";
		}
				
		return "Ok";
	}
	
	@RequestMapping("/cancle")
	public String cancle(int orderNo) {
		
		MyPageDAO dao = C.sqlSession.getMapper(MyPageDAO.class);
		
		int checkOrderStatus = dao.selectOrderStatus(orderNo);
		
		if(checkOrderStatus != 1) {
			return "Already";
		}
		
		int count = dao.purchasesCancle(orderNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	@RequestMapping("/review")
	public String review(int reviewOrderNo, int memberNo, int productScore, String reviewContent) {
		
		MyPageDAO dao = C.sqlSession.getMapper(MyPageDAO.class);
		
		int count = dao.insertReview(reviewOrderNo, memberNo, productScore, reviewContent);
		if(count == 1) {
			dao.updateReviewCount(reviewOrderNo);
			dao.updateProductScore(productScore, reviewOrderNo);
		} else {
			return "Fail";
		}
		
		return "Ok";
	}
}
