package com.web.TBP.beans;

import java.sql.Timestamp;

public class OrderCancleDTO {

	private int orderNo;
	private int memberNo;
	private int productNo;
	private String orderName;
	private String productThumb;
	private String orderAddr;
	private int orderStock;
	private int orderStatus;
	private int orderPrice;
	private Timestamp orderRegDate;
	private String orderTel;
	private int orderShopNo;
	private String orderShopName;
	private int sellShopNo;
	private String sellShopName;
	private String sellMemberName;
	private String sellMemberPnum;
	private String productSubject;
	
	public OrderCancleDTO() { }

	public OrderCancleDTO(int orderNo, int memberNo, int productNo, String orderName, String productThumb,
			String orderAddr, int orderStock, int orderStatus, int orderPrice, Timestamp orderRegDate, String orderTel,
			int orderShopNo, String orderShopName, int sellShopNo, String sellShopName, String sellMemberName,
			String sellMemberPnum, String productSubject) {
		this.orderNo = orderNo;
		this.memberNo = memberNo;
		this.productNo = productNo;
		this.orderName = orderName;
		this.productThumb = productThumb;
		this.orderAddr = orderAddr;
		this.orderStock = orderStock;
		this.orderStatus = orderStatus;
		this.orderPrice = orderPrice;
		this.orderRegDate = orderRegDate;
		this.orderTel = orderTel;
		this.orderShopNo = orderShopNo;
		this.orderShopName = orderShopName;
		this.sellShopNo = sellShopNo;
		this.sellShopName = sellShopName;
		this.sellMemberName = sellMemberName;
		this.sellMemberPnum = sellMemberPnum;
		this.productSubject = productSubject;
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

	public int getOrderShopNo() {
		return orderShopNo;
	}

	public void setOrderShopNo(int orderShopNo) {
		this.orderShopNo = orderShopNo;
	}

	public String getOrderShopName() {
		return orderShopName;
	}

	public void setOrderShopName(String orderShopName) {
		this.orderShopName = orderShopName;
	}

	public int getSellShopNo() {
		return sellShopNo;
	}

	public void setSellShopNo(int sellShopNo) {
		this.sellShopNo = sellShopNo;
	}

	public String getSellShopName() {
		return sellShopName;
	}

	public void setSellShopName(String sellShopName) {
		this.sellShopName = sellShopName;
	}

	public String getSellMemberName() {
		return sellMemberName;
	}

	public void setSellMemberName(String sellMemberName) {
		this.sellMemberName = sellMemberName;
	}

	public String getSellMemberPnum() {
		return sellMemberPnum;
	}

	public void setSellMemberPnum(String sellMemberPnum) {
		this.sellMemberPnum = sellMemberPnum;
	}

	public String getProductSubject() {
		return productSubject;
	}

	public void setProductSubject(String productSubject) {
		this.productSubject = productSubject;
	}
	
}