package com.web.TBP;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.TBP.command.ShopShowCommand;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@RequestMapping("/{memberNo}")
	public String shop(@PathVariable int memberNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		model.addAttribute("memberNo", memberNo);
		new ShopShowCommand().execute4(model, request, response);
		
		return "shop/myShop";
	}
	
}