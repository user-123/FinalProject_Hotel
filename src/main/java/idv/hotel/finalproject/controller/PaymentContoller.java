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
import idv.hotel.finalproject.model.OrderListBean;
import idv.hotel.finalproject.service.OrderService;
import idv.hotel.finalproject.service.PaymentService;

@Controller
public class PaymentContoller {

	public static AllInOne all = new AllInOne("");

	@Autowired
	private PaymentService pService;

	@Autowired
	private OrderService oService;

	@PostMapping("/ECPay")
	@ResponseBody
	public String processPayment(HttpServletRequest request, @RequestParam String ItemName,
			@RequestParam String TradeDesc, @RequestParam String TotalAmount, @RequestParam Integer id) {
		String form = pService.genAioCheckOutALL(ItemName, TradeDesc, TotalAmount);
		request.getSession().setAttribute("Id", id);
		return form;
	}

	@PostMapping("/ECPayEnd")
	public String processPaymentResult(HttpServletRequest request, Model model) {
		Integer Id = (Integer) request.getSession().getAttribute("Id");

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
			OrderListBean bean = oService.findId(Id);
			System.out.println(bean);
			bean.setPaid("已付款");
			oService.insertB(bean);
		} else {
			model.addAttribute("gree", "付款失敗");
		}
		return "payment/response";

	}

}
