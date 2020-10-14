package com.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.config.MySqlSessionFactory;
import com.dao.CartDAO;
import com.dao.GoodsDAO;
import com.dto.CartDTO;
import com.dto.GoodsDTO;
import com.dto.OrderDTO;

public class CartService {

	
	 public List<CartDTO> cartList(String userid) {
			SqlSession session = MySqlSessionFactory.getSession();
			List<CartDTO> list = null;
			try {
				CartDAO dao = new CartDAO();
				 list = dao.cartList(session, userid);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			return list;
		}//end idCheck
	public int cartAdd(CartDTO dto) {
		SqlSession session = MySqlSessionFactory.getSession();
		int n = 0;
		try {
			CartDAO dao = new CartDAO();
			n = dao.cartAdd(session, dto);
			session.commit();
		} finally {
			session.close();
		}
		return n;
	}// end cartAdd
	
	public int cartDel (int num) {
		SqlSession session = MySqlSessionFactory.getSession();
		int n = 0;
		try {
			CartDAO dao = new CartDAO();
			n = dao.cartDel(session, num);
			session.commit();
		} finally {
			session.close();
		}
		return n;
	}
	public int cartUpdate(HashMap<String, Integer> map) {
		// TODO Auto-generated method stub
		SqlSession session = MySqlSessionFactory.getSession();
		
		int n = 0;
		try {
			CartDAO dao = new CartDAO();
			n = dao.cartUpdate(session, map);
			session.commit();
		} finally {
			session.close();
		}
		return n;
	}
	
	public int cartAllDel(List<String> list) {
		SqlSession session = MySqlSessionFactory.getSession();
		int n = 0;
		try {
			CartDAO dao = new CartDAO();
			n = dao.cartAllDel(session, list);
			session.commit(); 
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return n;
	}
	
	public CartDTO cartbyNum(String num) {
		SqlSession session = MySqlSessionFactory.getSession();
		CartDAO dao = new CartDAO();
		CartDTO n = null;
		try {
			n = dao.cartbyNum(session, num);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return n;
	}
	public int orderDone(OrderDTO dto, String ordernum) {
		  SqlSession session = MySqlSessionFactory.getSession();
		  int n = 0;
		  try {
			  CartDAO dao = new CartDAO();
			  n = dao.orderDone(session, dto);
			  n = dao.cartDel(session, Integer.parseInt(ordernum));
			  session.commit();  
			  System.out.println(n);
		  }catch(Exception e) {
			  session.rollback();
		  }finally {
			  session.close();
		  }
		  return n;
	  }
}// end class
