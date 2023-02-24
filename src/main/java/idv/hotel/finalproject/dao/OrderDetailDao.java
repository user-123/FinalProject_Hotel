package idv.hotel.finalproject.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.model.OrderDetailBean;
import idv.hotel.finalproject.model.OrderListBean;

public interface OrderDetailDao extends JpaRepository<OrderDetailBean, Integer> {
	
	OrderListBean findByroomId(OrderListBean roomId);
	
	OrderListBean findByRoomIdAndCheckinDate(OrderDetailBean roomId, List<OrderDetailBean> checkinDate);
	
	
	
	
	
	OrderListBean find();
	
}
