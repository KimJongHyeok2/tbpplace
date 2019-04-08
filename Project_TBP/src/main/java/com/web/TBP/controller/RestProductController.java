package com.web.TBP.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.ProductQuestionDTO;
import com.web.TBP.beans.QuestionRecommentDTO;
import com.web.TBP.beans.ROrderReviewDTO;
import com.web.TBP.beans.RProductDTO;
import com.web.TBP.beans.RProductQuestionDTO;
import com.web.TBP.beans.RQuestionRecommentDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.ProductDAO;

@RestController
@RequestMapping("/product")
public class RestProductController {

	// 상품추가
	@RequestMapping("/insert")
	public String insertProduct(ProductDTO dto, String[] images) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		int count1 = dao.insertProduct(dto);
		int count2 = 0;
		int orginalCount = 0;
		int fileSystemCount = 1;
		
		if(count1 == 1) {
			dto.setCount(count1);
			dto.setStatus("Ok");
			for(int i=0; i<images.length/2; i++) {
				count2 += dao.insertImages(dto.getProductNo(), images[orginalCount], images[fileSystemCount]);
				orginalCount += 2;
				fileSystemCount += 2;
			}
			if(count2 == 0) {
				return "ImageInsert Fail";
			}
		} else {
			dto.setStatus("Fail");
		}
		
		return dto.getStatus();
	}
	
	// 상품수정
	@RequestMapping("/update")
	public String updateProduct(ProductDTO dto, String[] images) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		int count = dao.deleteImages(dto.getProductNo());
		int count2 = dao.updaetProduct(dto);
		int count3 = 0;
		int orginalCount = 0;
		int fileSystemCount = 1;
		for(int i=0; i<images.length/2; i++) {
			count3 += dao.insertImages(dto.getProductNo(), images[orginalCount], images[fileSystemCount]);
			orginalCount += 2;
			fileSystemCount += 2;
		}
		
		return "Ok";
	}
	
	// 상품삭제
	@RequestMapping("/delete")
	public String deleteProduct(int productNo) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		int orderCount = dao.orderCount(productNo);
		
		if(orderCount > 0) {
			return "hasOrder";
		} else {
			int count = 0;
			count += dao.deleteImages(productNo);
			count += dao.deleteReview(productNo);
			count += dao.deleteOrder(productNo);
			count += dao.deleteProductQRecomment(productNo);
			count += dao.deleteProductQuestion(productNo);
			count += dao.deleteCart(productNo);
			count += dao.deleteNotice(productNo);
			dao.deleteProduct(productNo);
		}

		return "Ok";
	}
	
	// 최신등록 상품 불러오기
	@RequestMapping("/selectNew")
	public RProductDTO selectNewProduct() {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		RProductDTO dto = new RProductDTO();
		
		dto.setList(dao.selectNewProduct());
		
		if(dto.getList() != null && dto.getList().size() != 0) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	// 해당 상품후기 불러오기
	@RequestMapping("/review")
	public ROrderReviewDTO selectReview(int productNo, Integer reviewRow) {
		
		int page = 1;
		
		if(reviewRow == null) {
			reviewRow = 5;
		}
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		ROrderReviewDTO dto = new ROrderReviewDTO();
		dto.setList(dao.selectReview(productNo, (page-1)*reviewRow+1, reviewRow));
		dto.setReviewCount(dao.reviewCount(productNo));
		
		if(dto.getList() != null) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	// 내 상품 거래취소 요청
	@RequestMapping("/orderCancle")
	public String orderCancle(int orderNo) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		int checkOrderStatus = dao.selectOrderStatus(orderNo);
		
		if(checkOrderStatus != 1) {
			return "Already";
		}
		
		int count = dao.cancleOrder(orderNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	// 상품문의 등록
	@RequestMapping("/question/insert")
	public String insertQuestion(ProductQuestionDTO questionDto) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		int count = dao.insertQuestion(questionDto);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	// 해당 상풍문의 불러오기
	@RequestMapping("/question/select")
	public RProductQuestionDTO selectQuestion(int productNo, Integer questionRow) {
		
		int page = 1;
		
		if(questionRow == null) {
			questionRow = 5;
		}
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		RProductQuestionDTO dto = new RProductQuestionDTO();
		dto.setList(dao.selectQuestion(productNo, (page-1)*questionRow+1, questionRow));
		dto.setQuestionCount(dao.questionCount(productNo));
		
		if(dto.getList().size() != 0 || dto.getList() != null) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	// 해당 상품문의 수정
	@RequestMapping("/question/update")
	public String updateQuestion(String questionContent, int questionNo) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		int count = dao.updateQuestion(questionContent, questionNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	// 해당 상품문의 삭제
	@RequestMapping("/question/delete")
	public String deleteQuestion(int questionNo) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		int check = dao.checkQRecomment(questionNo);
		
		if(check > 0) {
			return "hasComment";
		}
		
		int count = dao.deleteQuestion(questionNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	// 해당 상품문의 답변 추가
	@RequestMapping("/qRecomment/insert")
	public String insertQRecomment(QuestionRecommentDTO recommentDto) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		int count = dao.insertQRecomment(recommentDto);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	// 해당 상품문의에 답변 불러오기
	@RequestMapping("/qRecomment/select")
	public RQuestionRecommentDTO selectQRecomment(int productNo) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		RQuestionRecommentDTO dto = new RQuestionRecommentDTO();
		
		dto.setList(dao.selectQRecomment(productNo));
		
		if(dto.getList() != null && dto.getList().size() != 0) {
			dto.setStatus("Ok");
			dto.setCount(dto.getList().size());
		}
		
		return dto;
	}
	
	// 해당 상품답변 수정
	@RequestMapping("/qRecomment/update")
	public String updateQRecomment(String qRecommentContent, int qRecommentNo) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		int count = dao.updateQRecomment(qRecommentContent, qRecommentNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	// 해당 상품답변 삭제
	@RequestMapping("/qRecomment/delete")
	public String deleteQRecomment(int qRecommentNo) {
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		int count = dao.deleteQRecomment(qRecommentNo);
		
		if(count != 1) {
			return "Fail";
		}
		
		return "Ok";
	}
	
}
