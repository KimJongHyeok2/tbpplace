package com.web.TBP.beans;

import java.util.Arrays;
import java.util.List;

public class ProductOrderDTO {

	private int[] productNo;
	private int[] orderNumber;
	private int[] cartNo;
	private List<ProductDTO> list;
	private int memberNo;
	private String orderName;
	private String orderAddr;
	private String orderTel;
	private int orderTotalPrice;
	
	public ProductOrderDTO() { }

	public ProductOrderDTO(int[] productNo, int[] orderNumber, int[] cartNo, List<ProductDTO> list, int memberNo,
			String orderName, String orderAddr, String orderTel, int orderTotalPrice) {
		this.productNo = productNo;
		this.orderNumber = orderNumber;
		this.cartNo = cartNo;
		this.list = list;
		this.memberNo = memberNo;
		this.orderName = orderName;
		this.orderAddr = orderAddr;
		this.orderTel = orderTel;
		this.orderTotalPrice = orderTotalPrice;
	}

	public int[] getProductNo() {
		return productNo;
	}

	public void setProductNo(int[] productNo) {
		this.productNo = productNo;
	}

	public int[] getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(int[] orderNumber) {
		this.orderNumber = orderNumber;
	}

	public int[] getCartNo() {
		return cartNo;
	}

	public void setCartNo(int[] cartNo) {
		this.cartNo = cartNo;
	}

	public List<ProductDTO> getList() {
		return list;
	}

	public void setList(List<ProductDTO> list) {
		this.list = list;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getOrderAddr() {
		return orderAddr;
	}

	public void setOrderAddr(String orderAddr) {
		this.orderAddr = orderAddr;
	}

	public String getOrderTel() {
		return orderTel;
	}

	public void setOrderTel(String orderTel) {
		this.orderTel = orderTel;
	}

	public int getOrderTotalPrice() {
		return orderTotalPrice;
	}

	public void setOrderTotalPrice(int orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
	}
	
}