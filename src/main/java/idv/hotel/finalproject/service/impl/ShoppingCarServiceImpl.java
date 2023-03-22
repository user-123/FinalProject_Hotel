package idv.hotel.finalproject.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.LoginDao;
import idv.hotel.finalproject.dao.ProductDao;
import idv.hotel.finalproject.dao.ShoppingCarDao;
import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.ProductBean;
import idv.hotel.finalproject.model.ShoppingCarBean;
import idv.hotel.finalproject.service.ShoppingCarService;
@Transactional
@Service
public class ShoppingCarServiceImpl implements ShoppingCarService{
	ShoppingCarDao shoppingCarDao;
	ProductDao productDao;
	LoginDao loginDao;
	@Autowired
	public ShoppingCarServiceImpl(ShoppingCarDao shoppingCarDao,ProductDao productDao,LoginDao loginDao) {
		super();
		this.shoppingCarDao = shoppingCarDao;
		this.productDao = productDao;
		this.loginDao = loginDao;
	}
	
	
	
	
	@Override
	public void addCart(Integer productId,ShoppingCarBean sb,Integer accountId) {
		ProductBean pb = productDao.findById(productId).get();
		LoginBean lb = loginDao.findById(accountId).get();
		sb.setProductShoppingCar(pb);
		sb.setShoppingCarAccountId(lb);
		shoppingCarDao.save(sb);
	}




	@Override
	public List<ShoppingCarBean> findProductInMyCart(HttpSession session,Integer accountId) {
		return shoppingCarDao.findByShoppingCarAccountId(accountId);
	}
	
	
	@Override
	public void deleteCart(Integer cartId) {
//		 ShoppingCarBean sb = shoppingCarDao.findById(cartId).get();
//		 LoginBean lb = shoppingCarDao.findById(cartId).get().getShoppingCarAccountId();
//		 ProductBean pb = shoppingCarDao.findById(cartId).get().getProductShoppingCar();
//		 sb.getProductShoppingCar().remove(pb);
//		 sb.getShoppingCarAccountId().remove(lb);
		 shoppingCarDao.deleteById(cartId);
	}




	@Override
	public void deleteShoppingCarBean(Integer id) {
		shoppingCarDao.deleteShoppingCarBean(id);
		
	}




	@Override
	public void deleteShoppingCarLoginBean(Integer id) {
		shoppingCarDao.deleteShoppingCarLoginBean(id);
		
	}

	
	
	
}
