package idv.hotel.finalproject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.OrderProductDetailsDao;
import idv.hotel.finalproject.dao.ProductDao;
import idv.hotel.finalproject.model.OrderProductBean;
import idv.hotel.finalproject.model.OrderProductDetailsBean;
import idv.hotel.finalproject.model.ProductBean;
import idv.hotel.finalproject.service.OrderProductDetailsService;
@Transactional
@Service
public class OrderProductDetailsServiceImpl implements OrderProductDetailsService{
	OrderProductDetailsDao orderProductDetailsDao;
	ProductDao productDao;
	@Autowired
	public OrderProductDetailsServiceImpl(OrderProductDetailsDao orderProductDetailsDao, ProductDao productDao) {
		super();
		this.orderProductDetailsDao = orderProductDetailsDao;
		this.productDao = productDao;
	}

	
	
	@Override
	public void createProductOrderDetails(OrderProductBean opbopdb, String productIdArr, String quantArr,OrderProductDetailsBean opdb) {
		String[] idArr = productIdArr.split("#");
		String[] statusArr = quantArr.split("#");
		for (int i=0;i<idArr.length;i++) {
			OrderProductDetailsBean newOpdb = new OrderProductDetailsBean();
			newOpdb.setOrderProductDetailsId(null);
			Integer productId = Integer.valueOf(idArr[i]);
			Integer quant = Integer.valueOf(statusArr[i]);
			ProductBean pb = productDao.findById(productId).get();
			newOpdb.setQuant(quant);
			newOpdb.setOrderProduct(opbopdb);
			newOpdb.setProductDetails(pb);
			orderProductDetailsDao.save(newOpdb);
		}
		
	}



	@Override
	public void deleteOrderProductDetailsBean(Integer id) {
		orderProductDetailsDao.deleteOrderProductDetailsBean(id);
		
	}
	

	
}
