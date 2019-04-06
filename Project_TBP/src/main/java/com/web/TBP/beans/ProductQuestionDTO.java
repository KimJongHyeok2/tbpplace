package com.web.TBP.beans;

import java.sql.Timestamp;

public class ProductQuestionDTO {
	
	private int questionNo;
	private int shopNo;
	private String shopName;
	private int memberBgrade;
	private int productNo;
	private String productSubject;
	private int memberNo;
	private String questionContent;
	private Timestamp questionRegDate;
	
	public ProductQuestionDTO() { }

	public ProductQuestionDTO(int questionNo, int shopNo, String shopName, int memberBgrade, int productNo,
			String productSubject, int memberNo, String questionContent, Timestamp questionRegDate) {
		this.questionNo = questionNo;
		this.shopNo = shopNo;
		this.shopName = shopName;
		this.memberBgrade = memberBgrade;
		this.productNo = productNo;
		this.productSubject = productSubject;
		this.memberNo = memberNo;
		this.questionContent = questionContent;
		this.questionRegDate = questionRegDate;
	}

	public int getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
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

	public int getMemberBgrade() {
		return memberBgrade;
	}

	public void setMemberBgrade(int memberBgrade) {
		this.memberBgrade = memberBgrade;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getProductSubject() {
		return productSubject;
	}

	public void setProductSubject(String productSubject) {
		this.productSubject = productSubject;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public Timestamp getQuestionRegDate() {
		return questionRegDate;
	}

	public void setQuestionRegDate(Timestamp questionRegDate) {
		this.questionRegDate = questionRegDate;
	}
	
}
