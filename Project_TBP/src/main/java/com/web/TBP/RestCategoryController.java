package com.web.TBP;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.TBP.beans.CategoryDTO;
import com.web.TBP.beans.RCategoryDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.CategoryDAO;

@RestController
@RequestMapping("/category")
public class RestCategoryController {
	
	// 카테고리 대분류
	@RequestMapping("/depth1")
	public RCategoryDTO depth1() {
		
		CategoryDAO dao = C.sqlSession.getMapper(CategoryDAO.class);
		RCategoryDTO dto = new RCategoryDTO();
		dto.setList(dao.selectCategory());
		
		if(dto.getList() != null) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	// 카테고리 중분류
	@RequestMapping("/depth2")
	public RCategoryDTO depth2(int parentId) {
		
		CategoryDAO dao = C.sqlSession.getMapper(CategoryDAO.class);
		RCategoryDTO dto = new RCategoryDTO();
		dto.setList(dao.selectCategory2(parentId));
		
		if(dto.getList() != null) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	// 카테고리 소분류
	@RequestMapping("/depth3")
	public RCategoryDTO depth3(int parentId) {
		
		CategoryDAO dao = C.sqlSession.getMapper(CategoryDAO.class);
		RCategoryDTO dto = new RCategoryDTO();
		dto.setList(dao.selectCategory3(parentId));
		
		if(dto.getList() != null) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	// 카테고리(상품수정)
	@RequestMapping("/updateDepth")
	public String[] updateDepth(int categoryId) {
		
		CategoryDAO dao = C.sqlSession.getMapper(CategoryDAO.class);
		CategoryDTO dto3 = dao.selectUpdateCateogy(categoryId);
		
		String[] categorys = new String[3];
		categorys[0] = dto3.getCategoryName();
		
		CategoryDTO dto2 = dao.selectUpdateCateogy(dto3.getCategoryParent());
		categorys[1] = dto2.getCategoryName();
		
		CategoryDTO dto1 = dao.selectUpdateCateogy(dto2.getCategoryParent());
		categorys[2] = dto1.getCategoryName();
		
		return categorys;
	}
	
	// 거래방식
	@RequestMapping("/salesWay")
	public RCategoryDTO way() {
		
		CategoryDAO dao = C.sqlSession.getMapper(CategoryDAO.class);
		RCategoryDTO dto = new RCategoryDTO();
		dto.setList(dao.selectSalesWay());
		
		if(dto.getList() != null) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	// 상품상태
	@RequestMapping("/productState")
	public RCategoryDTO state() {
		
		CategoryDAO dao = C.sqlSession.getMapper(CategoryDAO.class);
		RCategoryDTO dto = new RCategoryDTO();
		dto.setList(dao.selectProductState());
		
		if(dto.getList() != null) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
	// Nav 카테고리
	@RequestMapping("/navCategory")
	public RCategoryDTO navCategory() {
		
		RCategoryDTO dto = new RCategoryDTO();
		CategoryDAO dao = C.sqlSession.getMapper(CategoryDAO.class);
		dto.setList(dao.selectNavCategory());
		
		if(dto.getList().size() != 0 && dto.getList() != null) {
			dto.setCount(dto.getList().size());
			dto.setStatus("Ok");
		} else {
			dto.setStatus("Fail");
		}
		
		return dto;
	}
	
}