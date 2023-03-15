package idv.hotel.finalproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import idv.hotel.finalproject.model.AttractionBean;
import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.MemberBean;
import idv.hotel.finalproject.model.OrderDetailBean;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.service.AttractionService;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.MemberService;
import idv.hotel.finalproject.service.OrderService;
import idv.hotel.finalproject.service.RoomService;

@Controller
public class CreateFakeDataController {
	@Autowired
	private OrderService oService;
	@Autowired
	private LoginService lService;
	@Autowired
	private MemberService mService;
	@Autowired
	private RoomService rService;
	@Autowired
	private AttractionService aService;

	@GetMapping("/public/init")
	public String init() {
		LoginBean lBean = new LoginBean();
		MemberBean mBean = new MemberBean();
		RoomBean rBean = new RoomBean();
		OrderListBean olBean = new OrderListBean();
		OrderDetailBean odBean = new OrderDetailBean();
		AttractionBean aBean = new AttractionBean();
		return "redirect:/";
	}









}
