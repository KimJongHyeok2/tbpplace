package com.web.TBP.beans;

import java.util.List;

public class ROrderReviewDTO {
	
	List<OrderReviewDTO> list;
	private int reviewCount;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public ROrderReviewDTO() { }
	
	public ROrderReviewDTO(List<OrderReviewDTO> list, int reviewCount, int count, String status) {
		this.list = list;
		this.reviewCount = reviewCount;
		this.count = count;
		this.status = status;
	}

	public List<OrderReviewDTO> getList() {
		return list;
	}

	public void setList(List<OrderReviewDTO> list) {
		this.list = list;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
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
