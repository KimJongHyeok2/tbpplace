package com.web.TBP.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import com.web.TBP.beans.CategoryDTO;
import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.ProductImagesDTO;
import com.web.TBP.beans.ProductQuestionDTO;
import com.web.TBP.beans.QuestionRecommentDTO;
import com.web.TBP.beans.OrderReviewDTO;
import com.web.TBP.beans.ShopDTO;

@MapperScan
public interface ProductDAO {
	public int insertProduct(ProductDTO dto);
	public int updaetProduct(ProductDTO dto);
	public int deleteProduct(int productNo);
	public int deleteProductQuestion(int productNo);
	public int deleteProductQRecomment(int productNo);
	public int deleteOrder(int productNo);
	public int deleteCart(int productNo);
	public int orderCount(int productNo);
	public int deleteReview(int productNo);
	public List<ProductDTO> selectNewProduct();
	public int cancleOrder(int orderNo);
	public int insertImages(int productNo, String original, String fileSystem);
	public int deleteImages(int productNo);
	public List<ProductDTO> selectProduct(int memberNo, int page, int allRow);
	public int selectCartCount(int productNo);
	public int selectProdcutCount(int memberNo);
	public List<ProductImagesDTO> selectProductImages(@Param("productNoArray")int[] productNoArray);
	public ProductDTO selectViewProduct(int productNo);
	public List<CategoryDTO> depth(int categoryId);
	public List<ProductImagesDTO> selectViewProductImages(int productNo);
	public ShopDTO selectShop(int memberNo);
	public List<ProductDTO> selectShopProducts(int memberNo);
	public int productViewCount(int memberNo);
	public List<OrderReviewDTO> selectReview(int productNo, int page, int allRow);
	public int reviewCount(int productNo);
	public int insertQuestion(ProductQuestionDTO dto);
	public List<ProductQuestionDTO> selectQuestion(int productNo, int page, int allRow);
	public int checkQRecomment(int questionNo);
	public int questionCount(int productNo);
	public int insertQRecomment(QuestionRecommentDTO dto);
	public List<QuestionRecommentDTO> selectQRecomment(int productNo);
	public int updateQRecomment(String qRecommentContent, int qRecommentNo);
	public int deleteQRecomment(int qRecommentNo);
	public int updateQuestion(String questionContent, int questionNo);
	public int deleteQuestion(int questionNo);
	public int deleteNotice(int productNo);
	public int selectMemberGrade(int memberNo);
	public int selectOrderStatus(int orderNo);
}