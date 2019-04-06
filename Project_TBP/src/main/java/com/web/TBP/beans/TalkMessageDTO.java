package com.web.TBP.beans;

import java.sql.Timestamp;

public class TalkMessageDTO {

	private int tbptalkNo;
	private int memberNo;
	private int tbptalkViewcnt;
	private String tbptalkContent;
	private Timestamp tbptalkRegDate;
	
	public TalkMessageDTO() { }

	public TalkMessageDTO(int tbptalkNo, int memberNo, int tbptalkViewcnt, String tbptalkContent,
			Timestamp tbptalkRegDate) {
		this.tbptalkNo = tbptalkNo;
		this.memberNo = memberNo;
		this.tbptalkViewcnt = tbptalkViewcnt;
		this.tbptalkContent = tbptalkContent;
		this.tbptalkRegDate = tbptalkRegDate;
	}

	public int getTbptalkNo() {
		return tbptalkNo;
	}

	public void setTbptalkNo(int tbptalkNo) {
		this.tbptalkNo = tbptalkNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getTbptalkViewcnt() {
		return tbptalkViewcnt;
	}

	public void setTbptalkViewcnt(int tbptalkViewcnt) {
		this.tbptalkViewcnt = tbptalkViewcnt;
	}

	public String getTbptalkContent() {
		return tbptalkContent;
	}

	public void setTbptalkContent(String tbptalkContent) {
		this.tbptalkContent = tbptalkContent;
	}

	public Timestamp getTbptalkRegDate() {
		return tbptalkRegDate;
	}

	public void setTbptalkRegDate(Timestamp tbptalkRegDate) {
		this.tbptalkRegDate = tbptalkRegDate;
	}
	
}
