package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.ProductImagesDTO;
import com.web.TBP.beans.PurchasesDTO;
import com.web.TBP.beans.PurchasesInfoDTO;
import com.web.TBP.beans.SalesDetailDTO;

public interface MyPageDAO {
	public List<PurchasesDTO> selectOrders(int time, int memberNo, int page, int allRow);
	public PurchasesInfoDTO selectOrderInfo(int productNo);
	public int ordersAllCount(int memberNo, int time);
	public List<SalesDetailDTO> selectSalesDetail(int memberNo, int page, int allRow);
	public int salesAllCount(int memberNo);
	public int orderStatusUpdate(int orderStatus, int orderNo);
	public int purchasesDecision(int orderNo);
	public int purchasesCancle(int orderNo);
	public int selectProductStock(int orderNo);
	public int updateProductStatus(int productStatus, int orderNo);
	public int selectBeginningStock(int orderNo);
	public int selectOrederCompleteCount(int orderNo);
	public int selectMemberMoney(int memberNo);
	public int insertReview(int orderNo, int memberNo, int productScore, String reviewContent);
	public int updateReviewCount(int orderNo);
	public int updateProductScore(int productScore, int orderNo);
	public ProductDTO selectProduct(int productNo);
	public List<ProductImagesDTO> selectProductImages(int productNo);
	public int checkBGrade(int orderNo);
	public int checkSGrade(int orderNo);
	public Integer checkBGrade2(int memberNo);
	public Integer checkSGrade2(int memberNo);
	public int updateMemberBGrade(int gradeStatus, int orderNo);
	public int updateMemberSGrade(int gradeStatus, int orderNo);
	public int selectOrderStatus(int orderNo);
}