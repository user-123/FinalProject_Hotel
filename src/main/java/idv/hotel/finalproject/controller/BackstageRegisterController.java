package idv.hotel.finalproject.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.MessageBean;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.MemberService;
import idv.hotel.finalproject.service.MessageService;
import idv.hotel.finalproject.service.OrderProductService;
import idv.hotel.finalproject.service.OrderService;
import idv.hotel.finalproject.service.ShoppingCarService;
import idv.hotel.finalproject.validate.LoginValidator;

@Controller
public class BackstageRegisterController {
	LoginService loginService;
	MemberService memberService;
	MessageService messageService;
	ShoppingCarService shoppingCarService;
	OrderProductService orderProductService;
	OrderService orderService;
	ServletContext context;

	public BackstageRegisterController(OrderService orderService,OrderProductService orderProductService,ShoppingCarService shoppingCarService,MessageService messageService,LoginService loginService,MemberService memberService, ServletContext context) {
		super();
		this.loginService = loginService;
		this.messageService = messageService;
		this.memberService = memberService;
		this.shoppingCarService = shoppingCarService;
		this.orderProductService = orderProductService;
		this.orderService = orderService;
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
				"confirm",
				"search"
				);
	}




	@GetMapping("/admin/backstage/member")
	public String backstage() {
		return "memberbackstage/memberbackstagehome";
	}



	@PostMapping("/admin/backstage/insertadmin")
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
			return "新增失敗";
		}
		try {
			loginService.register(lb);
			result = "新增成功";
		}catch(Exception e) {
			result = "新增失敗";
		}
		return result;
	}



	@GetMapping("/admin/backstage/search")
	@ResponseBody
	public ArrayList<ArrayList<String>> search(@RequestParam String search,Model model,HttpServletRequest request) {
		return loginService.showAdmin(request,search);
	}


	@DeleteMapping("/admin/backstage/deleterow")
	@ResponseBody
	public String delete(@RequestParam String deleteId) {
		if(loginService.findById(Integer.valueOf(deleteId)).getMember()!=null) {
			Integer deletembId=loginService.findById(Integer.valueOf(deleteId)).getMember().getMemberId();
			memberService.deleteMb(deletembId);
		}
		
		List<MessageBean> meblist = messageService.findByLoginId(Integer.valueOf(deleteId));
		if(meblist.size()!=0) {
			for(int i=0;i<meblist.size();i++) {
				meblist.get(i).setUserid(null);
				messageService.insert(meblist.get(i));
			}
		}
		
		shoppingCarService.deleteShoppingCarLoginBean(Integer.valueOf(deleteId));
		
		
		LoginBean lb = loginService.findById(Integer.valueOf(deleteId));
		orderProductService.setLoginBeanFkNull(lb);
		orderService.setLoginBeanFkNull(lb);
		
		loginService.deleteLb(Integer.valueOf(deleteId));
		return "";
	}



//	@PutMapping("/admin/updaterow")
//	@ResponseBody
//	public String update() {
//
//		return "";
//	}

}
