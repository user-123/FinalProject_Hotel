package idv.hotel.finalproject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.model.CategoryBean;
import idv.hotel.finalproject.model.OrderProductBean;
import idv.hotel.finalproject.model.ProductBean;
import idv.hotel.finalproject.service.CategoryService;
import idv.hotel.finalproject.service.OrderProductDetailsService;
import idv.hotel.finalproject.service.OrderProductService;
import idv.hotel.finalproject.service.ProductService;
import idv.hotel.finalproject.service.ShoppingCarService;

@Controller
public class ShopController {
	
	private CategoryService categoryService;
	
	private ProductService productService;
	
	private OrderProductService orderProductService;
	
	private OrderProductDetailsService orderProductDetailsService;
	
	private ShoppingCarService shoppingCarService;
	
	public ShopController(OrderProductDetailsService orderProductDetailsService,ShoppingCarService shoppingCarService,CategoryService categoryService, ProductService productService,OrderProductService orderProductService) {
		super();
		this.categoryService = categoryService;
		this.productService = productService;
		this.orderProductService = orderProductService;
		this.orderProductDetailsService = orderProductDetailsService;
		this.shoppingCarService = shoppingCarService;
		
	}


	
	@ModelAttribute("CategoryBean")
	public CategoryBean initcb() {
		CategoryBean cb = new CategoryBean();
		return cb; 
	}
	@ModelAttribute("ProductBean")
	public ProductBean initpb() {
		ProductBean pb = new ProductBean();
		return pb; 
	}
	
	@InitBinder
	public void whiteListing(WebDataBinder binder) {
		binder.setAllowedFields(
				"description", 
				"photo",
				"price",
				"productName",
				"status",
				"category"
				);
	}
	
	
	
	
	
	@GetMapping("public/shop")
	public String shophome(Model model) {
		model.addAttribute("categoryList",categoryService.showAllCategory());
//		model.addAttribute("categoryPages",categoryService.findByPage(categoryService.showAllCategory().get(0).getCategoryId(),1));
		return "shop/shophome";
	}
	
	@GetMapping("public/shop/show")
	@ResponseBody
	public Page<ProductBean> shophome(Model model,@RequestParam(name="c") Integer categoryId,@RequestParam(name="p") Integer pageNumber) {
//		model.addAttribute("categoryPages",categoryService.findByPage(categoryId,pageNumber));
		return categoryService.findByPage(categoryId,pageNumber);
	}
	
	
	
	@GetMapping("admin/additem")
	public String additem(Model model) {
		model.addAttribute("categoryList",categoryService.showAllCategory());
		return "shop/additem";
	}
	
	
	
	@GetMapping("admin/edititem")
	public String edititem() {
		return "shop/edititem";
	}
	
	@PostMapping("/admin/additem")
	public ResponseEntity<Map<String, String>> additem(@Valid @ModelAttribute("ProductBean") ProductBean pb,
			BindingResult bindingResult, Model model,HttpSession session,HttpServletRequest request, HttpServletResponse response,@RequestParam("uploadedFile") MultipartFile uploadedFile ) {
		System.out.println(pb.getCategory().getCategoryName());
		if (bindingResult.hasErrors()) {
			Map<String, String> errors = new HashMap<>();
			for(FieldError error : bindingResult.getFieldErrors()) {
				errors.put(error.getField(), error.getDefaultMessage());
			}
			return ResponseEntity.badRequest().body(errors);
		}
		try {
			productService.addItem(pb,session,request, response,uploadedFile,0);
			Map<String, String> success = new HashMap<>();
			success.put("success", "新增成功");
			return ResponseEntity.ok().body(success);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}	
	
	
	

	@PostMapping("/admin/edit")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> edit(@Valid @ModelAttribute("ProductBean") ProductBean pb,
			BindingResult bindingResult, Model model,HttpSession session,HttpServletRequest request, HttpServletResponse response,@RequestParam("uploadedFile") MultipartFile uploadedFile,@RequestParam(name="c") Integer categoryId,@RequestParam(name="p") Integer pageNumber,@RequestParam Integer pId) {
		System.out.println(pb.getProductName());
		System.out.println(pId);
		if (bindingResult.hasErrors()) {
			Map<String, Object> errors = new HashMap<>();
			for(FieldError error : bindingResult.getFieldErrors()) {
				errors.put(error.getField(), error.getDefaultMessage());
			}
			return ResponseEntity.badRequest().body(errors);
		}
		try {
//			pb.setProductId(pId);
			productService.addItem(pb,session,request, response,uploadedFile,pId);
			Map<String, Object> success = new HashMap<>();
			Page<ProductBean> pbjs = categoryService.findByPage(categoryId,pageNumber);
			success.put("success", pbjs);
			return ResponseEntity.ok().body(success);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	
	
	@DeleteMapping("/admin/deleteproduct")
	@ResponseBody
	public Page<ProductBean> delete(@RequestParam(name="c") Integer categoryId,@RequestParam(name="p") Integer pageNumber,@RequestParam(name="dId") Integer deleteId) {
		shoppingCarService.deleteShoppingCarBean(deleteId);
		orderProductDetailsService.deleteOrderProductDetailsBean(deleteId);
		productService.deletePb(deleteId);
		return categoryService.findByPage(categoryId,pageNumber);
	}
	
	
	
	@GetMapping("/myHistoryOrder")
	public String myHistoryOrder(Model model) {
		List<OrderProductBean> orderList = orderProductService.historyOrder();
		ArrayList<String> orderDateList = new ArrayList<>();
		for(int i=0;i<orderList.size();i++) {
			orderDateList.add(orderList.get(i).getBuyTime().toString());
		}
		ArrayList<ArrayList<ProductBean>> productList = new ArrayList<ArrayList<ProductBean>>();
		for(int i=0;i<orderList.size();i++) {
			ArrayList<ProductBean> tempList = new ArrayList<>();
			for(int y=0;y<orderList.get(i).getOrderProductDetails().size();y++) {
				ProductBean pb = orderList.get(i).getOrderProductDetails().get(y).getProductDetails();
				tempList.add(pb);
			}
			productList.add(tempList);
		}
		
		ArrayList<ArrayList<String>> quantList = new ArrayList<ArrayList<String>>();
		for(int s=0;s<orderList.size();s++) {
			ArrayList<String> tempList = new ArrayList<String>();
			for(int t=0;t<orderList.get(s).getOrderProductDetails().size();t++) {
				String quant = orderList.get(s).getOrderProductDetails().get(t).getQuant().toString();
				tempList.add(quant);
			}
			quantList.add(tempList);
		}
		
		
		model.addAttribute("orderDateList", orderDateList);
		model.addAttribute("quantList", quantList);
		model.addAttribute("productList", productList);
		return "/shop/myhistoryorder";
	}
	
}
