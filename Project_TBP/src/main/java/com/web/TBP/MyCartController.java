package com.web.TBP;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.TBP.command.MyCartListCommand;

@Controller
@RequestMapping("/myCart")
public class MyCartController {

	@RequestMapping("")
	public String myCart(Model model, HttpServletRequest request) {
		
		new MyCartListCommand().execute2(model, request);
		
		return "cart/myCart";
	}
	
}