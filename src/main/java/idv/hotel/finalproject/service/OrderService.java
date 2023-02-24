package idv.hotel.finalproject.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.OrderDetailDao;
import idv.hotel.finalproject.dao.OrderListDao;
import idv.hotel.finalproject.model.OrderDetailBean;
import idv.hotel.finalproject.model.OrderListBean;

@Service
//@Transactional(readOnly = true) 預設值
@Transactional
public class OrderService {
	
	@Autowired
	private OrderListDao olDao;
	@Autowired
	private OrderDetailDao odDao;
	
	//確認房間狀態 (如果房間為空回傳true)
	public boolean checkRoomStatement(OrderDetailBean roomId, List<OrderDetailBean> checkinDate) {
		if (odDao.findByRoomIdAndCheckinDate(roomId, checkinDate) != null) {
			System.out.println("房間已被預訂");
			return false;
		}
		System.out.println("房間可被預訂");
		return true;
	}
	/*
	//檢查訂單 (如果訂單成立回傳true)
	public boolean checkOrder(OrderDetailBean roomId, List<OrderListBean> checkinDate) {
		
		if (checkRoomStatement(roomId, checkinDate) == false) {
			System.out.println("訂單成立");
			return true;
		}
		System.out.println("訂單不成立");
		return false;
	}
	
	//成立訂單，完成寫入DB，回傳true
	public boolean orderCreate(OrderDetailBean roomId, OrderListBean checkinDate) {
		//olDao.save();
		//odDao.save(OrderDetailBean orderDetail);
		if (checkOrder(roomId, null)) {
			System.out.println("訂單存入DB");
			odDao.save(roomId);
			return true;
		}
		System.out.println("訂單被拋棄");
		return true;
		
	}
	*/
	
	
	
	
}
