package com.web.TBP;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.web.TBP.beans.ProductOrderDTO;
import com.web.TBP.command.OrderPaymentCommand;
import com.web.TBP.command.OrderViewCommand;
import com.web.TBP.command.ProductViewCommand;

@Controller
@RequestMapping("/product")
public class ProductController {

	@RequestMapping("/{productNo}")
	public String productView(@PathVariable Integer productNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		model.addAttribute("productNo", productNo);
		new ProductViewCommand().execute4(model, request, response);
		
		return "product/productView";
	}
	
	@RequestMapping("/jusoPopup")
	public String jusoPopup() {
		return "product/jusoPopup";
	}
	
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public String productOrder(ProductOrderDTO dto, Model model) {

		model.addAttribute("dto", dto);
		new OrderViewCommand().execute(model);
		
		return "product/productOrder";
	}
	
	@RequestMapping(value = "/orderPayment", method = RequestMethod.POST)
	public String productOrderOk(ProductOrderDTO dto, Model model, HttpServletRequest request) {
		
		model.addAttribute("dto", dto);
		new OrderPaymentCommand().execute2(model, request);
		
		return "product/productOrderOk";
	}
	
}