package com.web.TBP.beans;

public class CartDTO {
	
	private int cartNo;
	private int productNo;
	private int memberNo;
	private int shopNo;
	private String shopName;
	private String productThumb;
	private String productSubject;
	private int productPrice;
	private int productStock;
	private int cartStock;
	
	public CartDTO() { }

	public CartDTO(int cartNo, int productNo, int memberNo, int shopNo, String shopName, String productThumb,
			String productSubject, int productPrice, int productStock, int cartStock) {
		this.cartNo = cartNo;
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.shopNo = shopNo;
		this.shopName = shopName;
		this.productThumb = productThumb;
		this.productSubject = productSubject;
		this.productPrice = productPrice;
		this.productStock = productStock;
		this.cartStock = cartStock;
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
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

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductStock() {
		return productStock;
	}

	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}

	public int getCartStock() {
		return cartStock;
	}

	public void setCartStock(int cartStock) {
		this.cartStock = cartStock;
	}
	
}
