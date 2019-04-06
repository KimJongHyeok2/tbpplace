package com.web.TBP.beans;

public class ProductImagesDTO {
	
	private int productImgNo;
	private int productNo;
	private String productImgOriginalName;
	private String productImgFileSystemName;
	
	public ProductImagesDTO() { }
	
	public ProductImagesDTO(int productImgNo, int productNo, String productImgOriginalName,
			String productImgFileSystemName) {
		this.productImgNo = productImgNo;
		this.productNo = productNo;
		this.productImgOriginalName = productImgOriginalName;
		this.productImgFileSystemName = productImgFileSystemName;
	}
	
	public int getProductImgNo() {
		return productImgNo;
	}
	
	public void setProductImgNo(int productImgNo) {
		this.productImgNo = productImgNo;
	}
	
	public int getProductNo() {
		return productNo;
	}
	
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	
	public String getProductImgOriginalName() {
		return productImgOriginalName;
	}
	
	public void setProductImgOriginalName(String productImgOriginalName) {
		this.productImgOriginalName = productImgOriginalName;
	}
	
	public String getProductImgFileSystemName() {
		return productImgFileSystemName;
	}
	
	public void setProductImgFileSystemName(String productImgFileSystemName) {
		this.productImgFileSystemName = productImgFileSystemName;
	}
	
}
