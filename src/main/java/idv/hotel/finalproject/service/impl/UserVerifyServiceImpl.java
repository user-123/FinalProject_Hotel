package idv.hotel.finalproject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.UserVerifyDao;
import idv.hotel.finalproject.model.UserVerifyBean;
import idv.hotel.finalproject.service.UserVerifyService;
@Transactional
@Service
public class UserVerifyServiceImpl implements UserVerifyService{
	UserVerifyDao userVerifyDao;
	@Autowired
	public UserVerifyServiceImpl(UserVerifyDao userVerifyDao) {
		super();
		this.userVerifyDao = userVerifyDao;
	}
	@Override
	public UserVerifyBean saveUserVerifyBean(UserVerifyBean ub) {
		return userVerifyDao.save(ub);
		
	}
	@Override
	public UserVerifyBean findByEmailAndToken(String email, String token) {
		
		return userVerifyDao.findByEmailAndToken(email, token);
	}
	
	@Override
	public UserVerifyBean findByEmail(String email,Boolean tf) {
		
		return userVerifyDao.findByEmail(email,tf);
	}


	
	
	
	
}
