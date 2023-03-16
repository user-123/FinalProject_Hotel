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

	@Query(value="from OrderDetailBean where roomId = ?1 and livingDate = ?2 ")
	public OrderDetailBean findByRoomIdAndLivingDate(Integer roomId, Date livingDate);

	//應該改成讓spring boot自動關聯刪除，則此方法可棄用
	//@Transactional
	@Modifying
	//@Query(value="delete from Order_Detail where FK_OrderList_Id=?1",nativeQuery=true)
	@Query(value="delete from OrderDetailBean od WHERE od.orderId = :orderListId")
	public void deleteDataByOrderId(@Param("orderListId") OrderListBean olBean);
}
