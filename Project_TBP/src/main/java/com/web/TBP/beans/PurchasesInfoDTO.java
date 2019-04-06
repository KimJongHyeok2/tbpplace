package com.web.TBP.beans;

public class PurchasesInfoDTO {
	
	private int shopNo;
	private String shopName;
	private String memberPnum;
	private String productAddr;
	
	public PurchasesInfoDTO() {	}
	
	public PurchasesInfoDTO(int shopNo, String shopName, String memberPnum, String productAddr) {
		this.shopNo = shopNo;
		this.shopName = shopName;
		this.memberPnum = memberPnum;
		this.productAddr = productAddr;
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

	public String getMemberPnum() {
		return memberPnum;
	}

	public void setMemberPnum(String memberPnum) {
		this.memberPnum = memberPnum;
	}

	public String getProductAddr() {
		return productAddr;
	}

	public void setProductAddr(String productAddr) {
		this.productAddr = productAddr;
	}

}
