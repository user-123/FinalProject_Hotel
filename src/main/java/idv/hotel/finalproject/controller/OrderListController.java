package idv.hotel.finalproject.controller;

import java.sql.Timestamp;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.service.OrderService;

@Controller
public class OrderListController {
	@Autowired
	private OrderService oService;

	// **************************前台navbar--訂房頁面******************************
	// 此時他看到的是addOrder.jsp
	@GetMapping("/public/orders/add")
	public String addMessagePage(Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("information", ol);
		return "order/addOrder";
	}

	// 1.save(前台)
	// 會員在addOrder.jsp按下[下訂]，發送此請求
	// 把資料送進資料庫後顯示success.jsp
	@PostMapping("/front/orders/post")
	public String addMessagePost(@ModelAttribute("information") OrderListBean data, Model model,
			RedirectAttributes redirectAttributes
	/*
	 * , @RequestParam("userId") LoginBean userId, @RequestParam("roomId") RoomBean
	 * roomId
	 */ ) {
		data.setOrderid(oService.createorderid());
		LoginBean loginBean = new LoginBean();
		RoomBean roomBean = new RoomBean();
		// loginBean.setAccountId(1);
		roomBean.setRoomId(102);
		roomBean.setType("t");
		roomBean.setName("tttt");
		roomBean.setPrice(102);
		roomBean.setImg("img");
		/*
		 * data.setUserid(userId); data.setRoomid(roomId);
		 */
		data.setUserid(loginBean);
		data.setRoomid(roomBean);
		oService.insert(data);
		model.addAttribute("information", data);
		// 將資料放入重定向的屬性中
		redirectAttributes.addFlashAttribute("information", data);
		// 訂單成立成功的頁面
		return "redirect:/front/orders/show";
	}

	@GetMapping("/front/orders/show")
	public String showMessagePage(@ModelAttribute("information") OrderListBean data, Model model) {
		// 從重定向屬性中取出資料
		OrderListBean information = (OrderListBean) model.asMap().get("information");
		// 將資料放入模型中，以供顯示
		model.addAttribute("information", information);
		return "order/success";
	}

	// **************************前台navbar--歷史訂單******************************
	// 3.findHistory
	// 查詢特定userID的訂單資料，我們幫他固定UserID，限制他只能看自己的
	@GetMapping("/front/orders/history")
	public String findHistory(@RequestParam LoginBean userid, Model model) {
		List<OrderListBean> olB = oService.findHistory(userid);
		model.addAttribute("datas", olB);
		return "order/history";
	}

	// 8.deleteDataByOrderId
	// 會員在history.jsp按下[刪除]，發送此請求
	// 未付款前才可取消，設計若他付款後欲取消，由飯店方取消
	@DeleteMapping("/front/orders/delete")
	public String deleteMessageF(@RequestParam String orderid) {
		oService.deleteDataByOrderIdF(orderid);
		return "order/history";
	}

	// **************************後台navbar--訂單一覽表******************************
	// 2.findAll
	@GetMapping("/back/orders/getall")
	public String list(Model model) {
		List<OrderListBean> olBeans = oService.findAll();
		model.addAttribute("orders", olBeans);
		// 給admin資料表所有的資料
		return "order/allData";
	}

	// **************************後台navbar--訂單查詢******************************
	@GetMapping("/back/orders/add")
	public String findPage(Model model) {
		OrderListBean ol = new OrderListBean();
		model.addAttribute("ol", ol);
		return "order/searchPage";
	}

	// 3.findDataByUserId
	// admin在searchPage.jsp按下[用會員ID查詢]，發送此請求
	@GetMapping("/back/orders/byuserid")
	public String findOrderByUserB(@RequestParam(required = false, defaultValue = "0") LoginBean userid, Model model) {
		model.addAttribute("byuser", oService.findDataByUserIdB(userid));
		return "order/byuserid";
	}

	// 4.findDataByOrderId
	// admin在searchPage.jsp按下[用訂單編號查詢]，發送此請求
	@GetMapping("/back/orders/byorderid")
	public String findById(@RequestParam(required = false, defaultValue = "0") String orderId, Model model) {
		model.addAttribute("byorderid", oService.findDataByOrderId(orderId));
		return "order/byorderid";
	}

	// 5.findDataByCheckdate
	// admin在searchPage.jsp按下[用某日查詢]，發送此請求
	@GetMapping("/back/orders/bycheckdate")
	public String findDataByCheckdate(@RequestParam(required = false, defaultValue = "0") Timestamp checkdate,
			Model model) {
		model.addAttribute("bycheckdate", oService.findDataByCheckdate(checkdate));
		// 顯示所有房間狀況
		return "order/bycheckdate";
	}

	// 6.findDataByOrderdate
	// admin在searchPage.jsp按下[用訂單日查詢]，發送此請求
	@GetMapping("/back/orders/byorderdate")
	public String findDataByOrderdate(@RequestParam(required = false, defaultValue = "0") Date orderdate, Model model) {
		model.addAttribute("byorderdate", oService.findDataByOrderdate(orderdate));
		return "order/byorderdate";
	}

	// 7.findDataByRoomId
	// admin在searchPage.jsp按下[用房型查詢]，發送此請求
	@GetMapping("/back/orders/byroomid")
	public String findDataByRoomId(@RequestParam(required = false, defaultValue = "0") RoomBean roomid, Model model) {
		model.addAttribute("byroomid", oService.findDataByRoomId(roomid));
		return "order/byroomid";
	}

	// 8.deleteDataByOrderId
	// ******************admin在所有後台的<訂單查詢>頁面按下[刪除]，發送此請求*********************
	// 所有後台的<訂單查詢>頁面的每筆紀錄都會有刪除按鈕
	@DeleteMapping("/back/orders/delete")
	public String deleteMessageB(@RequestParam String orderid) {
		oService.deleteDataByOrderIdB(orderid);
		return "redirect:/order/searchPage";
	}

}
