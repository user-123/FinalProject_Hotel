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

import idv.hotel.finalproject.dao.LoginDao;
import idv.hotel.finalproject.dao.OrderDetailDao;
import idv.hotel.finalproject.dao.OrderListDao;
import idv.hotel.finalproject.dao.RoomDao;
import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.OrderDetailBean;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.service.OrderService;

@Transactional
@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderListDao olDao;
	@Autowired
	private OrderDetailDao odDao;
	@Autowired
	private LoginDao lDao;
	@Autowired
	private RoomDao rDao;

	public OrderServiceImpl() {}

	//獲取現在時間，return返回字串格式MMdd
	//**************帶資料進SQL的同時，生成訂單編號，放到名為information的model裡
	@Override
	public String createorderid() {
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("MMdd");
		String dateString = formatter.format(currentTime);
		// 由月日+4位隨機數生成流水號
		int x = (int) (Math.random() * 9000) + 1000;
		String serial = dateString + x;
		return serial;
	}
	// 9.save(後台)
	@Override
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
	public boolean insert(OrderListBean olb) {
		boolean result = false;
		if(checkOrder(olb, olb.getCheckindate(), olb.getCheckoutdate())) {
			olb.setSuborderId(orderCreate(olb));
			//orderCreate(olb);
			olDao.save(olb);
			System.out.println("檢查訂單先睹為快");
			result = true;
		}
		//olb.setSuborderId(null);
		System.out.println("檢查訂單外面");

		return result;
	}
	
	public void insertB(OrderListBean olb) {
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

	// 3.findDataByEmail(後台)
	// 查詢特定userid的訂單資料
	@Override
	public List<OrderListBean> findDataByEmail(String email) {
		//D.C.：你欠揍哦，前後台找法不一樣哦，dao不是直接複製貼上齁，或改個type，不過這不能完全怪你，有一小半是硯硯的鍋，他會員系統給的argument亂七八糟，我已經嘴過了，但是這就是用原生語句查的缺點
		//邏輯上，如果都是用entity操作，那hql語句會完全一樣，但你用原生語句就要看你現在是在拿什麼資料查，下面我直接照你的code改寫，if(等我有時間&&腦袋撞到) {再幫你全部重寫吧}
		//我直接改成用hql查，你想寫原生的話就是先查"accountName"得到"accountId"再丟進這裡查
		//啊嘿，我錯了，說明寫在controller我沒看清楚，只是你type本來也好像是錯的，還是我眼花了@@
		LoginBean lBean = lDao.findByEmail(email);
		return olDao.findDataByUserIdB(lBean);
	}

	// 4.findDataByOrderId(後台)
	// 查詢特定orderid的訂單資料
	// 讓會員可以利用訂單編號查詢自己的訂單紀錄
	// 先做findDataByUser再篩選出orderid，避免user查到不屬於他的訂單資訊
	@Override
	public OrderListBean findDataByOrderId(String orderid) {
		return olDao.findDataByOrderId(orderid);
	}

	// 6.findDataByOrderdate(後台)
	// 查詢特定下訂日期的訂單資料(訂單成立日期)
	@Override
	public List<OrderListBean> findDataByOrderdate(String order) {
		return olDao.findDataByOrderdate(order);
	}

	// 7.findDataByRoomId(後台)
	// 查詢特定房型的訂單資料
	@Override
	public List<OrderListBean> findDataByRoomId(Integer roomId) {
		RoomBean rBean = rDao.findByroomId(roomId);
		return olDao.findDataByRoomId(rBean);
	}

	// 8.deleteDataByOrderId(前後台)
	// 尚未付款前可刪除訂單
	@Override
	@Transactional
	public void deleteDataByOrderId(String orderId) {
		OrderListBean olBean = olDao.findDataByOrderId(orderId);
		odDao.deleteDataByOrderId(olBean);
		olDao.deleteDataByOrderId(orderId);
	}

	//確認1個月的房間狀態 (如果房間為空回傳true)
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
		//OrderListBean olBeanTemp = new OrderListBean();
		//olBean.setOrderid(olBean.getOrderid());



		while(checkinDateCal.before(checkoutDateCal)) {
			OrderDetailBean odBean = new OrderDetailBean();
			odBean.setOrderId(olBean);
			odBean.setRoomId(Integer.parseInt(olBean.getRoomIdtoString()));
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

	@Override
	public OrderListBean findId(Integer Id) {
		Optional<OrderListBean> orderListBean = olDao.findById(Id);

		return orderListBean.get();
	}

	@Override
	public void setLoginBeanFkNull(LoginBean lb) {
		List<OrderListBean> olList = olDao.findByLoginBean(lb);
		if(olList.size()!=0) {
			for(int i=0;i<olList.size();i++) {
				olList.get(i).setUserid(null);
			}
		}
	}

}
