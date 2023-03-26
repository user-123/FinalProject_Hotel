package idv.hotel.finalproject.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	private RoomService rService;
	@Autowired
	private LoginService lService;

	// 從展示系統[訂房]按鈕發請求過來
	// 此時會員看到的是填寫訂房資訊的表單
	@GetMapping("/orders/add")
	public String addMessagePage(Model model, @RequestParam(value = "Id", required = false) Integer roomId) {
		if (roomId == null) {
			return "redirect:/public/room/orderAllShow";
		}
		// 應該要改寫為使用service回傳值設定Attribute
		RoomBean rBean = rService.find(roomId);
		model.addAttribute("roomName", rBean.getName());
		model.addAttribute("roomId", rBean.getRoomId());

		OrderListBean ol = new OrderListBean();
		model.addAttribute("Id", roomId);
		model.addAttribute("information", ol);
		return "order/addorder";
	}

	// 1.save(前台)
	// 會員在addOrder.jsp按下[下訂]，發送此請求
	// 把資料送進資料庫後顯示success.jsp
	@PostMapping("/orders/post")
	public String addMessagePost(@ModelAttribute("information") OrderListBean data, @RequestParam("rId") Integer roomId,
			@RequestParam("userId") Integer userId, Model model, RedirectAttributes redirectAttributes) {
		data.setOrderid(oService.createorderid());
		// data.setPaid("未付款");
		RoomBean rid = rService.find(roomId);
		LoginBean uid = lService.findById(userId);
		data.setRoomid(rid);
		data.setUserid(uid);
		boolean result=oService.insert(data);
		if (result) {
			model.addAttribute("information", data);
			// 將資料放入重定向的屬性中
			redirectAttributes.addFlashAttribute("lastorder", data.getOrderid());
			// 訂單成立成功的頁面
			return "redirect:/orders/show";
		}
		return "redirect:/orders/orderfail";
	}

	@GetMapping("/orders/show")
	public String showMessagePage(Model model) {
		// 從重定向屬性中取出資料
		String lastorder = (String) model.asMap().get("lastorder");
		OrderListBean information=oService.findDataByOrderId(lastorder);
		model.addAttribute("information", information);
		return "order/success";
	}

	@GetMapping("/orders/orderfail")
	public String showFailPage() {
		return "order/orderfailpage";
	}

	// 3.findHistory
	// 查詢特定userID的訂單資料，我們幫他固定UserID，限制他只能看自己的
	@GetMapping("/orders/history")
	public String findHistory(@RequestParam("accountId") Integer userId, Model model) {
		List<OrderListBean> olB = oService.findHistory(userId);
		model.addAttribute("datas", olB);
		// 從重定向屬性中取出資料
		String orderId = (String) model.asMap().get("orderid");
		model.addAttribute("orderId", orderId);
		return "order/history";
	}

	// 8.deleteDataByOrderId
	// 前台
	// 會員在history.jsp或success.jsp按下[刪除]，發送此請求
	// 未付款前才可取消，設計若他付款後欲取消，由飯店方取消
	@DeleteMapping("/orders/delete")
	public String deleteMessageF(@RequestParam("userId") Integer userId, @RequestParam String orderid,
			RedirectAttributes redirectAttributes) {
		oService.deleteDataByOrderId(orderid);
		// 將資料放入重定向的屬性中
		redirectAttributes.addAttribute("accountId", userId);
		redirectAttributes.addAttribute("orderid", orderid);

		return "redirect:/orders/history";
	}

	// **************************後台訂單管理下拉選單--訂單一覽表******************************

	@GetMapping("/admin/orders/findall")
	public String findAll(Model model) {
		List<OrderListBean> olB = oService.findAll();
		model.addAttribute("datas", olB);
		return "order/alldata";
	}

	// **************************後台訂單管理下拉選單--用房型查詢******************************
	// 輸入id
	// 7.findDataByRoomId
	@GetMapping("/admin/orders/byroomid")
	public String findDataByRoomId(Model model) {
		RoomBean ol = new RoomBean();
		model.addAttribute("roomId", ol);
		return "order/byroomid";
	}
	
	// 此時admin看到的是按下查詢後返還的資料
	@PostMapping("/admin/orders/databyroomid")
	public String showDataByRoomId(@ModelAttribute("roomId") String roomid, Model model) {
		RoomBean ol = new RoomBean();
		model.addAttribute("roomId", ol);
		Integer num=0;
		try{
		num=Integer.parseInt(roomid);
		}catch(NumberFormatException e){
			return "order/byroomid";
		}
		
		List<OrderListBean> datas = oService.findDataByRoomId(num);
		model.addAttribute("datas", datas);
		// 按下查詢後，才會有searched這個model
		// 代表設searched為true
		// 代表按下查詢後，才會做顯示內容的判斷
		model.addAttribute("searched", true);
		return "order/byroomid";
	}
	// **************************後台訂單管理下拉選單--用Email查詢******************************
	// 3.findDataByEmail
	// 此時admin看到的是填寫email的空格
	@GetMapping("/admin/orders/byemail")
	public String findDataByEmail(Model model) {
		LoginBean lb = new LoginBean();
		model.addAttribute("email", lb);
		return "order/byemail";
	}

	// 此時admin看到的是按下查詢後返還的資料
	@PostMapping("/admin/orders/databyemail")
	public String showDataByEmail(@ModelAttribute("email") String email, Model model) {
		LoginBean lb = new LoginBean();
		model.addAttribute("email", lb);
		List<OrderListBean> datas = oService.findDataByEmail(email);		
		model.addAttribute("datas", datas);
		
		// 按下查詢後，才會有searched這個model
		// 代表設searched為true
		// 代表按下查詢後，才會做顯示內容的判斷
		model.addAttribute("searched", true);

		return "order/byemail";
	}

	// **************************後台訂單管理下拉選單--用訂單編號查詢******************************
	// 4.findDataByOrderId
	@GetMapping("/admin/orders/byorderid")
	public String findDataByOrderId(Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("orderid", ol);
		return "order/byorderid";
	}

	// 此時admin看到的是按下查詢後返還的資料
	@PostMapping("/admin/orders/databyorderid")
	public String showDataBybyorderId(@ModelAttribute("orderid") String orderId, Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("orderid", ol);

		OrderListBean datas = oService.findDataByOrderId(orderId);
		model.addAttribute("datas", datas);
		// 按下查詢後，才會有searched這個model
		// 代表設searched為true
		// 代表按下查詢後，才會做顯示內容的判斷


		model.addAttribute("searched", true);
		return "order/byorderid";
	}

	// **************************後台訂單管理下拉選單--用下訂日期查詢******************************
	// 前端需卡控:若無該搜尋日期=>跳sweetalert
	// 6.findDataByOrderdate
	@GetMapping("/admin/orders/byorderdate")
	public String findDataByOrderdate(Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("orderdate", ol);
		return "order/byorderdate";
	}

	// 此時admin看到的是按下查詢後返還的資料
	@PostMapping("/admin/orders/databyorderdate")
	public String showDataByOrderdate(@ModelAttribute("orderdate") String orderdate, Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("orderdate", ol);

		List<OrderListBean> datas = oService.findDataByOrderdate(orderdate);
		model.addAttribute("datas", datas);

		// 按下查詢後，才會有searched這個model
		// 代表設searched為true
		// 代表按下查詢後，才會做顯示內容的判斷
		model.addAttribute("searched", true);
		return "order/byorderdate";
	}


	// **************************admin按下[編輯]按鈕，發送此請求******************************
	// 錯誤未排除:1.資料庫有正常更新，但前端需思考一下 2.orderdate毫秒會更改!!(雖然好像沒有很大的關係
	// 後台
	// step1導到編輯的jsp
	@GetMapping("/admin/orders/update")
	public String editData(@RequestParam Integer id, Model model, @RequestParam("jsp") String jsp,
			@RequestParam("searchid") String searchid) {
		OrderListBean datas = oService.findById(id);
		model.addAttribute("datas", datas);
		model.addAttribute("jsp", jsp);
		model.addAttribute("searchid", searchid);
		return "order/editdata";
	}


	// step2在editData.jsp按下修改
	// 必須保留id送過來!!!因為若沒id他會新增，有id就會update(更新)
	@PutMapping("/admin/orders/editallData")
	public String update(@ModelAttribute("datas") OrderListBean datas, RedirectAttributes redirectAttributes,
			@RequestParam("jsp") String jsp, @RequestParam("searchid") String searchid, Model model) {
		// 將資料放入重定向的屬性中
		redirectAttributes.addFlashAttribute("jsp", jsp);
		redirectAttributes.addFlashAttribute("searchid", searchid);
		// 從重定向屬性中取出資料
		OrderListBean datas123 = oService.findById(datas.getId());

		datas123.setMessage(datas.getMessage());
		datas123.setPaid(datas.getPaid());
		oService.insertB(datas123);
		return "redirect:/admin/orders/updateok";
	}

	// step3
	// 卡控回傳值--更新後返還之jsp
	@GetMapping("/admin/orders/updateok")
	public String afterUpdate(Model model, RedirectAttributes redirectAttributes) {
		// 從重定向屬性中取出資料
		String jsp = (String) model.asMap().get("jsp");
		String param = (String) model.asMap().get("searchid");
		String value = showModelAndView(jsp, param, model);
		// 返還sweetalert:刪除成功
		return value;
	}

	// **************************admin按下[刪除]按鈕，發送此請求******************************
	// 8.deleteDataByOrderId
	// step1
	@DeleteMapping("/admin/orders/backstagedel")
	public String deleteMessageB(@RequestParam("orderid") String orderid, @RequestParam("searchid") String searchid,
			Model model, @RequestParam("jsp") String jsp, RedirectAttributes redirectAttributes) {
		// 將資料放入重定向的屬性中
		redirectAttributes.addFlashAttribute("jsp", jsp);
		redirectAttributes.addFlashAttribute("searchid", searchid);
		oService.deleteDataByOrderId(orderid);
		return "redirect:/admin/orders/afterDelete";
	}

	// step2
	// 卡控回傳值--刪除後返還之jsp
	@GetMapping("/admin/orders/afterDelete")
	public String afterDelete(Model model, RedirectAttributes redirectAttributes) {
		// 從重定向屬性中取出資料
		String jsp = (String) model.asMap().get("jsp");
		String param = (String) model.asMap().get("searchid");
		String value = showModelAndView(jsp, param, model);
		// 返還sweetalert:刪除成功
		return value;
	}

	private List<OrderListBean> datas = new ArrayList<>(); // D.C.：你這寫法...

	public String showModelAndView(@RequestParam("jsp") String jsp, String param, Model model) {
		String value = "";
		OrderListBean ol = new OrderListBean();
		switch (jsp) {
		case "allData":
			datas = oService.findAll();
			model.addAttribute("datas", datas);
			value = "order/alldata";
			break;
		case "byEmail":
			datas = oService.findDataByEmail(param);
			model.addAttribute("email", ol);
			model.addAttribute("datas", datas);

			System.out.println(datas);
			value = "order/byuserid";
			break;
		case "byOrderid":
			model.addAttribute("orderid", ol);
			value = "order/byorderid";
			break;
		case "byOrderdate":
			datas = oService.findDataByOrderdate(param);
			model.addAttribute("orderdate", ol);
			model.addAttribute("datas", datas);
			value = "order/byorderdate";
			break;
		case "byRoomid":
			datas = oService.findDataByRoomId(Integer.parseInt(param));
			model.addAttribute("roomid", ol);
			model.addAttribute("datas", datas);
			value = "order/byroomid";
			break;
		}
		return value;
	}

	// 回應房間狀態請求
	@GetMapping("/orders/checkroom")
	@ResponseBody
	public List<Boolean> checkRoom(@RequestParam Integer roomId, @RequestParam String dateString)
			throws ParseException { // 待確認service argument型別
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = dateFormat.parse(dateString);
		return oService.checkRoomState(roomId, date);
	}

	////////// D.C.測試用
	@GetMapping("/public/orders/calendar") // 測試用public
	public String calendarPage() { // 待確認service argument型別
		return "order/calendar";
	}

	@GetMapping("/public/orders/checkroom") // 測試用public
	@ResponseBody
	public List<Boolean> checkRoomTest(@RequestParam Integer roomId, @RequestParam String dateString)
			throws ParseException { // 待確認service argument型別
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = dateFormat.parse(dateString);
		return oService.checkRoomState(roomId, date);
	}
	////////// D.C.測試用
}
