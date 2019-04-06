package com.web.TBP.beans;

import java.sql.Timestamp;

public class TalkDTO {
	
	private int tbptalkNo;
	private int memberNo1;
	private int memberNo2;
	private String tbptalkContent;
	private Timestamp tbptalkRegDate;
	
	// CHAT LIST 출력시
	private String shopName;
	private int memberNo;
	private int tbptalkNotReadCount;
	
	public TalkDTO() { }

	public TalkDTO(int tbptalkNo, int memberNo1, int memberNo2, String tbptalkContent, Timestamp tbptalkRegDate,
			String shopName, int memberNo, int tbptalkNotReadCount) {
		this.tbptalkNo = tbptalkNo;
		this.memberNo1 = memberNo1;
		this.memberNo2 = memberNo2;
		this.tbptalkContent = tbptalkContent;
		this.tbptalkRegDate = tbptalkRegDate;
		this.shopName = shopName;
		this.memberNo = memberNo;
		this.tbptalkNotReadCount = tbptalkNotReadCount;
	}

	public int getTbptalkNo() {
		return tbptalkNo;
	}

	public void setTbptalkNo(int tbptalkNo) {
		this.tbptalkNo = tbptalkNo;
	}

	public int getMemberNo1() {
		return memberNo1;
	}

	public void setMemberNo1(int memberNo1) {
		this.memberNo1 = memberNo1;
	}

	public int getMemberNo2() {
		return memberNo2;
	}

	public void setMemberNo2(int memberNo2) {
		this.memberNo2 = memberNo2;
	}

	public String getTbptalkContent() {
		return tbptalkContent;
	}

	public void setTbptalkContent(String tbptalkContent) {
		this.tbptalkContent = tbptalkContent;
	}

	public Timestamp getTbptalkRegDate() {
		return tbptalkRegDate;
	}

	public void setTbptalkRegDate(Timestamp tbptalkRegDate) {
		this.tbptalkRegDate = tbptalkRegDate;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getTbptalkNotReadCount() {
		return tbptalkNotReadCount;
	}

	public void setTbptalkNotReadCount(int tbptalkNotReadCount) {
		this.tbptalkNotReadCount = tbptalkNotReadCount;
	}
	
}
