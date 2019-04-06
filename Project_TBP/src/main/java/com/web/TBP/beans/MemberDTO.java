package com.web.TBP.beans;

import java.sql.Date;
import java.sql.Timestamp;

public class MemberDTO {

	private int memberNo; // 고유번호
	private String memberId; // 아이디
	private String memberPw; // 비밀번호
	private String memberName; // 이름
	private Date memberBirth; // 생년월일
	private int memberGender; // 성별
	private String memberPnum; // 전화번호
	private String memberEmail; // 이메일
	private int memberStatus; // 상태
	private int memberBgrade; // 구매등급
	private int memberSgrade; // 판매등급
	private int memberMoney; //소유금액
	private Timestamp memberRegDate; // 가입일자
	private int count; // Insert Count
	private String status; // Insert 성공시 Resoponse 상태 값
	
	public MemberDTO() { }

	public MemberDTO(int memberNo, String memberId, String memberPw, String memberName, Date memberBirth,
			int memberGender, String memberPnum, String memberEmail, int memberStatus, int memberBgrade,
			int memberSgrade, int memberMoney, Timestamp memberRegDate, int count, String status) {
		super();
		this.memberNo = memberNo;
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberName = memberName;
		this.memberBirth = memberBirth;
		this.memberGender = memberGender;
		this.memberPnum = memberPnum;
		this.memberEmail = memberEmail;
		this.memberStatus = memberStatus;
		this.memberBgrade = memberBgrade;
		this.memberSgrade = memberSgrade;
		this.memberMoney = memberMoney;
		this.memberRegDate = memberRegDate;
		this.count = count;
		this.status = status;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	
	public Date getMemberBirth() {
		return memberBirth;
	}

	public void setMemberBirth(Date memberBirth) {
		this.memberBirth = memberBirth;
	}
	
	public int getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(int memberGender) {
		this.memberGender = memberGender;
	}

	public String getMemberPnum() {
		return memberPnum;
	}

	public void setMemberPnum(String memberPnum) {
		this.memberPnum = memberPnum;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public int getMemberStatus() {
		return memberStatus;
	}

	public void setMemberStatus(int memberStatus) {
		this.memberStatus = memberStatus;
	}

	public int getMemberBgrade() {
		return memberBgrade;
	}

	public void setMemberBgrade(int memberBgrade) {
		this.memberBgrade = memberBgrade;
	}

	public int getMemberSgrade() {
		return memberSgrade;
	}

	public void setMemberSgrade(int memberSgrade) {
		this.memberSgrade = memberSgrade;
	}

	public int getMemberMoney() {
		return memberMoney;
	}

	public void setMemberMoney(int memberMoney) {
		this.memberMoney = memberMoney;
	}

	public Timestamp getMemberRegDate() {
		return memberRegDate;
	}

	public void setMemberRegDate(Timestamp memberRegDate) {
		this.memberRegDate = memberRegDate;
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

	public void setStatus(String success) {
		this.status = success;
	}
	
}
