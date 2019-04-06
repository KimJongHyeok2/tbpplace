package com.web.TBP.beans;

import java.util.List;

public class RQuestionRecommentDTO {
	
	private List<QuestionRecommentDTO> list;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public RQuestionRecommentDTO() { }
	
	public RQuestionRecommentDTO(List<QuestionRecommentDTO> list, int count, String status) {
		this.list = list;
		this.count = count;
		this.status = status;
	}

	public List<QuestionRecommentDTO> getList() {
		return list;
	}
	public void setList(List<QuestionRecommentDTO> list) {
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
