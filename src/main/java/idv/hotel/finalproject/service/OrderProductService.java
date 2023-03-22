package idv.hotel.finalproject.service;

import java.util.List;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.OrderProductBean;

public interface OrderProductService {
	OrderProductBean createProductOrder(OrderProductBean opb,Integer id);
	List<OrderProductBean> historyOrder();
	void setLoginBeanFkNull(LoginBean lb);
	
}
