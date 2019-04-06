package com.web.TBP.dao;

import java.util.List;
import java.util.Set;

import com.web.TBP.beans.SearchCategoryDTO;
import com.web.TBP.beans.SearchDTO;

public interface SearchDAO {
	public List<SearchDTO> selectSearch(String searchValue, int page, int allRow);
	public List<SearchDTO> selectDepth3Search(int categoryId, int page, int allRow);
	public List<SearchDTO> selectDepth2Search(int categoryId, int page, int allRow);
	public List<SearchDTO> selectDepth1Search(int categoryId, int page, int allRow);
	public Set<Integer> selectCategorys(String searchValue);
	public int searchAllCount(String searchValue);
	public int reSearchAllCount(String searchValue, int categoryId);
	public int categorySearchAllCount(int categoryId);
	public int categorySearchAllCount2(int categoryId);
	public int categorySearchAllCount3(int categoryId);
	public SearchCategoryDTO searchCategoryCount(String searchValue, int categoryId);
	public SearchCategoryDTO searchCategoryCount2(int categoryId);
	public List<SearchCategoryDTO> searchCategoryCount3(int categoryId);
	public List<SearchCategoryDTO> searchCategoryCount4(int categoryId);
	public List<SearchDTO> selectReSearch(int categoryId, String searchValue, int page, int allRow);
}