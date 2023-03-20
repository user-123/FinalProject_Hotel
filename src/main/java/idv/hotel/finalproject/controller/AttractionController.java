package idv.hotel.finalproject.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import idv.hotel.finalproject.model.AttractionBean;
import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.service.AttractionService;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.OrderService;
import idv.hotel.finalproject.service.RoomService;

@Controller
public class AttractionController {
	@Autowired
	private AttractionService aService;
	//@Autowired
	//private OrderService oService;

	@GetMapping("public/attraction/list")
	public String attractionFrontHome(@RequestParam(name = "category", required = false, defaultValue = "all") String category, Model model) {
		List<AttractionBean> aBeanList = aService.findDataAll();
		//System.out.println(category.equals("food"));
		//System.out.println(category.intern()=="food");
		if(category.intern()=="food") {
			aBeanList = aService.findDataByCategory("美食");
		}else if(category.intern()=="spot") {
			aBeanList = aService.findDataByCategory("景點");
		}
		//補上photoPath為空的設為預設圖片
		model.addAttribute("attraction", aBeanList);
		return "attraction/attractionListPage";
	}

	@GetMapping("admin/attraction/list")
	public String attractionBackHome(@RequestParam(name = "category", required = false, defaultValue = "all") String category, Model model) {
		List<AttractionBean> aBeanList = aService.findDataAll();
		//System.out.println(category.equals("food"));	//true
		//System.out.println(category.intern()=="food"); //true
		if(category.equals("food")) {
			aBeanList = aService.findDataByCategory("美食");
		}else if(category.equals("spot")) {
			aBeanList = aService.findDataByCategory("景點");
		}
		//補上photoPath為空的設為預設圖片
		model.addAttribute("attraction", aBeanList);
		return "attraction/attractionListPageBackground";
	}

	@GetMapping("public/attraction/findByCategory")
	public String attractionFrontFindByCategory(@RequestParam(required = false, defaultValue = "all") String category) {
		return "redirect:/public/attraction/list?category="+category;
	}

	@GetMapping("admin/attraction/findByCategory")
	public String attractionBackFindByCategory(@RequestParam(required = false, defaultValue = "all") String category) {
		return "redirect:/admin/attraction/list?category="+category;
	}

	@GetMapping("public/attraction/checkoutAttractionDetail")
	@ResponseBody
	public AttractionBean attractionFrontFindById(@RequestParam(required = true) Integer id) {
		AttractionBean aBean = aService.findDataById(id);
		return aBean;
	}

	@GetMapping("admin/attraction/checkoutAttractionDetail")
	@ResponseBody
	public AttractionBean attractionBackFindById(@RequestParam(required = true) Integer id) {
		AttractionBean aBean = aService.findDataById(id);
		return aBean;
	}

	@PostMapping("admin/attraction/createAttractionDetail")
	@ResponseBody
	public AttractionBean attractionBackCreateAttraction(@RequestParam(required = true) String name, @RequestParam(required = true) String category, @RequestParam(required = true) String address, @RequestParam(required = false) float distance, @RequestParam(required = false) String introduction, @RequestParam(required = false) String photoPath, @RequestParam(required = false) MultipartFile photoFile, HttpServletRequest hsRequest) throws IOException {
		System.out.println(photoFile);
		AttractionBean aBean = new AttractionBean();
		aBean.setAttractionName(name);
		aBean.setAttractionCategory(category);
		aBean.setAttractionAddress(address);
		aBean.setAttractionDistance(distance);
		aBean.setAttractionIntroduction(introduction);
		if(photoFile != null) {
			aBean.setAttractionPhotoPath(aService.outputPhotoPath(photoFile, hsRequest));
		}
		/*
		String photoPath = aService.outputPhotoPath(photoFile, hsRequest);
		if(!photoPath.isBlank()) {
			aBean.setAttractionPhotoPath(photoPath2);
		}
		*/
		AttractionBean aBeanReturn = aService.saveData(aBean);
		return aBeanReturn;
	}

	@PutMapping("admin/attraction/updateAttractionDetail")
	@ResponseBody
	public AttractionBean attractionBackUpdateById(@RequestParam(required = true) Integer id, @RequestParam(required = true) String name, @RequestParam(required = true) String category, @RequestParam(required = true) String address, @RequestParam(required = false) float distance, @RequestParam(required = false) String introduction, @RequestParam(required = false) String photoPath, @RequestParam(required = false) MultipartFile photoFile, HttpServletRequest hsRequest) throws IOException {
		//boolean updateResult=false;
		AttractionBean aBeanReturn = new AttractionBean();
		AttractionBean aBean = aService.findDataById(id);
		if(aBean != null) {
			aBean.setAttractionName(name);
			aBean.setAttractionCategory(category);
			aBean.setAttractionAddress(address);
			aBean.setAttractionDistance(distance);
			aBean.setAttractionIntroduction(introduction);
			if(photoFile != null) {
				aBean.setAttractionPhotoPath(aService.outputPhotoPath(photoFile, hsRequest));
				//待補上刪除舊檔案service
			}
			//if(aService.updateDataById(aBean)) {
			//	updateResult=true;
			//}
			aBeanReturn = aService.updateDataById(aBean);
		}
		return aBeanReturn;
	}

	@DeleteMapping("admin/attraction/deleteAttractionDetail")
	@ResponseBody
	public boolean attractionBackDeleteById(@RequestParam(required = true) Integer id) {
		boolean deleteResult=false;
		if(aService.deleteDataById(id)) {
			deleteResult=true;
		}
		return deleteResult;
	}





	//////////D.C.測試用
	@GetMapping("/public/attraction/XXXXX")
	public String XXXXX() {
		return "attraction/XXXXX";
	}
	//@GetMapping("/public/attraction/YYYYY")
	//@ResponseBody
	//public List<Boolean> checkRoomTest(@RequestParam Integer roomId, @RequestParam String dateString) throws ParseException {		//待確認service argument型別
	//	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	//	Date date = dateFormat.parse(dateString);
	//	return oService.checkRoomState(roomId, date);
	//}
	//////////D.C.測試用
}
