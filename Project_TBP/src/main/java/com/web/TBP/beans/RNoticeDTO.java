package com.web.TBP.beans;

import java.util.List;

public class RNoticeDTO {

	private List<NoticeDTO> list;
	private int noticeCount;
	private int count; // Select Count
	private String status; // Select 성공시 Resoponse 상태 값

	public RNoticeDTO() { }

	public RNoticeDTO(List<NoticeDTO> list, int noticeCount, int count, String status) {
		this.list = list;
		this.noticeCount = noticeCount;
		this.count = count;
		this.status = status;
	}

	public List<NoticeDTO> getList() {
		return list;
	}

	public void setList(List<NoticeDTO> list) {
		this.list = list;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
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
