package idv.hotel.finalproject.service;

import idv.hotel.finalproject.model.OrderProductBean;
import idv.hotel.finalproject.model.OrderProductDetailsBean;

public interface OrderProductDetailsService {
	void createProductOrderDetails(OrderProductBean opbopdb,String productIdArr,String quantArr,OrderProductDetailsBean opdb);
	void deleteOrderProductDetailsBean(Integer id);
}
