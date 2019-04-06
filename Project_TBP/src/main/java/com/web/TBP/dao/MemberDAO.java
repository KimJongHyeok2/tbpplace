package com.web.TBP.dao;

import com.web.TBP.beans.MemberDTO;
import com.web.TBP.beans.ShopDTO;

public interface MemberDAO {
	public int insertMember(MemberDTO dto);
	public String idOverlap(String id);
	public MemberDTO loginMember(String id, String pw);
	public ShopDTO loginShop(int memberNo);
	public int checkInfo(String memberName, String memberPnum);
	public int checkInfo2(String memberId, String memberName, String memberPnum);
	public String findId(String memberName, String memberPnum);
	public String findPw(String memberId, String memberName, String memberPnum);
}