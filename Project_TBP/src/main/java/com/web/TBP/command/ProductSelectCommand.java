package com.web.TBP.command;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.ProductImagesDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.MyPageDAO;

public class ProductSelectCommand extends Command {

	@Override
	public void execute(Model model) {
	
		Map<String, Object> map = model.asMap();
		int productNo = (Integer)map.get("productNo");
		
		MyPageDAO dao = C.sqlSession.getMapper(MyPageDAO.class);
		ProductDTO dto = dao.selectProduct(productNo);
		List<ProductImagesDTO> dtoImgs = dao.selectProductImages(productNo);
		
		if(dto != null) {
			model.addAttribute("productDto", dto);
			model.addAttribute("productImagesDto", dtoImgs);
		}
		
	}
	
}