package idv.hotel.finalproject.service.impl;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.dao.LoginDao;
import idv.hotel.finalproject.model.LoginBean;
@Transactional
@Service
public class LoginServiceImpl implements LoginService {

	LoginDao loginDao;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	public LoginServiceImpl(LoginDao loginDao) {
		this.loginDao = loginDao;
	}

	@Override
	public String checkEmailDuplicate(String email) {
		try{
			loginDao.findByEmail(email).getEmail();
			return "此帳號已被註冊,請更換";
		}catch(Exception e) {
			return "";
		}
	}

	@Override
	public void register(LoginBean lb) {
		lb.setSignupDate(new Timestamp(System.currentTimeMillis()));
		String plainPassword = lb.getPassword();
		String encodedPassword = passwordEncoder.encode(plainPassword);
		lb.setPassword(encodedPassword);
		lb.setRoles("user");
		try {
			loginDao.save(lb);
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}




	@Override
	public void login(String email,String password) {
		loginDao.findByEmailAndPassword(email,password).getEmail();
	}



	@Override
	public LoginBean loginFail(String email,String password) {
		return loginDao.findByEmailAndPassword(email,password);

	}


	@Override
	public Integer findIdByEmail(String email) {
		return loginDao.findIdByEmail(email);
	}

	public LoginBean findById(Integer id) {
		return loginDao.findById(id).get();
	}
}
