package com.web.TBP.command;

import java.util.List;

import org.springframework.ui.Model;

import com.web.TBP.beans.CategoryDTO;
import com.web.TBP.beans.CategoryPopularDTO;
import com.web.TBP.constant.C;
import com.web.TBP.dao.MainDAO;

public class CategoryPopularListCommand extends Command {
	
	@Override
	public void execute(Model model) {
		
		MainDAO dao = C.sqlSession.getMapper(MainDAO.class);
		
		List<CategoryDTO> categorys = dao.selectCategorys();
		
		CategoryPopularDTO dto = new CategoryPopularDTO();
		
		for(int i=0; i<categorys.size(); i++) {	
			if(categorys.get(i).getCategoryId() == 100) {
				dto.setC100(dao.selectCategorys2(categorys.get(i).getCategoryId()));
				dto.setC100_product(dao.selectPopularProduct(categorys.get(i).getCategoryId()));
			} else if(categorys.get(i).getCategoryId() == 200) {
				dto.setC200(dao.selectCategorys2(categorys.get(i).getCategoryId()));
				dto.setC200_product(dao.selectPopularProduct(categorys.get(i).getCategoryId()));
			} else if(categorys.get(i).getCategoryId() == 300) {
				dto.setC300(dao.selectCategorys2(categorys.get(i).getCategoryId()));
				dto.setC300_product(dao.selectPopularProduct(categorys.get(i).getCategoryId()));
			} else if(categorys.get(i).getCategoryId() == 400) {
				dto.setC400(dao.selectCategorys2(categorys.get(i).getCategoryId()));
				dto.setC400_product(dao.selectPopularProduct(categorys.get(i).getCategoryId()));				
			} else if(categorys.get(i).getCategoryId() == 500) {
				dto.setC500(dao.selectCategorys2(categorys.get(i).getCategoryId()));
				dto.setC500_product(dao.selectPopularProduct(categorys.get(i).getCategoryId()));				
			}
		}
		
		model.addAttribute("categoryPopularDto", dto);
	}

}