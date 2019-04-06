package com.web.TBP.beans;

import java.sql.Timestamp;

public class QuestionRecommentDTO {
	
	private int qRecommentNo;
	private int questionNo;
	private int productNo;
	private int memberNo;
	private String qRecommentContent;
	private Timestamp qRecommentRegDate;
	
	public QuestionRecommentDTO() { }

	public QuestionRecommentDTO(int qRecommentNo, int questionNo, int productNo, int memberNo, String qRecommentContent,
			Timestamp qRecommentRegDate) {
		this.qRecommentNo = qRecommentNo;
		this.questionNo = questionNo;
		this.productNo = productNo;
		this.memberNo = memberNo;
		this.qRecommentContent = qRecommentContent;
		this.qRecommentRegDate = qRecommentRegDate;
	}

	public int getqRecommentNo() {
		return qRecommentNo;
	}

	public void setqRecommentNo(int qRecommentNo) {
		this.qRecommentNo = qRecommentNo;
	}

	public int getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getqRecommentContent() {
		return qRecommentContent;
	}

	public void setqRecommentContent(String qRecommentContent) {
		this.qRecommentContent = qRecommentContent;
	}

	public Timestamp getqRecommentRegDate() {
		return qRecommentRegDate;
	}

	public void setqRecommentRegDate(Timestamp qRecommentRegDate) {
		this.qRecommentRegDate = qRecommentRegDate;
	}

	@Override
	public String toString() {
		return "QuestionRecommentDTO [qRecommentNo=" + qRecommentNo + ", questionNo=" + questionNo + ", productNo="
				+ productNo + ", memberNo=" + memberNo + ", qRecommentContent=" + qRecommentContent
				+ ", qRecommentRegDate=" + qRecommentRegDate + "]";
	}

}
