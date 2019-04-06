package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.ProductQuestionDTO;
import com.web.TBP.beans.QuestionRecommentDTO;
import com.web.TBP.beans.OrderReviewDTO;

public interface ShopDAO {
	public int shopVisitCount(int memberNo);
	public int shopOpeningDate(int memberNo);
	public Integer shopSalesCount(int memberNo);
	public List<ProductDTO> shopProductList(int memberNo, int page, int allRow);
	public int myProductCount(int memberNo);
	public int shopNameUpdate(int memberNo, String shopName);
	public int shopIntroductionUpdate(int memberNo, String shopIntroduction);
	public List<OrderReviewDTO> selectAllReview(int memberNo, int page, int allRow);
	public int selectReviewCount(int memberNo);
	public List<ProductQuestionDTO> selectAllQuestion(int memberNo, int page, int allRow);
	public int selectQuestionCount(int memberNo);
	public List<QuestionRecommentDTO> selectAllQRecomment(int memberNo);
}