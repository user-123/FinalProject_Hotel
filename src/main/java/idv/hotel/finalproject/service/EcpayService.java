package idv.hotel.finalproject.service;

import org.springframework.stereotype.Service;

@Service
public interface EcpayService {
	public String genAioCheckOutALL(String ItemName,String TradeDesc,String TotalAmount);
}
