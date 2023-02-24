package idv.hotel.finalproject.dao;

import java.util.List;

import idv.hotel.finalproject.model.LoginBean;

public interface LoginDao {
	LoginBean findByEmail(String email);
	
	List<LoginBean> findAll();

	Object save(LoginBean bean);
	
	void update(LoginBean bean); 

	void deleteById(Integer key);
}