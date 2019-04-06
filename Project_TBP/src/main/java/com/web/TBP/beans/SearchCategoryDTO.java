package com.web.TBP.beans;

public class SearchCategoryDTO {
	
	private String categoryName;
	private int categoryId;
	private int categoryCount;
	private String searchValue;
	
	public SearchCategoryDTO() { }
	
	public SearchCategoryDTO(String categoryName, int categoryId, int categoryCount, String searchValue) {
		this.categoryName = categoryName;
		this.categoryId = categoryId;
		this.categoryCount = categoryCount;
		this.searchValue = searchValue;
	}

	public String getCategoryName() {
		return categoryName;
	}
	
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	public int getCategoryId() {
		return categoryId;
	}
	
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	public int getCategoryCount() {
		return categoryCount;
	}
	
	public void setCategoryCount(int categoryCount) {
		this.categoryCount = categoryCount;
	}
	
	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

}
