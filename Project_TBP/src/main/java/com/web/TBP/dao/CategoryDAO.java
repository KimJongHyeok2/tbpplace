package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.CategoryDTO;

public interface CategoryDAO {
	public List<CategoryDTO> selectCategory();
	public List<CategoryDTO> selectCategory2(int parentId);
	public List<CategoryDTO> selectCategory3(int parentId);
	public List<CategoryDTO> selectSalesWay();
	public List<CategoryDTO> selectProductState();
	public CategoryDTO selectUpdateCateogy(int categoryId);
	public List<CategoryDTO> selectNavCategory();
}