package idv.hotel.finalproject.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface OrderListRepository extends JpaRepository<OrderListBean, Integer> {

	// 1.save(前台)
	// 儲存所有細節(orderlist+orderdetail)
	// JpaRepository有，我們不須自己做
	
	// 2.findAll(後台)
	// 查詢所有訂單及所有關聯訂單細節(訂單一覽表)
    // JpaRepository有，我們不須自己做

	// 3.findDataByUserId(前後台)
	// 查詢特定userid的訂單資料
	@Query(value = "SELECT*\r\n"
			+ "  FROM [dbo].[Order_List]\r\n"
			+ "  where [FK_Logininfo_Id] =?1 ",nativeQuery=true)
	public List<OrderListBean> findDataByUserId(Integer userid);

	// 4.findDataByOrderId(前後台)
	// 查詢特定orderid的訂單資料
	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
	@Query(value = "from OrderListBean where orderid=?1")
	public OrderListBean findDataByOrderId(String orderid);

	// 5.findDataByCheckdate(後台)
	// 查詢特定日期的訂單資料
	@Query(value = "from OrderListBean where ?1 between ckeckindate and checkoutdate")
	public List<OrderListBean> findDataByCheckdate(Timestamp cd);

	// 6.findDataByOrderdate(後台)
	// 查詢特定日期的訂單資料(訂單成立日期)
	@Query(value = "from OrderListBean where orderdate=?1")
	public List<OrderListBean> findDataByOrderdate(Date order);
	
	// 7.findDataByRoomId(後台)
	// 查詢特定房型的訂單資料
	@Query(value = "from OrderListBean where roomid=?1")
	public List<OrderListBean> findDataByRoomId(RoomBean roomid);

	// 8.deleteDataByOrderId(前後台)
	// 前台：尚未付款前可刪除訂單
	// 後台；不做確認就刪除，反正沒有該筆資料也不會刪到東西
	@Transactional
	@Modifying
	@Query(value = "delete from Order_List where orderid=?1",nativeQuery=true)
	public void deleteDataByOrderId(String orderid);

}
