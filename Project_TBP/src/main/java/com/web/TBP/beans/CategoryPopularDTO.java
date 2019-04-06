package com.web.TBP.beans;

import java.util.List;

public class CategoryPopularDTO {

	private List<CategoryDTO> c100;
	private List<ProductDTO> c100_product;
	private List<CategoryDTO> c200;
	private List<ProductDTO> c200_product;
	private List<CategoryDTO> c300;
	private List<ProductDTO> c300_product;
	private List<CategoryDTO> c400;
	private List<ProductDTO> c400_product;
	private List<CategoryDTO> c500;
	private List<ProductDTO> c500_product;
	
	public CategoryPopularDTO() { }
	
	public CategoryPopularDTO(List<CategoryDTO> c100, List<ProductDTO> c100_product, List<CategoryDTO> c200,
			List<ProductDTO> c200_product, List<CategoryDTO> c300, List<ProductDTO> c300_product,
			List<CategoryDTO> c400, List<ProductDTO> c400_product, List<CategoryDTO> c500,
			List<ProductDTO> c500_product) {
		this.c100 = c100;
		this.c100_product = c100_product;
		this.c200 = c200;
		this.c200_product = c200_product;
		this.c300 = c300;
		this.c300_product = c300_product;
		this.c400 = c400;
		this.c400_product = c400_product;
		this.c500 = c500;
		this.c500_product = c500_product;
	}

	public List<CategoryDTO> getC100() {
		return c100;
	}
	
	public void setC100(List<CategoryDTO> c100) {
		this.c100 = c100;
	}
	
	public List<ProductDTO> getC100_product() {
		return c100_product;
	}
	
	public void setC100_product(List<ProductDTO> c100_product) {
		this.c100_product = c100_product;
	}
	
	public List<CategoryDTO> getC200() {
		return c200;
	}
	
	public void setC200(List<CategoryDTO> c200) {
		this.c200 = c200;
	}
	
	public List<ProductDTO> getC200_product() {
		return c200_product;
	}
	
	public void setC200_product(List<ProductDTO> c200_product) {
		this.c200_product = c200_product;
	}
	
	public List<CategoryDTO> getC300() {
		return c300;
	}
	
	public void setC300(List<CategoryDTO> c300) {
		this.c300 = c300;
	}
	
	public List<ProductDTO> getC300_product() {
		return c300_product;
	}
	
	public void setC300_product(List<ProductDTO> c300_product) {
		this.c300_product = c300_product;
	}
	
	public List<CategoryDTO> getC400() {
		return c400;
	}
	
	public void setC400(List<CategoryDTO> c400) {
		this.c400 = c400;
	}
	
	public List<ProductDTO> getC400_product() {
		return c400_product;
	}
	
	public void setC400_product(List<ProductDTO> c400_product) {
		this.c400_product = c400_product;
	}
	
	public List<CategoryDTO> getC500() {
		return c500;
	}
	
	public void setC500(List<CategoryDTO> c500) {
		this.c500 = c500;
	}
	
	public List<ProductDTO> getC500_product() {
		return c500_product;
	}
	
	public void setC500_product(List<ProductDTO> c500_product) {
		this.c500_product = c500_product;
	}
	
}
