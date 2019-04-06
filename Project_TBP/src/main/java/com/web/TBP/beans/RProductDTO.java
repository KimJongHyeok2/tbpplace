package com.web.TBP.beans;

import java.util.List;

public class RProductDTO {
	
	private List<ProductDTO> list;
	private int myProductCount;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public RProductDTO() { }

	public RProductDTO(List<ProductDTO> list, int myProductCount, int count, String status) {
		this.list = list;
		this.myProductCount = myProductCount;
		this.count = count;
		this.status = status;
	}

	public List<ProductDTO> getList() {
		return list;
	}
	
	public void setList(List<ProductDTO> list) {
		this.list = list;
	}
	
	public int getMyProductCount() {
		return myProductCount;
	}

	public void setMyProductCount(int myProductCount) {
		this.myProductCount = myProductCount;
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
