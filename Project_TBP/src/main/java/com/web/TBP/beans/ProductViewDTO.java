package com.web.TBP.beans;

import java.util.List;

public class ProductViewDTO {

	private List<CategoryDTO> depth1;
	private List<CategoryDTO> depth2;
	private List<CategoryDTO> depth3;
	private String currDepth1;
	private String currDepth2;
	private String currDepth3;
	private ProductDTO productView;
	private List<ProductImagesDTO> productImages;
	private ShopDTO shop;
	private List<ProductDTO> shopProducts;
	private int memberSgrade;
	
	public ProductViewDTO() { }

	public ProductViewDTO(List<CategoryDTO> depth1, List<CategoryDTO> depth2, List<CategoryDTO> depth3,
			String currDepth1, String currDepth2, String currDepth3, ProductDTO productView,
			List<ProductImagesDTO> productImages, ShopDTO shop, List<ProductDTO> shopProducts, int memberSgrade) {
		this.depth1 = depth1;
		this.depth2 = depth2;
		this.depth3 = depth3;
		this.currDepth1 = currDepth1;
		this.currDepth2 = currDepth2;
		this.currDepth3 = currDepth3;
		this.productView = productView;
		this.productImages = productImages;
		this.shop = shop;
		this.shopProducts = shopProducts;
		this.memberSgrade = memberSgrade;
	}

	public List<CategoryDTO> getDepth1() {
		return depth1;
	}

	public void setDepth1(List<CategoryDTO> depth1) {
		this.depth1 = depth1;
	}

	public List<CategoryDTO> getDepth2() {
		return depth2;
	}

	public void setDepth2(List<CategoryDTO> depth2) {
		this.depth2 = depth2;
	}

	public List<CategoryDTO> getDepth3() {
		return depth3;
	}

	public void setDepth3(List<CategoryDTO> depth3) {
		this.depth3 = depth3;
	}

	public String getCurrDepth1() {
		return currDepth1;
	}

	public void setCurrDepth1(String currDepth1) {
		this.currDepth1 = currDepth1;
	}

	public String getCurrDepth2() {
		return currDepth2;
	}

	public void setCurrDepth2(String currDepth2) {
		this.currDepth2 = currDepth2;
	}

	public String getCurrDepth3() {
		return currDepth3;
	}

	public void setCurrDepth3(String currDepth3) {
		this.currDepth3 = currDepth3;
	}

	public ProductDTO getProductView() {
		return productView;
	}

	public void setProductView(ProductDTO productView) {
		this.productView = productView;
	}

	public List<ProductImagesDTO> getProductImages() {
		return productImages;
	}

	public void setProductImages(List<ProductImagesDTO> productImages) {
		this.productImages = productImages;
	}

	public ShopDTO getShop() {
		return shop;
	}

	public void setShop(ShopDTO shop) {
		this.shop = shop;
	}

	public List<ProductDTO> getShopProducts() {
		return shopProducts;
	}

	public void setShopProducts(List<ProductDTO> shopProducts) {
		this.shopProducts = shopProducts;
	}

	public int getMemberSgrade() {
		return memberSgrade;
	}

	public void setMemberSgrade(int memberSgrade) {
		this.memberSgrade = memberSgrade;
	}

}