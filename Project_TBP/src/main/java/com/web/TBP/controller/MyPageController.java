package com.web.TBP.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.TBP.command.MerchandiseListCommand;
import com.web.TBP.command.MyGradeInfoCommand;
import com.web.TBP.command.ProductSelectCommand;
import com.web.TBP.command.PurchaseDetailsListCommand;
import com.web.TBP.command.SalesDetailListCommand;

@Controller
@RequestMapping("/myPage")
public class MyPageController {
	
	// 마이페이지
	@RequestMapping(value = "")
	public String myPageMain(String pageType, Integer time, Integer page, Integer allRow, Model model, HttpServletRequest request) {
		
		if(pageType == null || pageType.equals("purchases")) {
			if(time == null) {
				time = 7;
			}
			if(page == null) {
				page = 1;
			}
			allRow = 10;
			model.addAttribute("time", time);
			model.addAttribute("page", page);
			model.addAttribute("allRow", allRow);
			new PurchaseDetailsListCommand().execute2(model, request);
		} else if(pageType.equals("myGrade")) {
			new MyGradeInfoCommand().execute2(model, request);
		}
		
		return "myPage/myPage";
	}
	
	// 마이페이지 - 판매관리
	@RequestMapping(value = "/salesManagement")
	public String salesManagement(String pageType, Integer memberNo, Integer productNo, Integer page, Integer allRow, Model model) {
		if(pageType == null) {
			return "myPage/salesManagement/salesManagement";
		}
		if(page == null) {
			page = 1;
		}
		if(pageType.equals("merchandiseControl")) {
			if(memberNo == null) {
				return "myPage/salesManagement/salesManagement";				
			}
			allRow = 8;
			model.addAttribute("memberNo", memberNo);
			model.addAttribute("page", page);
			model.addAttribute("allRow", allRow);
			new MerchandiseListCommand().execute(model);
		} else if(pageType.equals("salesControl")) {
			if(memberNo == null) {
				return "myPage/salesManagement/salesManagement";				
			}
			allRow = 6;
			model.addAttribute("memberNo", memberNo);
			model.addAttribute("page", page);
			model.addAttribute("allRow", allRow);
			new SalesDetailListCommand().execute(model);
		} else if(pageType.equals("salesUpdate")) {
			model.addAttribute("productNo", productNo);
			new ProductSelectCommand().execute(model);
		}
		return "myPage/salesManagement/salesManagement";	
	}
	
	// 주소API
	@RequestMapping(value = "/salesManagement/jusoPopup")
	public String jusoPopup() {
		return "myPage/salesManagement/jusoPopup";		
	}
	
}