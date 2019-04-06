package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.AllNoticeDTO;
import com.web.TBP.beans.CustomerQuestionDTO;
import com.web.TBP.beans.CustomerRecomment;
import com.web.TBP.beans.OrderCancleDTO;

public interface AdminsDAO {
	public List<CustomerQuestionDTO> selectAdminCQuestion(int page, int allRow);
	public int selectAdminCQuestionCount();
	public CustomerQuestionDTO selectRAdminCQuestion(int cQuestionNo);
	public int insertAdminCRecomment(CustomerRecomment dto);
	public int updateCQuestionStatus(int cQuestionNo);
	public int checkHasRecomment(int cQuestionNo);
	public int insertAllNotice(AllNoticeDTO dto);
	public List<AllNoticeDTO> selectAllNotice(int page, int allRow);
	public AllNoticeDTO allNoticeView(int allNoticeNo);
	public int selectAllNoticeCount();
	public List<OrderCancleDTO> selectOrderCancle(int page, int allRow);
	public int selectOrderCancleCount();
	public int updateMemberMoney(int orderNo);
	public int updateProductStock(int orderNo);
	public int updateProductStatus(int orderNo);
	public int updateOrderStatus(int orderNo);
	public int updateOrderStatus2(int orderNo);
}