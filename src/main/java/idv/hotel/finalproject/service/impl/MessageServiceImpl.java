package idv.hotel.finalproject.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.MessageDao;
import idv.hotel.finalproject.model.MessageBean;
import idv.hotel.finalproject.service.MessageService;


@Transactional
@Service
public class MessageServiceImpl implements MessageService {
	@Autowired
	MessageDao mDao;
	
	public MessageServiceImpl() {}
	
	//**************後台**************
	@Override
	public MessageBean findById(Integer id) {
		Optional<MessageBean> optional = mDao.findById(id);
		
		if(optional.isEmpty()) {
			return null;
		}
		
		return optional.get();
	}
	
	@Override
	public void deleteById(Integer id) {
		mDao.deleteById(id);
	}
	//**************前台**************
	// 會員留言
	// 控制會員只能使用自己的userid
	@Override
	public void insert(MessageBean mb) {
		mDao.save(mb);
	}
	
	@Override
	public BigDecimal AverageStar() {
		return mDao.AverageStar();
	}
	//**************前後台**************
	@Override
	public List<MessageBean> findAll() {
		return mDao.findAll();
	}

	@Override
	public List<MessageBean> findByLoginId(Integer id) {
		return mDao.findByLoginId(id);
	}

	

}
