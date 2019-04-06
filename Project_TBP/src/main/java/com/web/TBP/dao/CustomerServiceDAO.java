package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.AllNoticeDTO;
import com.web.TBP.beans.CustomerQuestionDTO;
import com.web.TBP.beans.CustomerRecomment;

public interface CustomerServiceDAO {
	public int cQuestionWrite(CustomerQuestionDTO dto);
	public List<CustomerQuestionDTO> selectCQuestion(int memberNo, int page, int allRow);
	public int selectCQuestionCount(int memberNo);
	public List<CustomerRecomment> selectCRecomment(int memberNo, int page, int allRow);
	public List<AllNoticeDTO> selectAllNotice1(int page, int allRow);
	public List<AllNoticeDTO> selectAllNotice2(int noticeType, int page, int allRow);
	public int selectAllNoticeCount1();
	public int selectAllNoticeCount2(int noticeType);
	public AllNoticeDTO allNoticeView(int allNoticeNo);
}