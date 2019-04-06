package com.web.TBP.beans;

import java.sql.Timestamp;

public class CustomerQuestionDTO {

	private int cQuestionNo;
	private int memberNo;
	private String cQuestionSubject;
	private String cQuestionContent;
	private int cQuestionStatus;
	private Timestamp cQuestionRegDate;
	
	// 관리자 페이지 문의목록 출력시 포함될 필드
	private int shopNo;
	private String shopName;
	
	public CustomerQuestionDTO() { }
	
	public CustomerQuestionDTO(int cQuestionNo, int memberNo, String cQuestionSubject, String cQuestionContent,
			int cQuestionStatus, Timestamp cQuestionRegDate, int shopNo, String shopName) {
		this.cQuestionNo = cQuestionNo;
		this.memberNo = memberNo;
		this.cQuestionSubject = cQuestionSubject;
		this.cQuestionContent = cQuestionContent;
		this.cQuestionStatus = cQuestionStatus;
		this.cQuestionRegDate = cQuestionRegDate;
		this.shopNo = shopNo;
		this.shopName = shopName;
	}

	public int getcQuestionNo() {
		return cQuestionNo;
	}

	public void setcQuestionNo(int cQuestionNo) {
		this.cQuestionNo = cQuestionNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getcQuestionSubject() {
		return cQuestionSubject;
	}

	public void setcQuestionSubject(String cQuestionSubject) {
		this.cQuestionSubject = cQuestionSubject;
	}

	public String getcQuestionContent() {
		return cQuestionContent;
	}

	public void setcQuestionContent(String cQuestionContent) {
		this.cQuestionContent = cQuestionContent;
	}

	public int getcQuestionStatus() {
		return cQuestionStatus;
	}

	public void setcQuestionStatus(int cQuestionStatus) {
		this.cQuestionStatus = cQuestionStatus;
	}

	public Timestamp getcQuestionRegDate() {
		return cQuestionRegDate;
	}

	public void setcQuestionRegDate(Timestamp cQuestionRegDate) {
		this.cQuestionRegDate = cQuestionRegDate;
	}

	public int getShopNo() {
		return shopNo;
	}

	public void setShopNo(int shopNo) {
		this.shopNo = shopNo;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	
}
