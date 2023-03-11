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
	// 9.save(後台)
	public OrderListBean findById(Integer id) {
		Optional<OrderListBean> optional = olDao.findById(id);
		
		if(optional.isEmpty()) {
			return null;
		}
		
		return optional.get();
	}

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
	@Override
	public List<OrderListBean> findAll() {
		return olDao.findAll();
	}
	
	// 3.findHistory(前台)
	// 查詢特定userid的訂單資料
	// 前台:查詢特定userID的訂單資料，我們幫他固定UserID，限制他只能看自己的
	@Override
	public List<OrderListBean> findHistory(Integer userid) {
		return olDao.findDataByUserIdF(userid);
	}
	
	// 3.findDataByUserId(後台)
	// 查詢特定userid的訂單資料
	@Override
	public List<OrderListBean> findDataByUserIdB(String userid) {
		return olDao.findDataByUserIdB(userid);
	}
	
	// 4.findDataByOrderId(前台)
	// 查詢特定orderid的訂單資料
	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
//	@Override
//	public OrderListBean findDataByOrderIdF(String orderid) {
//		return olDao.findDataByOrderIdF(orderid);
//	}
	
	// 4.findDataByOrderId(後台)
	// 查詢特定orderid的訂單資料
	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
	@Override
	public OrderListBean findDataByOrderIdB(String orderid) {
		return olDao.findDataByOrderIdB(orderid);
	}
	
//	// 5.findDataByCheckdate(後台)
//	// 查詢特定日期的訂單資料
//	@Override
//	public List<OrderListBean> findDataByCheckdate(Date cd) {
//		return olDao.findDataByCheckdate(cd);
//	}

	// 6.findDataByOrderdate(後台)
	// 查詢特定下訂日期的訂單資料(訂單成立日期)
	@Override
	public List<OrderListBean> findDataByOrderdate(String order) {
		return olDao.findDataByOrderdate(order);
	}

	// 7.findDataByRoomId(後台)
	// 查詢特定房型的訂單資料
	@Override
	public List<OrderListBean> findDataByRoomId(Integer roomid) {
		return olDao.findDataByRoomId(roomid);
	}
	
	// 8.deleteDataByOrderId(前後台)
	// 尚未付款前可刪除訂單
	@Override
	public void deleteDataByOrderId(String orderid) {
		olDao.deleteDataByOrderId(orderid);
	}

}
