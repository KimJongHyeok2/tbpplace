package com.web.TBP.beans;

import java.util.List;

public class RTalkMessageDTO {

	private List<TalkMessageDTO> list;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값
	
	public RTalkMessageDTO() { }

	public RTalkMessageDTO(List<TalkMessageDTO> list, int count, String status) {
		this.list = list;
		this.count = count;
		this.status = status;
	}
	
	public List<TalkMessageDTO> getList() {
		return list;
	}
	
	public void setList(List<TalkMessageDTO> list) {
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
