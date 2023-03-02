package idv.hotel.finalproject.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.MemberService;

@Controller
public class HomeController {
	LoginService loginService;
	MemberService memberService;
	ServletContext context;
	@Autowired
	public HomeController(MemberService memberService,LoginService loginService, ServletContext context) {
		super();
		this.loginService = loginService;
		this.memberService = memberService;
		this.context = context;
	}
	
	@PostMapping("/")
	public String home1() {
		return "home";
	}
	
	@GetMapping("/")
	public String home(HttpServletRequest request,HttpSession session) {
//		if(session.getAttribute("email")!=null) {
//			session.setAttribute("id",loginService.findIdByEmail((String)session.getAttribute("email")) );
////			session.setAttribute("lb", loginService.findById((Integer)session.getAttribute("id")));
//        	request.setAttribute("login", true);
//        }
//		return "home";
		
		
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null && auth.isAuthenticated()) {
	    	if(!auth.getName().equals("anonymousUser")) {
		        session.setAttribute("email", auth.getName());
		        session.setAttribute("login", true);
		        session.setAttribute("id", loginService.findIdByEmail(auth.getName()));
		        session.setAttribute("lb", loginService.findById((Integer)session.getAttribute("id")));
	    	}
	        System.out.println(session.getAttribute("email"));
	    }
	    return "home";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
