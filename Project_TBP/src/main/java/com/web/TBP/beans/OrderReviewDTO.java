package com.web.TBP.beans;

import java.sql.Timestamp;

public class OrderReviewDTO {
	
	private int reviewNo;
	private int orderNo;
	private int productNo;
	private int memberNo;
	private int shopNo;
	private String shopName;
	private int memberBgrade;
	private String reviewContent;
	private String productSubject;
	private int productScore;
	private Timestamp reviewRegDate;
	
	public OrderReviewDTO() { }

	public OrderReviewDTO(int reviewNo, int orderNo, int productNo, int memberNo, int shopNo, String shopName,
			int memberBgrade, String reviewContent, String productSubject, int productScore, Timestamp reviewRegDate) {
		this.reviewNo = reviewNo;
		this.orderNo = orderNo;
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.shopNo = shopNo;
		this.shopName = shopName;
		this.memberBgrade = memberBgrade;
		this.reviewContent = reviewContent;
		this.productSubject = productSubject;
		this.productScore = productScore;
		this.reviewRegDate = reviewRegDate;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
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

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public String getProductSubject() {
		return productSubject;
	}

	public void setProductSubject(String productSubject) {
		this.productSubject = productSubject;
	}

	public int getProductScore() {
		return productScore;
	}

	public void setProductScore(int productScore) {
		this.productScore = productScore;
	}

	public Timestamp getReviewRegDate() {
		return reviewRegDate;
	}

	public void setReviewRegDate(Timestamp reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}

}
