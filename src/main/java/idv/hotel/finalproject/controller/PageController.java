package idv.hotel.finalproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
	
	@GetMapping("/public/test")
	public String test111() {
		return "test/navbar";
	}
	@GetMapping("/public/test2")
	public String test11111() {
		return "test/navbar2";
	}
	
}
