package com.web.TBP.beans;

import java.sql.Timestamp;

public class CustomerRecomment {
	
	private int cRecommentNo;
	private int cQuestionNo;
	private String cRecommentContent;
	private Timestamp cRecommentRegDate;
	
	public CustomerRecomment() { }
	
	public CustomerRecomment(int cRecommentNo, int cQuestionNo, String cRecommentContent, Timestamp cRecommentRegDate) {
		this.cRecommentNo = cRecommentNo;
		this.cQuestionNo = cQuestionNo;
		this.cRecommentContent = cRecommentContent;
		this.cRecommentRegDate = cRecommentRegDate;
	}
	
	public int getcRecommentNo() {
		return cRecommentNo;
	}
	
	public void setcRecommentNo(int cRecommentNo) {
		this.cRecommentNo = cRecommentNo;
	}
	
	public int getcQuestionNo() {
		return cQuestionNo;
	}
	
	public void setcQuestionNo(int cQuestionNo) {
		this.cQuestionNo = cQuestionNo;
	}
	
	public String getcRecommentContent() {
		return cRecommentContent;
	}
	
	public void setcRecommentContent(String cRecommentContent) {
		this.cRecommentContent = cRecommentContent;
	}
	
	public Timestamp getcRecommentRegDate() {
		return cRecommentRegDate;
	}
	
	public void setcRecommentRegDate(Timestamp cRecommentRegDate) {
		this.cRecommentRegDate = cRecommentRegDate;
	}
	
}
