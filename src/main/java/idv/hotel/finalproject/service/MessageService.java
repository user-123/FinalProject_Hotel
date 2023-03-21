package idv.hotel.finalproject.service;

import java.math.BigDecimal;
import java.util.List;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.MemberBean;
import idv.hotel.finalproject.model.MessageBean;

public interface MessageService {

	//**************後台**************	
	public void deleteById(Integer id);
	
	public MessageBean findById(Integer id) ;
	//**************前台**************
	// 會員留言
	// 控制會員只能使用自己的userid
	public void insert(MessageBean mb);
	
	public BigDecimal AverageStar();
	//**************前後台**************
	public List<MessageBean> findAll();
	
	
	public List<MessageBean> findByLoginId(Integer id);
	
	
}
