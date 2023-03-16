package idv.hotel.finalproject.controller;

import javax.servlet.ServletContext;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import idv.hotel.finalproject.model.MemberBean;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.MemberService;
@Controller
@MultipartConfig
public class MemberController {
	MemberService memberService;
	LoginService loginService;
	ServletContext context;
	@Autowired
	public MemberController(MemberService memberService,LoginService loginService, ServletContext context) {
		super();
		this.memberService = memberService;
		this.loginService = loginService;
		this.context = context;
	}
	
	
	@ModelAttribute("memberBean")
	public MemberBean init() {
		MemberBean mb = new MemberBean();
		return mb; 
	}
	
	@InitBinder
	public void whiteListing(WebDataBinder binder) {
		binder.setAllowedFields(
				"address", 
				"birthDate",
				"gender",
				"phone",
				"photoPath",
				"userName"
				);
	}
	
	@GetMapping("/addinfo")
	public String addinfo(HttpSession session,HttpServletRequest request){
		MemberBean mb = memberService.showInfo(session,request);
		if(mb!=null)
			request.setAttribute("info", true);
			session.setAttribute("mb", mb);
		return "registerandlogin/addinfo";
	}
	
	@GetMapping("/searchinfo")
	public String searchinfo(Model model,HttpSession session,HttpServletRequest request){
//		memberService.showinfo(session);
//		MemberBean mb = (MemberBean) session.getAttribute("memberBean");
		try {
		    model.addAttribute("mb", memberService.showInfo(session,request));
		    session.setAttribute("photo", memberService.showPhoto(session, request));
		}catch(Exception e) {
			model.addAttribute("noinfo", true);
		}
		return "registerandlogin/searchinfo";
	}
	
	@PostMapping("/addinfo")
	public String addinfo(@ModelAttribute("memberBean") MemberBean mb, RedirectAttributes redirectAttributes
			,BindingResult bindingResult, Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response,@RequestParam("uploadedFile") MultipartFile uploadedFile) {
		try {
			String photo = memberService.addinfo(mb,session,request,response,uploadedFile);
//			session.setAttribute("memberBean", mb);
			session.setAttribute("photo", photo);
			redirectAttributes.addFlashAttribute("message", "新增成功");
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("message", "新增失敗");
		}
		return "redirect:/searchinfo";
	}	
	
	
}
