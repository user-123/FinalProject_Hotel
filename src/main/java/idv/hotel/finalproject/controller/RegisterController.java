package idv.hotel.finalproject.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.validate.LoginValidator;
@Controller
public class RegisterController {
	LoginService loginService;
	ServletContext context;
	@Autowired
	public RegisterController(LoginService loginService, ServletContext context) {
		super();
		this.loginService = loginService;
		this.context = context;
	}


	@ModelAttribute("loginBean")
	public LoginBean init() {
		LoginBean lb = new LoginBean();
		return lb;
	}

	@InitBinder
	public void whiteListing(WebDataBinder binder) {
		binder.setAllowedFields(
				"accountName",
				"password",
				"email",
				"confirm"
				);
	}


//	@PostMapping("/")
//	public String home1() {
//		return "home";
//	}
//
//	@GetMapping("/")
//	public String home(HttpServletRequest request,HttpSession session) {
//		if(session.getAttribute("email")!=null) {
//			session.setAttribute("id",loginService.findIdByEmail((String)session.getAttribute("email")) );
////			session.setAttribute("lb", loginService.findById((Integer)session.getAttribute("id")));
//        	request.setAttribute("login", true);
//        }
//		return "home";
//	}





	@GetMapping("/public/register")
	public String register() {
		return "registerandlogin/register";
	}


	@GetMapping(value={"/public/checkemailduplicate","/admin/backstage/checkemailduplicate"})
	@ResponseBody
    public String checkEmailDuplicate(@RequestParam String email) {

			return loginService.checkEmailDuplicate(email);

    }



	@PostMapping("/public/register")
	@ResponseBody
	public String register(@ModelAttribute("loginBean") LoginBean lb,
			BindingResult bindingResult, Model model ) {
		String result = "";

		new LoginValidator().validate(lb, bindingResult);

		if (bindingResult.hasErrors()) {
			List<ObjectError> list = bindingResult.getAllErrors();
			for(ObjectError error : list) {
				if(error.getCode().equals("loginBean.name.empty")) {
					System.out.println("loginBean.name.empty");
				}
				if(error.getCode().equals("loginBean.password.empty")) {
					System.out.println("loginBean.password.empty");
				}
				if(error.getCode().equals("loginBean.email.empty")) {
					System.out.println("loginBean.email.empty");
				}
				if(error.getCode().equals("loginBean.name.size")) {
					System.out.println("loginBean.name.size");
				}

			}
			return "註冊失敗";
		}
		try {
			loginService.register(lb);
			result = "註冊成功,3秒後跳轉";
		}catch(Exception e) {
			result = "註冊失敗";
		}
		return result;
	}


	@GetMapping("/public/loginpage")
	public String loginPage(Model model) {
		return "registerandlogin/login";
	}






//	@PostMapping("/login")
//	@ResponseBody
//	public Map<String, Object> login(@RequestParam String email,@RequestParam String password, Model model) {
//		Map<String, Object> response = new HashMap<>();
//		try {
//			loginService.loginFail(email,password).getEmail();
//			response.put("redirect","/hotel");
//		}
//		catch(Exception e) {
//	        response.put("message", "登入失敗,請再確認");
//	    }
//		return response;
//
//	}















}
