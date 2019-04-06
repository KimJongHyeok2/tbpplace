package com.web.TBP.dao;

import java.util.List;

import com.web.TBP.beans.CartDTO;

public interface CartDAO {
	public int insertCart(int memberNo, int productNo, int cartStock);
	public List<CartDTO> selectCart(int memberNo);
	public int deleteCart(int cartNo);
}