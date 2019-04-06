package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.ProductDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.ProductDAO;

public class MerchandiseListCommand extends Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		
		int memberNo = (Integer)map.get("memberNo");
		int page = (Integer)map.get("page");
		int allRow = (Integer)map.get("allRow");
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		int productCount = dao.selectProdcutCount(memberNo);
		
		productCount = productCount%allRow==0? productCount/allRow:(productCount/allRow)+1;
		List<ProductDTO> dto = dao.selectProduct(memberNo, (page-1)*allRow+1, allRow);
		
		if(dto != null && dto.size() != 0) {
			model.addAttribute("productList", dto);
			model.addAttribute("page", page);
			model.addAttribute("productCount", productCount);
		}
	}

}