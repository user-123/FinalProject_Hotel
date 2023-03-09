package idv.hotel.finalproject.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.OrderService;
import idv.hotel.finalproject.service.RoomService;

@Controller
public class OrderController {
	@Autowired
	private OrderService oService;
	@Autowired
	private RoomService rs;
	@Autowired
	private LoginService ls;

	// 從homecontroller發請求過來
	// 此時他看到的是addOrder.jsp
	@GetMapping("/orders/add")
	public String addMessagePage(Model model, @RequestParam("Id") Integer roomId) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("Id", roomId);
		model.addAttribute("information", ol);
		return "order/addOrder";
	}

	// 1.save(前台)
	// 會員在addOrder.jsp按下[下訂]，發送此請求
	// 把資料送進資料庫後顯示success.jsp
	@PostMapping("/orders/post")
	public String addMessagePost(@ModelAttribute("information") OrderListBean data, @RequestParam("rId") Integer roomId,
			@RequestParam("文彥的id傳過來的名字") Integer userId, Model model, RedirectAttributes redirectAttributes) {
		data.setOrderid(oService.createorderid());
		data.setPaid("未付款");
		// rr後面的方法名稱需換成小憲service的方法
		RoomBean rid = rs.find(roomId);
		// lr後面的方法名稱需換成文彥service的方法
		LoginBean uid = ls.findById(userId);
		data.setRoomid(rid);
		data.setUserid(uid);
		oService.insert(data);
		model.addAttribute("information", data);
		// 將資料放入重定向的屬性中
		redirectAttributes.addFlashAttribute("information", data);
		// 訂單成立成功的頁面
		return "redirect:/orders/show";
	}

	@GetMapping("/orders/show")
	public String showMessagePage(@ModelAttribute("information") OrderListBean data, Model model) {
		// 從重定向屬性中取出資料
		OrderListBean information = (OrderListBean) model.asMap().get("information");
		// 將資料放入模型中，以供顯示
		model.addAttribute("information", information);
		return "order/success";
	}

	// 3.findHistory
	// 查詢特定userID的訂單資料，我們幫他固定UserID，限制他只能看自己的
	@GetMapping("/orders/history")
	public String findHistory(@RequestParam("文彥的id傳過來的名字") Integer userId, Model model) {
		List<OrderListBean> olB = oService.findHistory(userId);
		model.addAttribute("datas", olB);
		return "order/history";
	}

	// 8.deleteDataByOrderId
	// 會員在history.jsp按下[刪除]，發送此請求
	// 未付款前才可取消，設計若他付款後欲取消，由飯店方取消
	@DeleteMapping("/orders/delete")
	public String deleteMessageF(@RequestParam("文彥的id傳過來的名字") Integer userId, @RequestParam String orderid,
			RedirectAttributes redirectAttributes) {
		oService.deleteDataByOrderIdF(orderid);
		// 將資料放入重定向的屬性中
		redirectAttributes.addAttribute("文彥的id傳過來的名字", userId);
		return "redirect:/orders/history";
	}

//	// **************************後台navbar--訂單一覽表******************************
//	// 2.findAll
//	@GetMapping("/admin/orders/getall")
//	public String list(Model model) {
//		List<OrderListBean> olBeans = oService.findAll();
//		model.addAttribute("orders", olBeans);
//		// 給admin資料表所有的資料
//		return "order/allData";
//	}
//
//	// **************************後台navbar--訂單查詢******************************
//	@GetMapping("/admin/orders/add")
//	public String findPage(Model model) {
//		OrderListBean ol = new OrderListBean();
//		model.addAttribute("ol", ol);
//		return "order/searchPage";
//	}
//
//	// 3.findDataByUserId
//	// admin在searchPage.jsp按下[用會員ID查詢]，發送此請求
//	@GetMapping("/admin/orders/byuserid")
//	public String findOrderByUserB(@RequestParam(required = false, defaultValue = "0") Integer userid, Model model) {
//		model.addAttribute("byuser", oService.findDataByUserIdB(userid));
//		return "order/byuserid";
//	}
//
//	// 4.findDataByOrderId
//	// admin在searchPage.jsp按下[用訂單編號查詢]，發送此請求
//	@GetMapping("/admin/orders/byorderid")
//	public String findById(@RequestParam(required = false, defaultValue = "0") String orderId, Model model) {
//		model.addAttribute("byorderid", oService.findDataByOrderId(orderId));
//		return "order/byorderid";
//	}
//
//	// 5.findDataByCheckdate
//	// admin在searchPage.jsp按下[用某日查詢]，發送此請求
//	@GetMapping("/admin/orders/bycheckdate")
//	public String findDataByCheckdate(@RequestParam(required = false, defaultValue = "0") Timestamp checkdate,
//			Model model) {
//		model.addAttribute("bycheckdate", oService.findDataByCheckdate(checkdate));
//		// 顯示所有房間狀況
//		return "order/bycheckdate";
//	}
//
//	// 6.findDataByOrderdate
//	// admin在searchPage.jsp按下[用訂單日查詢]，發送此請求
//	@GetMapping("/admin/orders/byorderdate")
//	public String findDataByOrderdate(@RequestParam(required = false, defaultValue = "0") Date orderdate, Model model) {
//		model.addAttribute("byorderdate", oService.findDataByOrderdate(orderdate));
//		return "order/byorderdate";
//	}
//
//	// 7.findDataByRoomId
//	// admin在searchPage.jsp按下[用房型查詢]，發送此請求
//	@GetMapping("/admin/orders/byroomid")
//	public String findDataByRoomId(@RequestParam(required = false, defaultValue = "0") RoomBean roomid, Model model) {
//		model.addAttribute("byroomid", oService.findDataByRoomId(roomid));
//		return "order/byroomid";
//	}
//
//	// 8.deleteDataByOrderId
//	// ******************admin在所有後台的<訂單查詢>頁面按下[刪除]，發送此請求*********************
//	// 所有後台的<訂單查詢>頁面的每筆紀錄都會有刪除按鈕
//	@DeleteMapping("/admin/orders/delete")
//	public String deleteMessageB(@RequestParam String orderid) {
//		oService.deleteDataByOrderIdB(orderid);
//		return "redirect:/order/searchPage";
//	}





	//測試用，應該寫在service

	//回應房間狀態請求
	@GetMapping("/public/orders/checkroom")		//測試用public
	@ResponseBody
	public List<Boolean> checkRoom(@RequestParam Integer roomId, @RequestParam String dateString) throws ParseException {		//待確認service argument型別
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = dateFormat.parse(dateString);
		return oService.checkRoomState(roomId, date);
	}
	@GetMapping("/public/orders/calendar")		//測試用public
	public String calendarPage() {		//待確認service argument型別
		return "order/calendar";
	}
}
