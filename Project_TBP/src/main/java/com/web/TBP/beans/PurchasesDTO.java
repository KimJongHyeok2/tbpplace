package com.web.TBP.beans;

import java.sql.Timestamp;

public class PurchasesDTO {
	
	private int orderNo;
	private int memberNo;
	private int productNo;
	private String orderName;
	private String orderSubject;
	private String productThumb;
	private String orderAddr;
	private int orderStock;
	private int orderStatus;
	private int orderPrice;
	private Timestamp orderRegDate;
	private String orderTel;
	private int orderReviewCheck;
	private String productSubject;
	private String productContext;
	private int productStateId;
	private int salesWayId;
	
	public PurchasesDTO() { }
	
	public PurchasesDTO(int orderNo, int memberNo, int productNo, String orderName, String orderSubject,
			String productThumb, String orderAddr, int orderStock, int orderStatus, int orderPrice,
			Timestamp orderRegDate, String orderTel, int orderReviewCheck, String productSubject, String productContext,
			int productStateId, int salesWayId) {
		this.orderNo = orderNo;
		this.memberNo = memberNo;
		this.productNo = productNo;
		this.orderName = orderName;
		this.orderSubject = orderSubject;
		this.productThumb = productThumb;
		this.orderAddr = orderAddr;
		this.orderStock = orderStock;
		this.orderStatus = orderStatus;
		this.orderPrice = orderPrice;
		this.orderRegDate = orderRegDate;
		this.orderTel = orderTel;
		this.orderReviewCheck = orderReviewCheck;
		this.productSubject = productSubject;
		this.productContext = productContext;
		this.productStateId = productStateId;
		this.salesWayId = salesWayId;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getOrderSubject() {
		return orderSubject;
	}

	public void setOrderSubject(String orderSubject) {
		this.orderSubject = orderSubject;
	}

	public String getProductThumb() {
		return productThumb;
	}

	public void setProductThumb(String productThumb) {
		this.productThumb = productThumb;
	}

	public String getOrderAddr() {
		return orderAddr;
	}

	public void setOrderAddr(String orderAddr) {
		this.orderAddr = orderAddr;
	}

	public int getOrderStock() {
		return orderStock;
	}

	public void setOrderStock(int orderStock) {
		this.orderStock = orderStock;
	}

	public int getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	public int getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}

	public Timestamp getOrderRegDate() {
		return orderRegDate;
	}

	public void setOrderRegDate(Timestamp orderRegDate) {
		this.orderRegDate = orderRegDate;
	}

	public String getOrderTel() {
		return orderTel;
	}

	public void setOrderTel(String orderTel) {
		this.orderTel = orderTel;
	}

	public int getOrderReviewCheck() {
		return orderReviewCheck;
	}

	public void setOrderReviewCheck(int orderReviewCheck) {
		this.orderReviewCheck = orderReviewCheck;
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
	
}
