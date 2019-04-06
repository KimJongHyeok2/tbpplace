package com.web.TBP.beans;

import java.sql.Timestamp;

public class AllNoticeDTO {

	private int allNoticeNo;
	private String allNoticeSubject;
	private String allNoticeContent;
	private int allNoticeType;
	private Timestamp allNoticeRegDate;
	
	public AllNoticeDTO() { }
	
	public AllNoticeDTO(int allNoticeNo, String allNoticeSubject, String allNoticeContent, int allNoticeType,
			Timestamp allNoticeRegDate) {
		this.allNoticeNo = allNoticeNo;
		this.allNoticeSubject = allNoticeSubject;
		this.allNoticeContent = allNoticeContent;
		this.allNoticeType = allNoticeType;
		this.allNoticeRegDate = allNoticeRegDate;
	}

	public int getAllNoticeNo() {
		return allNoticeNo;
	}
	
	public void setAllNoticeNo(int allNoticeNo) {
		this.allNoticeNo = allNoticeNo;
	}
	
	public String getAllNoticeSubject() {
		return allNoticeSubject;
	}
	
	public void setAllNoticeSubject(String allNoticeSubject) {
		this.allNoticeSubject = allNoticeSubject;
	}
	
	public String getAllNoticeContent() {
		return allNoticeContent;
	}
	
	public void setAllNoticeContent(String allNoticeContent) {
		this.allNoticeContent = allNoticeContent;
	}
	
	public int getAllNoticeType() {
		return allNoticeType;
	}
	
	public void setAllNoticeType(int allNoticeType) {
		this.allNoticeType = allNoticeType;
	}
	
	public Timestamp getAllNoticeRegDate() {
		return allNoticeRegDate;
	}
	
	public void setAllNoticeRegDate(Timestamp allNoticeRegDate) {
		this.allNoticeRegDate = allNoticeRegDate;
	}

}
