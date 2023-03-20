package idv.hotel.finalproject.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import idv.hotel.finalproject.model.ShoppingCarBean;

public interface ShoppingCarService {
	void addCart(Integer productId,ShoppingCarBean sb,Integer accountId);
	List<ShoppingCarBean> findProductInMyCart(HttpSession session,Integer accountId);
	void deleteCart(Integer cartId);


}
