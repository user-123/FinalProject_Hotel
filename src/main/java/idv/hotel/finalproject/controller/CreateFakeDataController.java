package idv.hotel.finalproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

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











}
