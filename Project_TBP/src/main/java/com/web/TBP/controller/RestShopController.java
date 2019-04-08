package com.web.TBP.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.RProductDTO;
import com.web.TBP.beans.RProductQuestionDTO;
import com.web.TBP.beans.RQuestionRecommentDTO;
import com.web.TBP.beans.ROrderReviewDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.ShopDAO;

@RestController
@RequestMapping("/shopInfo")
public class RestShopController {

	@RequestMapping("/product")
	public RProductDTO product(int memberNo, Integer allRow) {
		int page = 1;
		
		if(allRow == null) {
			allRow = 10;
		}
		
		ShopDAO dao = C.sqlSession.getMapper(ShopDAO.class);
		RProductDTO dto = new RProductDTO();
		
		List<ProductDTO> dto2 = dao.shopProductList(memberNo, (page-1)*allRow+1, allRow);
		int myProductCount = dao.myProductCount(memberNo);
		if(dto2 != null) {
			dto.setList(dto2);
			dto.setMyProductCount(myProductCount);
			dto.setCount(dto2.size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	@RequestMapping("/shopName")
	public String shopName(int memberNo, String shopName, HttpServletRequest request) {
		
		ShopDAO dao = C.sqlSession.getMapper(ShopDAO.class);
		
		int count = dao.shopNameUpdate(memberNo, shopName);
		
		if(count != 1) {
			return "Fail";
		}
		
		request.getSession().setAttribute("shopName", shopName);
		
		return "Ok";
	}
	
	@RequestMapping("/shopIntroduction")
	public String shopIntroduction(int memberNo, String shopIntroduction, HttpServletRequest request) {
		
		ShopDAO dao = C.sqlSession.getMapper(ShopDAO.class);
		
		int count = dao.shopIntroductionUpdate(memberNo, shopIntroduction);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	@RequestMapping("/review")
	public ROrderReviewDTO shopReview(int memberNo, Integer reviewRow) {
		
		int page = 1;
		
		if(reviewRow == null) {
			reviewRow = 5;
		}
		
		ShopDAO dao = C.sqlSession.getMapper(ShopDAO.class);
		
		int reviewCount = dao.selectReviewCount(memberNo);
		
		ROrderReviewDTO dto = new ROrderReviewDTO();
		dto.setList(dao.selectAllReview(memberNo, (page-1)*reviewRow+1, reviewRow));

		if(dto.getList() != null && dto.getList().size() != 0) {
			dto.setCount(dto.getList().size());
			dto.setReviewCount(reviewCount);
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	@RequestMapping("/question")
	public RProductQuestionDTO shopQuestion(int memberNo, Integer questionRow) {
		
		int page = 1;
		
		if(questionRow == null) {
			questionRow = 5;
		}
		
		ShopDAO dao = C.sqlSession.getMapper(ShopDAO.class);
		RProductQuestionDTO dto = new RProductQuestionDTO();
		dto.setList(dao.selectAllQuestion(memberNo, (page-1)*questionRow+1, questionRow));
		dto.setQuestionCount(dao.selectQuestionCount(memberNo));
		
		if(dto.getList() != null && dto.getList().size() != 0) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	@RequestMapping("/QRecomment")
	public RQuestionRecommentDTO shopQuestion(int memberNo) {
		
		ShopDAO dao = C.sqlSession.getMapper(ShopDAO.class);
		RQuestionRecommentDTO dto = new RQuestionRecommentDTO();
		dto.setList(dao.selectAllQRecomment(memberNo));
		
		if(dto.getList() != null && dto.getList().size() != 0) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
}