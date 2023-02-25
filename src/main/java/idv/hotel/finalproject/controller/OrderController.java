package idv.hotel.finalproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import idv.hotel.finalproject.service.OrderService;

public class OrderController {
	
	@Autowired
	private OrderService oService;
	
	@PostMapping("/order/checkroominstock")
	public String checkRoomInStock(Model model) {		
		return "messages/addMessage";
		//應該return boolean，待修改
	}
	
	@GetMapping("/order/submit")
	public String addMessagePage(Model model) {		
		return "messages/addMessage";
	}
	
	@GetMapping("/order/establishment")
	public String orderEstablished(Model model) {		
		return "orderSystem/orderEstablished";
	}
}
