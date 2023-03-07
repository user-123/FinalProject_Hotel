package idv.hotel.finalproject.controller;

import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ecpay.payment.integration.AllInOne;
import idv.hotel.finalproject.service.EcpayService;

@Controller
public class EcpayContoller {

	public static AllInOne all = new AllInOne("");

	@Autowired
	private EcpayService eService;

	@PostMapping("/ECPay")
	@ResponseBody
	public String processPayment(HttpServletRequest request, @RequestParam String ItemName,
			@RequestParam String TradeDesc, @RequestParam String TotalAmount) {
		String form = eService.genAioCheckOutALL(ItemName, TradeDesc, TotalAmount);

		return form;
	}

	@PostMapping("/ECPayEnd")
	public String processPaymentResult(HttpServletRequest request, Model model) {

		Hashtable<String, String> dict = new Hashtable<String, String>();
		Enumeration<String> enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String paramName = enumeration.nextElement();
			String paramValue = request.getParameter(paramName);
			dict.put(paramName, paramValue);
		}

		boolean checkStatus = all.compareCheckMacValue(dict); // true：表示資料未被竄改
		// 消費者付款成功且檢查碼正確的時候： (RtnCode:交易狀態(1:成功，其餘為失敗))
		if ("1".equals(dict.get("RtnCode")) && checkStatus == true) {
			model.addAttribute("gree", "付款成功");
		} else {
			model.addAttribute("gree", "付款失敗");
		}
		return "ecpay/response";

	}

}
