package com.web.TBP.beans;

public class CategoryDTO {
	
	private int categoryId; // 상품 카테고리
	private String categoryName;
	private int categoryDepth;
	private int categoryParent;
	private int salesWayId; // 거래방식
	private	String salesWayName;
	private int productStateId; // 상품상태
	private String productStateName;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public CategoryDTO() { }

	public CategoryDTO(int categoryId, String categoryName, int categoryDepth, int categoryParent, int salesWayId,
			String salesWayName, int productStateId, String productStateName, int count, String status) {
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.categoryDepth = categoryDepth;
		this.categoryParent = categoryParent;
		this.salesWayId = salesWayId;
		this.salesWayName = salesWayName;
		this.productStateId = productStateId;
		this.productStateName = productStateName;
		this.count = count;
		this.status = status;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getCategoryDepth() {
		return categoryDepth;
	}

	public void setCategoryDepth(int categoryDepth) {
		this.categoryDepth = categoryDepth;
	}

	public int getCategoryParent() {
		return categoryParent;
	}

	public void setCategoryParent(int categoryParent) {
		this.categoryParent = categoryParent;
	}

	public int getSalesWayId() {
		return salesWayId;
	}

	public void setSalesWayId(int salesWayId) {
		this.salesWayId = salesWayId;
	}

	public String getSalesWayName() {
		return salesWayName;
	}

	public void setSalesWayName(String salesWayName) {
		this.salesWayName = salesWayName;
	}

	public int getProductStateId() {
		return productStateId;
	}

	public void setProductStateId(int productStateId) {
		this.productStateId = productStateId;
	}

	public String getProductStateName() {
		return productStateName;
	}

	public void setProductStateName(String productStateName) {
		this.productStateName = productStateName;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}