package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.NoticeDTO;

public interface NoticeDAO {
	public int insertNotice(int memberNo, int productNo, int noticeWay);
	public int selectMemberNo(int productNo);
	public int selectQMemberNo(int questionNo);
	public int selectOMemberNo(int orderNo);
	public int selectOMemberNo2(int orderNo);
	public int selectOProductNo(int orderNo);
	public int selectCMemberNo(int cQuestionNo);
	public List<NoticeDTO> selectNotices(int memberNo);
	public int readNotice(int noticeNo);
	public int selectNoticeCount(int memberNo);
	public int deleteNotice(int noticeNo);
	public int deleteAllNotice(int memberNo);
}