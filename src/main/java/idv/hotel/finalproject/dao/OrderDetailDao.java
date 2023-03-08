package idv.hotel.finalproject.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.model.OrderDetailBean;
import idv.hotel.finalproject.model.OrderListBean;

public interface OrderDetailDao extends JpaRepository<OrderDetailBean, Integer> {

	@Query(value="from OrderDetailBean where roomId = ?1 and checkindate = ?2 ")
	public OrderDetailBean findByRoomIdAndCheckinDate(Integer roomId, Date checkinDate);
}
