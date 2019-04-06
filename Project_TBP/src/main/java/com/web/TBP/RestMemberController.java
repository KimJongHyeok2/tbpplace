package com.web.TBP;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.MemberDTO;
import com.web.TBP.beans.ShopDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.MemberDAO;

@RestController
@RequestMapping("/member")
public class RestMemberController {
	
	// 회원가입
	@RequestMapping("/insert")
	public String insert(MemberDTO dto, Model model) {
		
		MemberDAO dao = C.sqlSession.getMapper(MemberDAO.class);
		int count = dao.insertMember(dto);
		
		if(count > 1) {
			dto.setCount(count);
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto.getStatus();
	}
	
	@RequestMapping("/idOverlap")
	public String idOverlap(String id) {
		
		MemberDAO dao = C.sqlSession.getMapper(MemberDAO.class);
		String idCheck = dao.idOverlap(id);
		
		if(idCheck == null) {
			return "Ok";
		}
		
		return "Fail";
	}
	
	// 로그인
	@RequestMapping("/loginOk")
	public String login(String id, String pw, HttpServletRequest request) throws IOException {
		MemberDAO dao = C.sqlSession.getMapper(MemberDAO.class);
		MemberDTO dto = dao.loginMember(id, pw);
		String urlTemp = null;
		ShopDTO dto2 = null;
		
		if(dto != null) {
			dto2 = dao.loginShop(dto.getMemberNo());
			dto.setStatus("Ok");
			urlTemp = (String)request.getSession().getAttribute("urlTemp");
			request.getSession().removeAttribute("urlTemp");
			request.getSession().setAttribute("loginCheck", dto.getStatus());
			request.getSession().setAttribute("memberNo", dto.getMemberNo());
			request.getSession().setAttribute("memberId", dto.getMemberId());
			request.getSession().setAttribute("memberName", dto.getMemberName());
			request.getSession().setAttribute("memberBgrade", dto.getMemberBgrade());
			request.getSession().setAttribute("memberSgrade", dto.getMemberSgrade());
			request.getSession().setAttribute("memberMoney", dto.getMemberMoney());
			request.getSession().setAttribute("memberStatus", dto.getMemberStatus());			
			request.getSession().setAttribute("shopName", dto2.getShopName());
		}
		
		if(dto == null || dto2 == null) {
			return "Fail";
		}
		
		if(urlTemp != null) {
			if(urlTemp.substring(urlTemp.lastIndexOf("/")+1, urlTemp.length()-5).equals("order")) {
				return request.getContextPath() +  "/product/" + (String)request.getSession().getAttribute("productNo");
			} else if(urlTemp.indexOf("cart/insert") != -1){
				return request.getContextPath() +  "/product/" + (String)request.getSession().getAttribute("productNo");
			} else {				
				return urlTemp;
			}
		}
		
		return dto.getStatus();
	}
	
	// 로그아웃
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		Enumeration enums = request.getSession().getAttributeNames();
		while(enums.hasMoreElements()) {
			String name = enums.nextElement().toString();
			request.getSession().removeAttribute(name);
		}
		
		response.sendRedirect(request.getContextPath() + "/main/memberLogin");
	}
	
	@RequestMapping("/checkInfo")
	public String checkInfo(String memberId, String memberName, String memberPnum, String type) {
		
		MemberDAO dao = C.sqlSession.getMapper(MemberDAO.class);
		
		int count = 0;

		if(type.equals("type-1")) {
			count = dao.checkInfo(memberName, memberPnum);
		} else {
			count = dao.checkInfo2(memberId, memberName, memberPnum);
		}
		
		if(count != 1) {
			return "Fail";
		}

		return "Ok";
	}
	
}