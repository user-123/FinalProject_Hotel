package idv.hotel.finalproject.service;

import idv.hotel.finalproject.model.LoginBean;

public interface LoginService {
	String checkEmailDuplicate(String email);

	void register(LoginBean lb);

	void login(String email,String password);
//	List<LoginBean> findAll();

	LoginBean loginFail(String email, String password);

	Integer findIdByEmail(String email);

	LoginBean findById(Integer id);
//	LoginBean findByEmailAndPassword(String email,String password);

//	Object save(LoginBean bean);

//	void update(LoginBean bean);

//	void deleteById(Integer key);



}
