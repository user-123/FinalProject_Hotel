package idv.hotel.finalproject.service;

import org.springframework.stereotype.Service;

@Service
public interface PaymentService {
	public String genAioCheckOutALL(String ItemName,String TradeDesc,String TotalAmount);
}
