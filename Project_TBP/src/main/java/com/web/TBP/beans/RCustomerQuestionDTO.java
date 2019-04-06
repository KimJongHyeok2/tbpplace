package com.web.TBP.beans;

import java.util.List;

public class RCustomerQuestionDTO {

	List<CustomerQuestionDTO> list;
	private int cQuestionCount;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public RCustomerQuestionDTO() { }
	
	public RCustomerQuestionDTO(List<CustomerQuestionDTO> list, int cQuestionCount, int count, String status) {
		this.list = list;
		this.cQuestionCount = cQuestionCount;
		this.count = count;
		this.status = status;
	}

	public List<CustomerQuestionDTO> getList() {
		return list;
	}

	public void setList(List<CustomerQuestionDTO> list) {
		this.list = list;
	}

	public int getcQuestionCount() {
		return cQuestionCount;
	}

	public void setcQuestionCount(int cQuestionCount) {
		this.cQuestionCount = cQuestionCount;
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
