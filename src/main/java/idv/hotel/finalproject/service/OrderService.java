package idv.hotel.finalproject.service;

import java.util.List;

import idv.hotel.finalproject.model.OrderListBean;

public interface OrderService {

	//獲取現在時間，return返回字串格式MMdd
	//**************帶資料進SQL的同時，生成訂單編號，放到名為information的model裡
	public String createorderid();

	//---------------------1.先讓功能可以正常使用(未做)-----------------------------
	//---------------------2.卡控會員自己只能找到自己的資料![1,3,8](未做)-----------------------------
	// 1.save(前台)
	// 會員下訂=>儲存所有細節(orderlist+orderdetail)
	// 控制會員只能使用自己的userid
	public void insert(OrderListBean olb);
	//List：特定型別，不固定長度的陣列。
	//Array：不特定型別，固定長度的陣列，長度需事先宣告。
	//ArrayList：不特定型別，不固定長度的陣列。
	// 2.findAll(後台)
//	public List<OrderListBean> findAll() ;
	// 3.findHistory(前台)
	// 查詢特定userid的訂單資料
	// 前台:查詢特定userID的訂單資料，我們幫他固定UserID，限制他只能看自己的
	public List<OrderListBean> findHistory(Integer userid);
	// 3.findDataByUserId(後台)
	// 查詢特定userid的訂單資料
//	public List<OrderListBean> findDataByUserIdB(Integer userid);
	// 4.findDataByOrderId(後台)
	// 查詢特定orderid的訂單資料
	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
//	public OrderListBean findDataByOrderId(String orderid) ;
	// 5.findDataByCheckdate(後台)
	// 查詢特定日期的訂單資料
//	public List<OrderListBean> findDataByCheckdate(Timestamp cd);

	// 6.findDataByOrderdate(後台)
	// 查詢特定日期的訂單資料(訂單成立日期)
//	public List<OrderListBean> findDataByOrderdate(Date order);

	// 7.findDataByRoomId(後台)
	// 查詢特定房型的訂單資料
//	public List<OrderListBean> findDataByRoomId(RoomBean roomid);
	// 8.deleteDataByOrderId(前台)
	// 尚未付款前可刪除訂單
	public void deleteDataByOrderIdF(String orderid) ;
	// 8.deleteDataByOrderId(後台)
	// 不做確認就刪除，反正沒有該筆資料也不會刪到東西
//	public void deleteDataByOrderIdB(String orderid) ;

}
