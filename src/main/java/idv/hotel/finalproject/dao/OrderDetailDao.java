package idv.hotel.finalproject.dao;

import java.util.Date;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import idv.hotel.finalproject.model.OrderDetailBean;
import idv.hotel.finalproject.model.OrderListBean;

public interface OrderDetailDao extends JpaRepository<OrderDetailBean, Integer> {

	@Query(value = "from OrderDetailBean where roomId = ?1 and livingDate = ?2 ")
	public OrderDetailBean findByRoomIdAndLivingDate(Integer roomId, Date livingDate);

	// 應該改成讓spring boot自動關聯刪除，則此方法可棄用
	// @Transactional
	@Modifying
	// @Query(value="delete from Order_Detail where
	// FK_OrderList_Id=?1",nativeQuery=true)
	@Query(value = "delete from OrderDetailBean od WHERE od.orderId = :orderListId")
	public void deleteDataByOrderId(@Param("orderListId") OrderListBean olBean);

	@Query(value="select count(od) from OrderDetailBean od where od.livingDate = :currentDate")
	public Integer countBylivingDate (Date currentDate);	//思考需不需要將傳入class改為OrderDetailBean

	@Query(value="select count(od) from OrderDetailBean od where od.livingDate between :startDate and :endDate")
	public Integer countBylivingDate (Date startDate, Date endDate);	//思考需不需要將傳入class改為OrderDetailBean
}
