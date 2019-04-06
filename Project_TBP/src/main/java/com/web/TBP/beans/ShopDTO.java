package com.web.TBP.beans;

import java.sql.Timestamp;

public class ShopDTO {
	
	private int shopNo; // 상점 고유번호
	private int memberNo; // 회원 고유번호
	private String shopName; // 상점이름
	private String shopIntroduction; // 상점 소개말
	private int shopStatus; // 상점상태
	private int shopVisitcnt; // 상점 방문자 수
	private Timestamp shopRegDate; // 상점 개설일시
	private int shopOpeningDate; // 상점 오픈일
	private int shopSalesCount; // 판매완료 수
	
	// 해당 상점 판매등급
	private int memberSgrade;
	
	public ShopDTO() { }

	public ShopDTO(int shopNo, int memberNo, String shopName, String shopIntroduction, int shopStatus, int shopVisitcnt,
			Timestamp shopRegDate, int shopOpeningDate, int shopSalesCount, int memberSgrade) {
		this.shopNo = shopNo;
		this.memberNo = memberNo;
		this.shopName = shopName;
		this.shopIntroduction = shopIntroduction;
		this.shopStatus = shopStatus;
		this.shopVisitcnt = shopVisitcnt;
		this.shopRegDate = shopRegDate;
		this.shopOpeningDate = shopOpeningDate;
		this.shopSalesCount = shopSalesCount;
		this.memberSgrade = memberSgrade;
	}

	public int getShopNo() {
		return shopNo;
	}

	public void setShopNo(int shopNo) {
		this.shopNo = shopNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getShopIntroduction() {
		return shopIntroduction;
	}

	public void setShopIntroduction(String shopIntroduction) {
		this.shopIntroduction = shopIntroduction;
	}

	public int getShopStatus() {
		return shopStatus;
	}

	public void setShopStatus(int shopStatus) {
		this.shopStatus = shopStatus;
	}

	public int getShopVisitcnt() {
		return shopVisitcnt;
	}

	public void setShopVisitcnt(int shopVisitcnt) {
		this.shopVisitcnt = shopVisitcnt;
	}

	public Timestamp getShopRegDate() {
		return shopRegDate;
	}

	public void setShopRegDate(Timestamp shopRegDate) {
		this.shopRegDate = shopRegDate;
	}

	public int getShopOpeningDate() {
		return shopOpeningDate;
	}

	public void setShopOpeningDate(int shopOpeningDate) {
		this.shopOpeningDate = shopOpeningDate;
	}

	public int getShopSalesCount() {
		return shopSalesCount;
	}

	public void setShopSalesCount(int shopSalesCount) {
		this.shopSalesCount = shopSalesCount;
	}

	public int getMemberSgrade() {
		return memberSgrade;
	}

	public void setMemberSgrade(int memberSgrade) {
		this.memberSgrade = memberSgrade;
	}

}
