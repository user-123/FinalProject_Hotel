package idv.hotel.finalproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/front")
	public String homef() {
		return "order/fronthome";
	}
	@GetMapping("/back")
	public String homeb() {
		return "order/backhome";
	}
}
