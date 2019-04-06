package com.web.TBP.beans;

import java.sql.Timestamp;

public class NoticeDTO {
	
	private int noticeNo;
	private int memberNo;
	private int productNo;
	private int noticeWay;
	private int noticeStatus;
	private Timestamp noticeRegDate;
	
	public NoticeDTO() { }
	
	public NoticeDTO(int noticeNo, int memberNo, int productNo, int noticeWay, int noticeStatus,
			Timestamp noticeRegDate) {
		this.noticeNo = noticeNo;
		this.memberNo = memberNo;
		this.productNo = productNo;
		this.noticeWay = noticeWay;
		this.noticeStatus = noticeStatus;
		this.noticeRegDate = noticeRegDate;
	}
	
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getNoticeWay() {
		return noticeWay;
	}
	public void setNoticeWay(int noticeWay) {
		this.noticeWay = noticeWay;
	}
	public int getNoticeStatus() {
		return noticeStatus;
	}
	public void setNoticeStatus(int noticeStatus) {
		this.noticeStatus = noticeStatus;
	}
	public Timestamp getNoticeRegDate() {
		return noticeRegDate;
	}
	public void setNoticeRegDate(Timestamp noticeRegDate) {
		this.noticeRegDate = noticeRegDate;
	}
	
}
