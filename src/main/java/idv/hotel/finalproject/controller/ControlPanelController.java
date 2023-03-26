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

import idv.hotel.finalproject.dto.ControlPanelDto;
import idv.hotel.finalproject.model.AttractionBean;
import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.service.AttractionService;
import idv.hotel.finalproject.service.ControlPanelService;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.OrderService;
import idv.hotel.finalproject.service.RoomService;

@Controller
public class ControlPanelController {

	@Autowired
	private ControlPanelService cpService;
	//forTEST
	@GetMapping("/public/background")
	public String testControlPanel() {

		System.out.println(cpService.calculateOccupancyRateOfDay(new Date()));
		System.out.println(cpService.calculateOccupancyRateOfMonth(new Date()));

		return "background";
	}
	@GetMapping("/public/controlpanel/getOccupancyRateOfDay")
	@ResponseBody
	public ControlPanelDto getOccupancyRateOfDayTEST(@RequestParam Date date) {
		return cpService.calculateOccupancyRateOfDay(date);
	}
	@GetMapping("/public/controlpanel/getOccupancyRateOfMonth")
	@ResponseBody
	public ControlPanelDto getOccupancyRateOfMonthTEST(@RequestParam Date date) {
		return cpService.calculateOccupancyRateOfMonth(date);
	}
	//TEST_END





	@GetMapping("/admin/background")
	public String getControlPanelPage() {
		return "background";
	}

	@GetMapping("/admin/controlpanel/getOccupancyRateOfDay")
	@ResponseBody
	public ControlPanelDto getOccupancyRateOfDay(Date date) {
		return cpService.calculateOccupancyRateOfDay(date);
	}

	@GetMapping("/admin/controlpanel/getOccupancyRateOfMonth")
	@ResponseBody
	public ControlPanelDto getOccupancyRateOfMonth(Date date) {
		return cpService.calculateOccupancyRateOfMonth(date);
	}

}
