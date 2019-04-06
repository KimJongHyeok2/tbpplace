package com.web.TBP.command;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.web.TBP.beans.CategoryDTO;
import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.ProductImagesDTO;
import com.web.TBP.beans.ProductViewDTO;
import com.web.TBP.beans.ShopDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.ProductDAO;

public class ProductViewCommand extends Command {

	@Override
	public void execute4(Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = model.asMap();
		
		if((Integer)map.get("productNo") == null) {
			try {
				response.sendRedirect(request.getContextPath() + "/main/index");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return;
		}
		
		int productNo = (Integer)map.get("productNo");
		
		ProductDAO dao = C.sqlSession.getMapper(ProductDAO.class);
		
		boolean productFlag = false;
		
		Cookie[] productCookie = request.getCookies();
		if(productCookie != null) {
			for(int i=0; i<productCookie.length; i++) {
				if(productCookie[i].getName().equals("product" + productNo) && productCookie[i].getValue().equals("1")) {
					productFlag = true;
				}
			}
			if(!productFlag) {
				Cookie visitCheck = new Cookie("product" + productNo, "1");
				visitCheck.setMaxAge(21600);
				response.addCookie(visitCheck);
				dao.productViewCount(productNo);
			}
		}
		
		ProductDTO productView = dao.selectViewProduct(productNo);
		
		if(productView != null) {
			ProductViewDTO dto = new ProductViewDTO();
			dto.setProductView(productView);
			
			List<CategoryDTO> depth3 = dao.depth(productView.getCategoryId());
			for(int i=0; i<depth3.size(); i++) {
				if(depth3.get(i).getCategoryId() == productView.getCategoryId()) {
					dto.setCurrDepth3(depth3.get(i).getCategoryName());
				}
			}
			dto.setDepth3(depth3);
			List<CategoryDTO> depth2 = dao.depth(depth3.get(0).getCategoryParent());
			for(int i=0; i<depth2.size(); i++) {
				if(depth2.get(i).getCategoryId() == depth3.get(0).getCategoryParent()) {
					dto.setCurrDepth2(depth2.get(i).getCategoryName());
				}
			}
			dto.setDepth2(depth2);
			List<CategoryDTO> depth1 = dao.depth(depth2.get(0).getCategoryParent());
			for(int i=0; i<depth1.size(); i++) {
				if(depth1.get(i).getCategoryId() == depth2.get(0).getCategoryParent()) {
					dto.setCurrDepth1(depth1.get(i).getCategoryName());
				}
			}
			dto.setDepth1(depth1);
				
			List<ProductImagesDTO> productImages = dao.selectViewProductImages(productNo);
			dto.setProductImages(productImages);
				
			int memberNo = productView.getMemberNo();
				
			ShopDTO shop = dao.selectShop(memberNo);
			dto.setShop(shop);
			List<ProductDTO> shopProducts = dao.selectShopProducts(memberNo);
			dto.setShopProducts(shopProducts);
			dto.setMemberSgrade(dao.selectMemberGrade(memberNo));
			
			if(dto.getDepth1() == null || dto.getDepth2() == null || dto.getDepth3() == null || dto.getProductImages() == null || dto.getProductView() == null || dto.getShop() == null || dto.getShopProducts() == null) {
				try {
					response.sendRedirect(request.getContextPath() + "/main/index");
				} catch (IOException e) {
					e.printStackTrace();
				}
				return;
			} else {
				model.addAttribute("productViewDto", dto);
			}
		} else {
			try {
				response.sendRedirect(request.getContextPath() + "/main/index");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return;
		}
	}
}
