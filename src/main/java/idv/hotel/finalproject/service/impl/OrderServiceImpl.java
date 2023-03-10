package idv.hotel.finalproject.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.OrderDetailDao;
import idv.hotel.finalproject.dao.OrderListDao;
import idv.hotel.finalproject.model.OrderDetailBean;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.service.OrderService;

@Transactional
@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderListDao olDao;
	@Autowired
	private OrderDetailDao odDao;

	//private Optional<OrderDetailBean> odBean = odDao.findById(0);

	//private OrderDetailBean odBean;

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
		//olb.setSuborderId(orderCreate(olb));
		orderCreate(olb);
		olDao.save(olb);
		if(checkOrder(olb, olb.getCheckindate(), olb.getCheckoutdate())) {
			System.out.println("檢查訂單先睹為快");
		}

		olb.setSuborderId(null);



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










	//確認房間狀態 (如果房間為空回傳true)	//思考需不需要改為每月的array，方便一次查詢	//修改中
	public List<Boolean> checkRoomState(Integer roomId, Date monthOfDate) {
		List<Boolean> roomStatus = new ArrayList<>();
		//Integer roomId_Integer = Integer.parseInt(roomId.getRoomIdtoString());



		//Timestamp timestamp = Timestamp.valueOf("2023-10-01 13:13:13");		//測試用，等改成接入資料
		//Calendar calendar = Calendar.getInstance();
		//calendar.setTimeInMillis(timestamp.getTime());
		//Date date = new Date(timestamp.getTime());		//測試API用，無作用


		Calendar monthOfDateCal = Calendar.getInstance();
		monthOfDateCal.setTime(monthOfDate);
	    int daysInMonth = monthOfDateCal.getActualMaximum(Calendar.DAY_OF_MONTH);
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM");
	    String dateString = formatter.format(monthOfDate);
	    //String dateString = new SimpleDateFormat("yyyy/MM").format(date);
	    System.out.println(dateString + "有幾日： " + daysInMonth + "日");
		for(int i=0; i<daysInMonth; i++) {
			Date date = monthOfDateCal.getTime();
			if (odDao.findByRoomIdAndLivingDate(roomId, date) != null) {
				System.out.println((i+1) + "日，房間已被預訂");
				roomStatus.add(false);
			}else {
				System.out.println((i+1) + "日，房間可被預訂");
				roomStatus.add(true);
			}
			monthOfDateCal.add(Calendar.DATE, 1);
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
	//檢查期間是否有空房，迴圈檢查每一日空房狀況，如果有任一日房間不為空(已被訂)，回傳false
	public boolean checkRoomStatus(Integer roomId, Date checkinDate, Date checkoutDate) {
		boolean checkResult = false;
		List<Boolean> cidArray = new ArrayList<>();
		Calendar checkinDateCal = Calendar.getInstance();
		Calendar checkoutDateCal = Calendar.getInstance();
		checkinDateCal.setTime(checkinDate);
		checkoutDateCal.setTime(checkoutDate);
		while(checkinDateCal.before(checkoutDateCal)) {
			Timestamp checkinDateTs = new Timestamp(checkinDateCal.getTimeInMillis());
			if (odDao.findByRoomIdAndLivingDate(roomId, checkinDateTs)==null) {
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

		//這邊要改@@
		Integer roomIdInt = Integer.parseInt(roomId.getRoomIdtoString());
		if (checkInputDate(checkinDate) && checkInputDate(checkinDate, checkoutDate) && checkRoomStatus(roomIdInt, checkinDate, checkoutDate)) {
			System.out.println("訂單成立");
			checkResult = true;
		}
		System.out.println("訂單不成立");
		return checkResult;
	}

	//成立訂單，完成寫入DB，回傳true
	public Set<OrderDetailBean> orderCreate(OrderListBean olBean) {
		Calendar checkinDateCal = Calendar.getInstance();
		Calendar checkoutDateCal = Calendar.getInstance();
		checkinDateCal.setTime(olBean.getCheckindate());
		checkoutDateCal.setTime(olBean.getCheckoutdate());
		Set<OrderDetailBean> odBeanSet = new LinkedHashSet<OrderDetailBean>(0);
		OrderDetailBean odBean = new OrderDetailBean();
		//OrderListBean olBeanTemp = new OrderListBean();
		//olBean.setOrderid(olBean.getOrderid());



		System.out.println("========01========");
		odBean.setOrderId(olBean);
		System.out.println("========02========");
		odBean.setRoomId(Integer.parseInt(olBean.getRoomIdtoString()));
		System.out.println("========03========");
		while(checkinDateCal.before(checkoutDateCal)) {
			System.out.println("========04========");
			Date checkinDate = checkinDateCal.getTime();
			//odBean.setSuborderId(Integer.parseInt(olBean.getOrderid() + System.currentTimeMillis()));
			//odBean.setOrderId((OrderListBean.setOrderid(olBean.getOrderid()));
			odBean.setLivingDate(checkinDate);
			System.out.println(odBean);
			//odDao.save(odBean);		//改成save list
			odBeanSet.add(odBean);
			checkinDateCal.add(Calendar.DATE, 1);
			//odDao.save(odBean);


			//Order order = new Order();
			//Customer customer = customerRepository.findById(customerId);
			//order.setCustomerId(customer.getId());
			//orderRepository.save(order);
		}
		System.out.println("========05========");
		System.out.println(odBeanSet);

		//olDao.save();
		//odDao.save(OrderDetailBean orderDetail);
		/*
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
		*/
		return odBeanSet;

	}

}