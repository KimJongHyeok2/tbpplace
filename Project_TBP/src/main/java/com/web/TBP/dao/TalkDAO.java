package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.ShopDTO;
import com.web.TBP.beans.TalkDTO;
import com.web.TBP.beans.TalkMessageDTO;

public interface TalkDAO {
	public ShopDTO selectShopInfo(int memberNo);
	public int checkTalkValidity(int memberNo1, int memberNo2);
	public int insertTalkList(TalkDTO dto);
	public int insertTalkContent1(TalkDTO dto);
	public int insertTalkContent2(TalkDTO dto);
	public List<TalkMessageDTO> selectTalkContent(int memberNo1, int memberNo2);
	public List<TalkDTO> selectTalkList(int memberNo);
	public TalkDTO selectTalkInfo(int tbptalkNo, int memberNo);
	public int updateTalkViewcnt(int tbptalkNo, int memberNo);
	public int updateTalkDate(int tbptalkNo);
}