package idv.hotel.finalproject.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.model.RoomBean;

public interface OrderListDao extends JpaRepository<OrderListBean, Integer> {

	// 1.save(前台)
	// 儲存所有細節(orderlist+orderdetail)
	// JpaRepository有，我們不須自己做

	// 2.findAll(後台)
	// 查詢所有訂單及所有關聯訂單細節(訂單一覽表)
	@Query(value = "select * from [dbo].[Order_List] order by orderdate desc", nativeQuery=true)
	public List<OrderListBean> findAll();

	// 3.findDataByUserId(前台)
	// 查詢特定userid的訂單資料
	@Query(value = "select * from [dbo].[Order_List] where [FK_Logininfo_Id] =?1 order by orderdate desc", nativeQuery=true)
	public List<OrderListBean> findDataByUserIdF(Integer userid);

	// 3.findDataByUserId(後台)
	// 查詢特定userid的訂單資料
	//錯誤的：@Query(value = "select * from [dbo].[Order_List] where [FK_Logininfo_Id] =?1 order by orderdate desc", nativeQuery=true)
	@Query(value = "select ol from OrderListBean ol where ol.userid =?1 order by ol.orderdate desc")
	public List<OrderListBean> findDataByUserIdB(LoginBean userid);

	// 4.findDataByOrderId(前台)
	// 查詢特定orderid的訂單資料
	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
//	@Query(value = "SELECT* from OrderListBean where orderid=?1 order by orderdate desc",nativeQuery=true)
//	public OrderListBean findDataByOrderIdF(String orderid);

	// 4.findDataByOrderId(後台)
	// 查詢特定orderid的訂單資料
	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
	@Query(value = "select * from [dbo].[Order_List] where orderid =?1 order by orderdate desc", nativeQuery=true)
	public OrderListBean findDataByOrderIdB(String orderid);

	// 5.findDataByCheckdate(後台)
	// 查詢特定日期的訂單資料
//	@Query(value = "SELECT* from OrderListBean where ?1 between ckeckindate and checkoutdate order by orderdate desc",
//	nativeQuery=true)
//	public List<OrderListBean> findDataByCheckdate(Date cd);

	// 6.findDataByOrderdate(後台)
	// 查詢特定日期的訂單資料(訂單成立日期)
	@Query(value = "select * from [dbo].[Order_List] where CAST(orderdate as date) =?1 order by orderdate desc", nativeQuery=true)
	public List<OrderListBean> findDataByOrderdate(String order);

	// 7.findDataByRoomId(後台)
	// 查詢特定房型的訂單資料
	//錯誤的：@Query(value = "select * from [dbo].[Order_List] where [FK_Room_Id] =?1 order by orderdate desc", nativeQuery=true)
	@Query(value = "select ol from OrderListBean ol where ol.roomid =?1 order by ol.orderdate desc")
	public List<OrderListBean> findDataByRoomId(RoomBean roomId);

	// 8.deleteDataByOrderId(前後台)
	// 前台：尚未付款前可刪除訂單
	// 後台；不做確認就刪除，反正沒有該筆資料也不會刪到東西
	//@Transactional
	@Modifying
	//@Query(value = "delete from [dbo].[Order_List] where orderid =?1", nativeQuery=true)
	@Query(value="delete from OrderListBean ol WHERE ol.orderid = :orderId")
	public void deleteDataByOrderId(String orderId);
}
