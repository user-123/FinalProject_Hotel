package idv.hotel.finalproject.controller;

import java.util.ArrayList;
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

	// 從展示系統[訂房]按鈕發請求過來
	// 此時會員看到的是填寫訂房資訊的表單
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
	public String findHistory(@RequestParam("文彥的id傳過來的名字") Integer userId, Model model,
			 RedirectAttributes redirectAttributes) {
		List<OrderListBean> olB = oService.findHistory(userId);
		model.addAttribute("datas", olB);
		// 從重定向屬性中取出資料
		String orderId = (String) model.asMap().get("orderid");
		model.addAttribute("orderId", orderId);
		return "order/history";
	}

	// 8.deleteDataByOrderId
	// 前台
	// 會員在history.jsp按下[刪除]，發送此請求
	// 未付款前才可取消，設計若他付款後欲取消，由飯店方取消
	@DeleteMapping("/orders/delete")
	public String deleteMessageF(@RequestParam("文彥的id傳過來的名字") Integer userId,
			@RequestParam("orderid") String orderid, RedirectAttributes redirectAttributes) {
		oService.deleteDataByOrderId(orderid);
		// 將資料放入重定向的屬性中
		redirectAttributes.addAttribute("文彥的id傳過來的名字", userId);
		redirectAttributes.addAttribute("orderid", orderid);

		return "redirect:/orders/history";
	}

	// **************************後台訂單管理下拉選單--訂單一覽表******************************

	@GetMapping("/admin/orders/findall")
	public String findAll(Model model) {
		List<OrderListBean> olB = oService.findAll();
		model.addAttribute("datas", olB);
		return "order/allData";
	}

	// **************************後台訂單管理下拉選單--用會員ID查詢******************************
	// 3.findDataByUserId
	// 此時admin看到的是填寫會員ID的空格
	// 需注意的是這裡要輸入的是LoginBean的accountId，也就是OrderListBean的userid
	@GetMapping("/admin/orders/byuserid")
	public String findDataByUserId(Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("userid", ol);
		return "order/byUserid";
	}

	// 此時admin看到的是按下查詢後返還的資料
	@PostMapping("/admin/orders/databyuserid")
	public String showDataByUserId(@ModelAttribute("userid") String userId, Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("userid", ol);

		List<OrderListBean> datas = oService.findDataByUserIdB(userId);
		model.addAttribute("datas", datas);

		return "order/byUserid";
	}

	// **************************後台訂單管理下拉選單--用訂單編號查詢******************************
	// 4.findDataByOrderId
	@GetMapping("/admin/orders/byorderid")
	public String findDataByOrderId(Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("orderid", ol);
		return "order/byOrderid";
	}

	// 此時admin看到的是按下查詢後返還的資料
	@PostMapping("/admin/orders/databyorderid")
	public String showDataBybyorderId(@ModelAttribute("orderid") String orderId, Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("orderid", ol);

		OrderListBean datas = oService.findDataByOrderIdB(orderId);
		model.addAttribute("datas", datas);

		return "order/byOrderid";
	}

	// **************************後台訂單管理下拉選單--用某日查詢******************************
	// 5.findDataByCheckdate
//	@GetMapping("/admin/orders/bycheckdate")
//	public String findDataByCheckdate(@RequestParam(required = false, defaultValue = "0") Timestamp checkdate,
//			Model model) {
//		model.addAttribute("bycheckdate", oService.findDataByCheckdate(checkdate));
//		// 顯示所有房間狀況
//		return "order/bycheckdate";
//	}

	// **************************後台訂單管理下拉選單--用下訂日期查詢******************************
	// 前端需卡控:若無該搜尋日期=>跳sweetalert
	// 6.findDataByOrderdate
	@GetMapping("/admin/orders/byorderdate")
	public String findDataByOrderdate(Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("orderdate", ol);
		return "order/byOrderdate";
	}

	// 此時admin看到的是按下查詢後返還的資料
	@PostMapping("/admin/orders/databyorderdate")
	public String showDataByOrderdate(@ModelAttribute("orderdate") String orderdate, Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("orderdate", ol);

		List<OrderListBean> datas = oService.findDataByOrderdate(orderdate);
		model.addAttribute("datas", datas);

		return "order/byOrderdate";
	}

	// **************************後台訂單管理下拉選單--用房型查詢******************************
	// 輸入id
	// 7.findDataByRoomId
	@GetMapping("/admin/orders/byroomid")
	public String findDataByRoomId(Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("roomid", ol);
		return "order/byRoomid";
	}

	// 此時admin看到的是按下查詢後返還的資料
	@PostMapping("/admin/orders/databyroomid")
	public String showDataByRoomId(@ModelAttribute("roomid") Integer roomid, Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("roomid", ol);

		List<OrderListBean> datas = oService.findDataByRoomId(roomid);
		model.addAttribute("datas", datas);

		return "order/byRoomid";
	}

	// **************************admin按下[編輯]按鈕，發送此請求******************************
	// 錯誤未排除:1.資料庫有正常更新，但前端需思考一下 2.orderdate毫秒會更改!!(雖然好像沒有很大的關係
	// 後台
	// step1導到編輯的jsp
	@GetMapping("/admin/orders/update")
	public String editData(@RequestParam Integer id, Model model, @RequestParam("orderdate") String orderdate,
			@RequestParam("jsp") String jsp, @RequestParam("searchid") String searchid) {
		model.addAttribute("orderdate", orderdate);
		OrderListBean datas = oService.findById(id);
		model.addAttribute("datas", datas);
		model.addAttribute("jsp", jsp);
		model.addAttribute("searchid", searchid);

		return "order/editData";
	}

	// step2在editData.jsp按下修改
	// 必須保留id送過來!!!因為若沒id他會新增，有id就會update(更新)
	@PutMapping("/admin/orders/editallData")
	public String update(@ModelAttribute("datas") OrderListBean datas, RedirectAttributes redirectAttributes,
			@RequestParam Integer id, @RequestParam("jsp") String jsp, @RequestParam("searchid") String searchid,
			Model model) {
		// 將資料放入重定向的屬性中
		redirectAttributes.addFlashAttribute("jsp", jsp);
		redirectAttributes.addFlashAttribute("searchid", searchid);
		// 從重定向屬性中取出資料
		String orderdate = (String) model.asMap().get("orderdate");
		model.addAttribute("datas", orderdate);
		OrderListBean ol = oService.findById(id);
		model.addAttribute("datas", ol);
		oService.insert(datas);
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
		return "redirect:/admin/orders/all";
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

	private List<OrderListBean> datas = new ArrayList<>();

	public String showModelAndView(@RequestParam("jsp") String jsp, String param, Model model) {
		String value = "";
		OrderListBean ol = new OrderListBean();
		switch (jsp) {
		case "allData":
			datas = oService.findAll();
			model.addAttribute("datas", datas);
			value = "order/allData";
			break;
		case "byUserid":
			datas = oService.findDataByUserIdB(param);
			model.addAttribute("userid", ol);
			model.addAttribute("datas", datas);
			value = "order/byUserid";
			break;
		case "byOrderid":
			model.addAttribute("orderid", ol);
			model.addAttribute("datas", "");
			value = "order/byOrderid";
			break;
		case "byOrderdate":
			datas = oService.findDataByOrderdate(param);
			model.addAttribute("orderdate", ol);
			model.addAttribute("datas", datas);
			value = "order/byOrderdate";
			break;
		case "byRoomid":
			datas = oService.findDataByRoomId(Integer.parseInt(param));
			model.addAttribute("roomid", ol);
			model.addAttribute("datas", datas);
			value = "order/byRoomid";
			break;
		}
		return value;
	}
}
