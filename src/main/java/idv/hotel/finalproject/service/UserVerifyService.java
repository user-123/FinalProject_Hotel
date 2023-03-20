package idv.hotel.finalproject.service;

import idv.hotel.finalproject.model.UserVerifyBean;

public interface UserVerifyService {
	UserVerifyBean saveUserVerifyBean(UserVerifyBean ub);
	UserVerifyBean findByEmailAndToken(String email,String token);
	UserVerifyBean findByEmail(String email,Boolean tf);
	
}
