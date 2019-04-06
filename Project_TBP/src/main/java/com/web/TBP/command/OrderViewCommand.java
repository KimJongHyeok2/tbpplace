package com.web.TBP.command;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.DeliveryDTO;
import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.ProductOrderDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.OrderDAO;

public class OrderViewCommand extends Command {
	
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		ProductOrderDTO dto = (ProductOrderDTO)map.get("dto");
		OrderDAO dao = C.sqlSession.getMapper(OrderDAO.class);

		int productNo[] = dto.getProductNo();
		int orderNumber[] = dto.getOrderNumber();
		
/*		for(int i=0; i<productNo.length; i++) {
			if(i==productNo.length-1) {
				break;
			}
			if(productNo[i] == productNo[i+1]) {
				orderNumber[i] += orderNumber[i+1];
			}
		}*/
		
/*		dto.setList(dao.orderProduct(productNo));*/
		
		dto.setList(new ArrayList<ProductDTO>());
		for(int i=0; i<productNo.length; i++) {
			dto.getList().add(dao.orderProduct(productNo[i]));
		}
		
		if(productNo.length == orderNumber.length) {
			for(int i=0; i<dto.getList().size(); i++) {
				for(int j=0; j<productNo.length; j++) {
					if(dto.getList().get(i).getProductNo() == productNo[j]) {
						dto.getList().get(i).setOrderNumber(orderNumber[i]);
					}	
				}
			}	
		}
		
		DeliveryDTO delibery = dao.myDelivery(dto.getMemberNo());
		
		model.addAttribute("myDelivery", delibery);
		model.addAttribute("productOrderDto", dto);
	}
	
}