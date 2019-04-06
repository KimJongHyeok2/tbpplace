package com.web.TBP.dao;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import com.web.TBP.beans.DeliveryDTO;
import com.web.TBP.beans.ProductDTO;
import com.web.TBP.beans.OrderDTO;

@MapperScan
public interface OrderDAO {
/*	public List<ProductDTO> orderProduct(@Param("productNo")int[] productNo);*/
	public ProductDTO orderProduct(@Param("productNo") int productNo);
	public DeliveryDTO myDelivery(int memberNo);
	public int orderInsert(@Param("orderDto")OrderDTO orderDto);
	public int checkMemberMoney(int memberNo);
	public int checkProductStock(int productNo);
	public int checkSalesWay(int productNo);
	public int selectMyMoney(int memberNo);
	public int memberMoneyUpdate(int money, int memberNo);
	public int productStockUpdate(int number, int productNo);
	public int deleteCart(@Param("cartNo")int[] cartNo);
}