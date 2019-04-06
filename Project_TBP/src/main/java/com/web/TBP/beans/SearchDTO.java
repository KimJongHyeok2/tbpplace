package com.web.TBP.beans;

import java.sql.Timestamp;
import java.util.List;

public class SearchDTO {
	
	private int productNo; // 상품 고유번호
	private int memberNo; // 회원 고유번호
	private String productThumb; // 상품 섬네일
	private String productSubject; // 상품제목
	private String productContext; // 상품내용
	private String productAddr; // 상품주소(직접거래 설정시)
	private int productStateId; // 상품상태 ID
	private int salesWayId; // 거래방식 ID
	private int productPrice; // 상품가격
	private int productScore; // 상품평점
	private int productStock; // 상품재고
	private int productViewcnt; // 상품 조회수
	private Timestamp productRegDate; // 상품 등록일시
	private int productStatus; // 거래 진행여부
	private int categoryId; // 카테고리 Id
	private int shopNo; // 상점 고유번호
	private String shopName; // 상점이름
	
	public SearchDTO() { }

	public SearchDTO(int productNo, int memberNo, String productThumb, String productSubject, String productContext,
			String productAddr, int productStateId, int salesWayId, int productPrice, int productScore,
			int productStock, int productViewcnt, Timestamp productRegDate, int productStatus, int categoryId,
			int shopNo, String shopName) {
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.productThumb = productThumb;
		this.productSubject = productSubject;
		this.productContext = productContext;
		this.productAddr = productAddr;
		this.productStateId = productStateId;
		this.salesWayId = salesWayId;
		this.productPrice = productPrice;
		this.productScore = productScore;
		this.productStock = productStock;
		this.productViewcnt = productViewcnt;
		this.productRegDate = productRegDate;
		this.productStatus = productStatus;
		this.categoryId = categoryId;
		this.shopNo = shopNo;
		this.shopName = shopName;
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

	public String getProductThumb() {
		return productThumb;
	}

	public void setProductThumb(String productThumb) {
		this.productThumb = productThumb;
	}

	public String getProductSubject() {
		return productSubject;
	}

	public void setProductSubject(String productSubject) {
		this.productSubject = productSubject;
	}

	public String getProductContext() {
		return productContext;
	}

	public void setProductContext(String productContext) {
		this.productContext = productContext;
	}

	public String getProductAddr() {
		return productAddr;
	}

	public void setProductAddr(String productAddr) {
		this.productAddr = productAddr;
	}

	public int getProductStateId() {
		return productStateId;
	}

	public void setProductStateId(int productStateId) {
		this.productStateId = productStateId;
	}

	public int getSalesWayId() {
		return salesWayId;
	}

	public void setSalesWayId(int salesWayId) {
		this.salesWayId = salesWayId;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductScore() {
		return productScore;
	}

	public void setProductScore(int productScore) {
		this.productScore = productScore;
	}

	public int getProductStock() {
		return productStock;
	}

	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}

	public int getProductViewcnt() {
		return productViewcnt;
	}

	public void setProductViewcnt(int productViewcnt) {
		this.productViewcnt = productViewcnt;
	}

	public Timestamp getProductRegDate() {
		return productRegDate;
	}

	public void setProductRegDate(Timestamp productRegDate) {
		this.productRegDate = productRegDate;
	}

	public int getProductStatus() {
		return productStatus;
	}

	public void setProductStatus(int productStatus) {
		this.productStatus = productStatus;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
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
