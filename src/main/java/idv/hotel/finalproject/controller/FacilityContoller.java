package idv.hotel.finalproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import idv.hotel.finalproject.model.FacilityBean;
import idv.hotel.finalproject.service.FacilityServive;

@Controller
public class FacilityContoller {

	@Autowired
	private FacilityServive fService;

	@GetMapping("admin/facility/showBacksatge")
	public String findBackstage(Model model) {
		List<FacilityBean> beans = fService.findAll();

		model.addAttribute("facility", beans);
		return "/facility/backstageFacility";
	}

	@GetMapping("public/facility/show")
	public String findAll(Model model) {
		List<FacilityBean> beans = fService.findAll();

		model.addAttribute("facility", beans);
		return "/facility/facility";

	}
}
