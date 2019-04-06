package com.web.TBP.beans;

import java.util.List;

public class RCategoryDTO {

	private List<CategoryDTO> list;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public RCategoryDTO() { }
	
	public RCategoryDTO(List<CategoryDTO> list, int count, String status) {
		this.list = list;
		this.count = count;
		this.status = status;
	}

	public List<CategoryDTO> getList() {
		return list;
	}
	
	public void setList(List<CategoryDTO> list) {
		this.list = list;
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
