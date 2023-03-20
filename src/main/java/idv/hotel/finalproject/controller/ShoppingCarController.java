package idv.hotel.finalproject.controller;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import idv.hotel.finalproject.model.ShoppingCarBean;
import idv.hotel.finalproject.service.CategoryService;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.ProductService;
import idv.hotel.finalproject.service.ShoppingCarService;

@Controller
public class ShoppingCarController {
	private ShoppingCarService shoppingCarService;
	private LoginService loginService;
	private CategoryService categoryService;
	private ProductService productService;

	public ShoppingCarController(ProductService productService,CategoryService categoryService,ShoppingCarService shoppingCarService, LoginService loginService) {
		super();
		this.shoppingCarService = shoppingCarService;
		this.loginService = loginService;
		this.categoryService = categoryService;
		this.productService = productService;
	}


	
	@ModelAttribute("ShoppingCarBean")
	public ShoppingCarBean initsb() {
		ShoppingCarBean sb = new ShoppingCarBean();
		return sb; 
	}
	
//	@ModelAttribute("ProductBean")
//	public ProductBean initpb() {
//		ProductBean pb = new ProductBean();
//		return pb; 
//	}

	@InitBinder
	public void whiteListing(WebDataBinder binder) {
		binder.setAllowedFields(
				"shoppingCarId", 
				"productShoppingCar",
				"shoppingCarAccountIds"
				);
	}
	
//	@PostMapping("/addCart")
//    @ResponseBody
//    public Page<ProductBean> addCart(@RequestParam(name="c") Integer categoryId,@RequestParam(name="p") Integer pageNumber,@RequestParam Integer pId,@RequestParam Integer buyquant,ShoppingCarBean sb,HttpSession session) {
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		if (auth != null && auth.isAuthenticated()) {
//	    	if(!auth.getName().equals("anonymousUser")) {
//		        session.setAttribute("id", loginService.findIdByEmail(auth.getName()));
//	    	}
//	    }	
//		Integer accountId = Integer.valueOf(session.getAttribute("id").toString());
//		shoppingCarService.addCart(pId,sb,session,accountId,buyquant);
//		productService.updateStatus(buyquant, pId);
//        return categoryService.findByPage(categoryId,pageNumber);
//    }
	@PostMapping("/addCart")
	@ResponseBody
	public String addCart(ShoppingCarBean sb,HttpSession session,@RequestParam Integer productId) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && auth.isAuthenticated()) {
			if(!auth.getName().equals("anonymousUser")) {
				session.setAttribute("id", loginService.findIdByEmail(auth.getName()));
			}
		}	
		Integer accountId = Integer.valueOf(session.getAttribute("id").toString());
		shoppingCarService.addCart(productId,sb,accountId);
		return "";
	}
	
	
	@GetMapping("/myCart")
	public String myCart(HttpSession session,Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && auth.isAuthenticated()) {
	    	if(!auth.getName().equals("anonymousUser")) {
		        session.setAttribute("id", loginService.findIdByEmail(auth.getName()));
	    	}
	    }	
		Integer accountId = Integer.valueOf(session.getAttribute("id").toString());
		List<ShoppingCarBean> sblist = shoppingCarService.findProductInMyCart(session,accountId);
		model.addAttribute("sblist",sblist);
		return "shop/mycart";
	}
	
	
	@DeleteMapping("/deleteCart")
	@ResponseBody
	public String deleteCart(Integer cartId) {
		shoppingCarService.deleteCart(cartId);
		return "";
	}
	
	
	
	@PostMapping("/checkout")
	public String  checkout(@RequestParam("shoppingCarArr[]") int[] shoppingCarArr,@RequestParam("quantArr[]") int[] quantArr) {
		for(int i=0;i<shoppingCarArr.length;i++) {
			
		}

		return "shop/checkout";
	}
	
	
	
	
	
	
}
