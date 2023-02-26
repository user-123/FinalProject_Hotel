package idv.hotel.finalproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/front")
	public String homef() {
		//測試用的前台首頁
		return "order/fronthome";
	}
	@GetMapping("/back")
	public String homeb() {
		//測試用的後台首頁
		return "order/backhome";
	}
}
