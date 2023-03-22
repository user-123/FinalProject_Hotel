package idv.hotel.finalproject.controller;

import java.math.BigDecimal;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.MessageBean;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.MessageService;

@Controller
public class MessageController {
	@Autowired
	private MessageService ms;

	@Autowired
	private LoginService ls;

	// **************前台**************
	// navbar[評價我們]按鈕發請求過來
	@GetMapping("public/messages/all")
	public String addMessagePage(Model model) {
		List<MessageBean> mBean = ms.findAll();
		BigDecimal averageStar = ms.AverageStar();
		// 顯示所有住客評價在messages.jsp
		model.addAttribute("datas", mBean);
		model.addAttribute("averageStar", averageStar);

		MessageBean mb = new MessageBean();
		// 同時顯示填寫評價&星數的表格
		model.addAttribute("information", mb);
		return "message/messages";
	}

	// 會員在messages.jsp按下[送出]，發送此請求
	@PostMapping("/messages/post")
	public String addMessagePost(@ModelAttribute("information") MessageBean data, Model model,
			@RequestParam("userid") Integer userid, RedirectAttributes redirectAttributes) {
		LoginBean uid = ls.findById(userid);
		data.setUserid(uid);
		ms.insert(data);
		// 將資料放入重定向的屬性中
		redirectAttributes.addAttribute("userid", userid);
		return "redirect:/public/messages/all";
	}

	// **************後台**************
	// navbar[評價管理]按鈕發請求過來
	@GetMapping("/admin/messages/backendall")
	public String manageMessagePage(Model model) {
		List<MessageBean> mBean = ms.findAll();
		System.out.println(mBean);
		// 顯示所有住客評價
		model.addAttribute("datas", mBean);
		MessageBean emptyModel = new MessageBean();
		model.addAttribute("messages", emptyModel);
		return "message/backendmessages";
	}

	// 會員在backendmessages.jsp按下[刪除]，發送此請求
	@DeleteMapping("/admin/messages/delete")
	public String deleteMessage(@RequestParam Integer id) {
		ms.deleteById(id);
		System.out.println("----------------------------------------------id22222"+id);
		return "redirect:/admin/messages/backendall";
	}

	// 會員在backendmessages.jsp按下[送出]，發送此請求
	@PutMapping("/admin/messages/edit")
	public String replyMessage(Model model, @ModelAttribute("messages") MessageBean messages) {
		Date current_time = new Date();
		messages.setReplytime(current_time);

		MessageBean mm = ms.findById(messages.getId());
		messages.setMessagetime(mm.getMessagetime());

		ms.insert(messages);
		return "redirect:/admin/messages/backendall";
	}
}
