package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.CategoryDTO;
import com.web.TBP.beans.ProductDTO;

public interface MainDAO {
	public List<CategoryDTO> selectCategorys();
	public List<CategoryDTO> selectCategorys2(int categoryParent);
	public List<ProductDTO> selectPopularProduct(int categoryParent);
}