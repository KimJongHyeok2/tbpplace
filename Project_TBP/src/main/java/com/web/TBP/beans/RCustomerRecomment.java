package com.web.TBP.beans;

import java.util.List;

public class RCustomerRecomment {
	
	List<CustomerRecomment> list;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public RCustomerRecomment() { }
	
	public RCustomerRecomment(List<CustomerRecomment> list, int count, String status) {
		this.list = list;
		this.count = count;
		this.status = status;
	}

	public List<CustomerRecomment> getList() {
		return list;
	}

	public void setList(List<CustomerRecomment> list) {
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
