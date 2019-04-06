package com.web.TBP.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.web.TBP.constant.C;
import com.web.TBP.dao.MyPageDAO;

public class MyGradeInfoCommand extends Command {

	@Override
	public void execute2(Model model, HttpServletRequest request) {
		MyPageDAO dao = C.sqlSession.getMapper(MyPageDAO.class);
		
		int memberNo = (int)request.getSession().getAttribute("memberNo");
		
		int bGradeMoney = (dao.checkBGrade2(memberNo)==null? 0:dao.checkBGrade2(memberNo));
		int sGradeMoney = (dao.checkSGrade2(memberNo)==null? 0:dao.checkSGrade2(memberNo));
		
		model.addAttribute("bGradeMoney", bGradeMoney);
		model.addAttribute("sGradeMoney", sGradeMoney);
		model.addAttribute("memberName", request.getSession().getAttribute("memberName"));
		model.addAttribute("memberBgrade", request.getSession().getAttribute("memberBgrade"));
		model.addAttribute("memberSgrade", request.getSession().getAttribute("memberSgrade"));
	}
	
}
