package idv.hotel.finalproject.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.OrderListDao;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.service.OrderService;


@Transactional
@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderListDao olDao;
	
	public OrderServiceImpl() {}

	//獲取現在時間，return返回字串格式MMdd
	//**************帶資料進SQL的同時，生成訂單編號，放到名為information的model裡
	@Override
	public String createorderid() {
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("MMdd");
		String dateString = formatter.format(currentTime);
		// 由月日+3位隨機數生成流水號
		int x = (int) (Math.random() * 900) + 100;
		String serial = dateString + x;
		return serial;
	}

	//---------------------1.先讓功能可以正常使用(未做)-----------------------------
	//---------------------2.卡控會員自己只能找到自己的資料![1,3,8](未做)-----------------------------
	// 1.save(前台)
	// 會員下訂=>儲存所有細節(orderlist+orderdetail)
	// 控制會員只能使用自己的userid
	@Override
	public void insert(OrderListBean olb) {
		olDao.save(olb);
	}
	//List：特定型別，不固定長度的陣列。
	//Array：不特定型別，固定長度的陣列，長度需事先宣告。
	//ArrayList：不特定型別，不固定長度的陣列。
	// 2.findAll(後台)
//	@Override
//	public List<OrderListBean> findAll() {
//		return olDao.findAll();
//	}
	// 3.findHistory(前台)
	// 查詢特定userid的訂單資料
	// 前台:查詢特定userID的訂單資料，我們幫他固定UserID，限制他只能看自己的
	@Override
	public List<OrderListBean> findHistory(Integer userid) {
		return olDao.findDataByUserId(userid);
	}
//	// 3.findDataByUserId(後台)
//	// 查詢特定userid的訂單資料
//	@Override
//	public List<OrderListBean> findDataByUserIdB(Integer userid) {
//		return olDao.findDataByUserId(userid);
//	}
//	// 4.findDataByOrderId(後台)
//	// 查詢特定orderid的訂單資料
//	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
//	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
//	@Override
//	public OrderListBean findDataByOrderId(String orderid) {
//		return olDao.findDataByOrderId(orderid);
//	}
//	// 5.findDataByCheckdate(後台)
//	// 查詢特定日期的訂單資料
//	@Override
//	public List<OrderListBean> findDataByCheckdate(Timestamp cd) {
//		return olDao.findDataByCheckdate(cd);
//	}
//
//	// 6.findDataByOrderdate(後台)
//	// 查詢特定日期的訂單資料(訂單成立日期)
//	@Override
//	public List<OrderListBean> findDataByOrderdate(Date order) {
//		return olDao.findDataByOrderdate(order);
//	}
//
//	// 7.findDataByRoomId(後台)
//	// 查詢特定房型的訂單資料
//	@Override
//	public List<OrderListBean> findDataByRoomId(RoomBean roomid) {
//		return olDao.findDataByRoomId(roomid);
//	}
	// 8.deleteDataByOrderId(前台)
	// 尚未付款前可刪除訂單
	@Override
	public void deleteDataByOrderIdF(String orderid) {
		olDao.deleteDataByOrderId(orderid);
	}
//	// 8.deleteDataByOrderId(後台)
//	// 不做確認就刪除，反正沒有該筆資料也不會刪到東西
//	@Override
//	public void deleteDataByOrderIdB(String orderid) {
//		olDao.deleteDataByOrderId(orderid);
//	}

	@Override
	public OrderListBean findId(Integer Id) {
		Optional<OrderListBean> orderListBean = olDao.findById(Id);
		
		return orderListBean.get();
	}

}
