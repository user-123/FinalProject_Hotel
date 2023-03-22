package idv.hotel.finalproject.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.LoginDao;
import idv.hotel.finalproject.dao.OrderProductDao;
import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.OrderProductBean;
import idv.hotel.finalproject.service.OrderProductService;
@Transactional
@Service
public class OrderProductServiceImpl implements OrderProductService{
	OrderProductDao orderProductDao;
	LoginDao loginDao;
	
	@Autowired
	public OrderProductServiceImpl(OrderProductDao orderProductDao, LoginDao loginDao) {
		super();
		this.orderProductDao = orderProductDao;
		this.loginDao = loginDao;
	}
	
	
	
	
	@Override
	public OrderProductBean createProductOrder(OrderProductBean opb, Integer id) {
		opb.setBuyTime(new Timestamp(System.currentTimeMillis()));
		LoginBean lb = loginDao.findById(id).get();
		opb.setLoginOrder(lb);
		orderProductDao.save(opb);
		return opb;
	}




	@Override
	public List<OrderProductBean> historyOrder() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String email = auth.getName();
		Integer id = Integer.valueOf(loginDao.findIdByEmail(auth.getName()).toString());
		LoginBean lb = loginDao.findById(id).get();
		return orderProductDao.findByLoginBean(lb);
	}
	
	
	@Override
	public void setLoginBeanFkNull(LoginBean lb) {
		List<OrderProductBean> opbList = orderProductDao.findByLoginBean(lb);
		if(opbList.size()!=0) {
			for(int i=0;i<opbList.size();i++) {
				opbList.get(i).setLoginOrder(null);
			}
		}
	}
	

	
	
}

