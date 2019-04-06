package com.web.TBP.command;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.web.TBP.beans.OrderDTO;
import com.web.TBP.beans.ProductOrderDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.OrderDAO;

public class OrderPaymentCommand extends Command {

	@Override
	public void execute2(Model model, HttpServletRequest request) {
		Map<String, Object> map = model.asMap();
		ProductOrderDTO dto = (ProductOrderDTO)map.get("dto");
		OrderDAO dao = C.sqlSession.getMapper(OrderDAO.class);
		
		int count = 0;
		int memberMoney = dao.checkMemberMoney(dto.getMemberNo());
		if(dto != null) {
			if(!(memberMoney >= dto.getOrderTotalPrice())) {
				model.addAttribute("status", "moneyShortage");
				return;
			}
			int allStock = 0;
			Set<Integer> stockSum = new HashSet<Integer>();
			
			for(int i=0; i<dto.getProductNo().length; i++) {
				stockSum.add(dto.getProductNo()[i]);
			}
			
			for(Integer productNo : stockSum) {
				allStock = 0;
				for(int i=0; i<dto.getProductNo().length; i++) {
					if(productNo == dto.getProductNo()[i]) {
						allStock += dto.getOrderNumber()[i];
					}
				}
				int checkStock = dao.checkProductStock(productNo);
				if(checkStock < allStock) {
					model.addAttribute("status", "stockChange");
					return;
				}
			}
			
			for(int i=0; i<dto.getProductNo().length; i++) {
				int checkStock = dao.checkProductStock(dto.getProductNo()[i]);
				if(checkStock < dto.getOrderNumber()[i]) {
					model.addAttribute("status", "stockChange");
					return;
				}
			}
			for(int i=0; i<dto.getProductNo().length; i++) {
				OrderDTO orderDto = new OrderDTO();
				orderDto.setMemberNo(dto.getMemberNo());
				orderDto.setProductNo(dto.getProductNo()[i]);
				orderDto.setOrderName(dto.getOrderName());
				int salesWayId = dao.checkSalesWay(dto.getProductNo()[i]);
				if(salesWayId == 2) {					
					orderDto.setOrderAddr(dto.getOrderAddr());
				}
				orderDto.setOrderStock(dto.getOrderNumber()[i]);
				orderDto.setOrderTel(dto.getOrderTel());
				count += dao.orderInsert(orderDto);
			}
			if((count/2) == dto.getProductNo().length) {
				int stockUpdateCount = 0;
				int moneyUpdateCount = 0;
				for(int i=0; i<dto.getProductNo().length; i++) {					
					stockUpdateCount += dao.productStockUpdate(dto.getOrderNumber()[i], dto.getProductNo()[i]);
				}
				if(stockUpdateCount == dto.getProductNo().length) {					
					moneyUpdateCount = dao.memberMoneyUpdate(dto.getOrderTotalPrice(), dto.getMemberNo());
					int selectUpdateMoney = dao.selectMyMoney(dto.getMemberNo());
					request.getSession().setAttribute("memberMoney", selectUpdateMoney);
				}
				if(moneyUpdateCount == 1) {
					model.addAttribute("status", "paymentSuccess");
					if(dto.getCartNo() != null && dto.getCartNo().length != 0) {	
						dao.deleteCart(dto.getCartNo());
					}
				} else {
					model.addAttribute("status", "paymentFail");					
				}
			}
		}
		
	}
	
}