package com.web.TBP.beans;

import java.util.List;

public class RProductQuestionDTO {
	
	private List<ProductQuestionDTO> list;
	private int questionCount;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public RProductQuestionDTO() { }

	public RProductQuestionDTO(List<ProductQuestionDTO> list, int questionCount, int count, String status) {
		this.list = list;
		this.questionCount = questionCount;
		this.count = count;
		this.status = status;
	}

	public List<ProductQuestionDTO> getList() {
		return list;
	}

	public void setList(List<ProductQuestionDTO> list) {
		this.list = list;
	}

	public int getQuestionCount() {
		return questionCount;
	}

	public void setQuestionCount(int questionCount) {
		this.questionCount = questionCount;
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
