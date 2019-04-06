package com.web.TBP.beans;

import java.sql.Timestamp;

public class DeliveryDTO {

	private int deliveryNo;
	private int memberNo;
	private String deliveryName;
	private String deliveryAddr;
	private String deliveryTel;
	private Timestamp deliveryRegDate;
	
	public DeliveryDTO() { }
	
	public DeliveryDTO(int deliveryNo, int memberNo, String deliveryName, String deliveryAddr, String deliveryTel,
			Timestamp deliveryRegDate) {
		this.deliveryNo = deliveryNo;
		this.memberNo = memberNo;
		this.deliveryName = deliveryName;
		this.deliveryAddr = deliveryAddr;
		this.deliveryTel = deliveryTel;
		this.deliveryRegDate = deliveryRegDate;
	}

	public int getDeliveryNo() {
		return deliveryNo;
	}
	
	public void setDeliveryNo(int deliveryNo) {
		this.deliveryNo = deliveryNo;
	}
	
	public int getMemberNo() {
		return memberNo;
	}
	
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	
	public String getDeliveryName() {
		return deliveryName;
	}
	
	public void setDeliveryName(String deliveryName) {
		this.deliveryName = deliveryName;
	}
	
	public String getDeliveryAddr() {
		return deliveryAddr;
	}
	
	public void setDeliveryAddr(String deliveryAddr) {
		this.deliveryAddr = deliveryAddr;
	}
	
	public String getDeliveryTel() {
		return deliveryTel;
	}
	
	public void setDeliveryTel(String deliveryTel) {
		this.deliveryTel = deliveryTel;
	}
	
	public Timestamp getDeliveryRegDate() {
		return deliveryRegDate;
	}
	
	public void setDeliveryRegDate(Timestamp deliveryRegDate) {
		this.deliveryRegDate = deliveryRegDate;
	}
	
}
