package idv.hotel.finalproject.service;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.OrderDetailDao;
import idv.hotel.finalproject.dao.OrderListDao;
import idv.hotel.finalproject.model.OrderDetailBean;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.model.RoomBean;

@Service
@Transactional
public class OrderService {
	@Autowired
	private OrderListDao olDao;
	@Autowired
	private OrderDetailDao odDao;

	//獲取現在時間，return返回字串格式MMdd
	//**************帶資料進SQL的同時，生成訂單編號，放到名為information的model裡
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
	public void insert(OrderListBean olb) {
		olDao.save(olb);
	}
	//List：特定型別，不固定長度的陣列。
	//Array：不特定型別，固定長度的陣列，長度需事先宣告。
	//ArrayList：不特定型別，不固定長度的陣列。
	// 2.findAll(後台)
	public List<OrderListBean> findAll() {
		return olDao.findAll();
	}
	// 3.findHistory(前台)
	// 查詢特定userid的訂單資料
	// 前台:查詢特定userID的訂單資料，我們幫他固定UserID，限制他只能看自己的
	public List<OrderListBean> findHistory(Integer userid) {
		return olDao.findDataByUserId(userid);
	}
	// 3.findDataByUserId(後台)
	// 查詢特定userid的訂單資料
	public List<OrderListBean> findDataByUserIdB(Integer userid) {
		return olDao.findDataByUserId(userid);
	}
	// 4.findDataByOrderId(後台)
	// 查詢特定orderid的訂單資料
	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
	public OrderListBean findDataByOrderId(String orderid) {
		return olDao.findDataByOrderId(orderid);
	}
	// 5.findDataByCheckdate(後台)
	// 查詢特定日期的訂單資料
	public List<OrderListBean> findDataByCheckdate(Timestamp cd) {
		return olDao.findDataByCheckdate(cd);
	}

	// 6.findDataByOrderdate(後台)
	// 查詢特定日期的訂單資料(訂單成立日期)
	public List<OrderListBean> findDataByOrderdate(Date order) {
		return olDao.findDataByOrderdate(order);
	}

	// 7.findDataByRoomId(後台)
	// 查詢特定房型的訂單資料
	public List<OrderListBean> findDataByRoomId(RoomBean roomid) {
		return olDao.findDataByRoomId(roomid);
	}
	// 8.deleteDataByOrderId(前台)
	// 尚未付款前可刪除訂單
	public void deleteDataByOrderIdF(String orderid) {
		olDao.deleteDataByOrderId(orderid);
	}
	// 8.deleteDataByOrderId(後台)
	// 不做確認就刪除，反正沒有該筆資料也不會刪到東西
	public void deleteDataByOrderIdB(String orderid) {
		olDao.deleteDataByOrderId(orderid);
	}





	//確認房間狀態 (如果房間為空回傳true)
	public boolean checkRoomState(OrderListBean roomId, Timestamp checkinDate) {
		boolean roomStatus = false;
		Integer roomId_Integer = Integer.parseInt(roomId.getRoomIdtoString());

		if (odDao.findByRoomIdAndCheckinDate(roomId_Integer, checkinDate) != null) {
			System.out.println("房間已被預訂");
			roomStatus = false;
		}else {
			System.out.println("房間可被預訂");
			roomStatus = true;
		}


		return roomStatus;
	}

	//檢查入住時間是否等於或晚於現在日期
	public boolean checkInputDate(Date checkinDate) {
		boolean checkResult = false;
		Date currentDate = new Date();
		//Calendar nowDate = Calendar.getInstance();
		if (!checkinDate.before(currentDate)) {
			checkResult = true;
		}
		return checkResult;
	}

	//檢查入住時間是否早於退房時間
	public boolean checkInputDate(Date checkinDate, Date checkoutDate) {
		boolean checkResult = false;
		if (checkinDate.before(checkoutDate)) {
			checkResult = true;
		}
		return checkResult;
	}
	//迴圈檢查每一日空房狀況，如果有任一日房間不為空(已被訂)，回傳false
	public boolean checkRoomStatus(Integer roomId, Date checkinDate, Date checkoutDate) {
		boolean checkResult = false;
		List<Boolean> cidArray = new ArrayList<>();
		Calendar checkinDateCal = Calendar.getInstance();
		Calendar checkoutDateCal = Calendar.getInstance();
		checkinDateCal.setTime(checkinDate);
		checkoutDateCal.setTime(checkoutDate);
		while(checkinDateCal.before(checkoutDateCal)) {
			Timestamp checkinDateTs = new Timestamp(checkinDateCal.getTimeInMillis());
			if (odDao.findByRoomIdAndCheckinDate(roomId, checkinDateTs)==null) {
				cidArray.add(true);
				System.out.println(roomId + "房間 " + checkinDate + "：有空房");
			}else {
				cidArray.add(false);
				System.out.println(roomId + "房間 " + checkinDate + "：無空房");
			}
			checkinDateCal.add(Calendar.DATE, 1);
		}
		if (!cidArray.contains(false)) {
			checkResult = true;
		}
		return checkResult;
	}




	//檢查訂單 (如果訂單成立回傳true)
	public boolean checkOrder(OrderListBean roomId, Date checkinDate, Date checkoutDate) {
		boolean checkResult = false;
		//檢查期間是否有空房


		//這邊要改@@
		Integer roomIdInt = Integer.parseInt(roomId.getRoomIdtoString());
		if (checkInputDate(checkinDate) && checkInputDate(checkinDate, checkoutDate) && checkRoomStatus(roomIdInt, checkinDate, checkoutDate)) {
			System.out.println("訂單成立");
			return true;
		}
		System.out.println("訂單不成立");
		return checkResult;
	}

	//成立訂單，完成寫入DB，回傳true
	public boolean orderCreate(OrderListBean roomId, Timestamp checkinDate, Timestamp checkoutDate) {
		boolean result;
		//olDao.save();
		//odDao.save(OrderDetailBean orderDetail);
		if (checkOrder(roomId, checkinDate, checkoutDate)) {
			System.out.println("訂單存入DB");
			//Integer roomIdInt = Integer.parseInt(roomId.getRoomIdtoString());

			//建的假物件，待修改
			OrderDetailBean odb = new OrderDetailBean(suborderId, orderId, roomIdInt, checkinDate, messageStr);
			odDao.save(odb);
			result = true;
		}else {
			System.out.println("訂單被拋棄");
			result = false;
		}
		return result;

	}


}
