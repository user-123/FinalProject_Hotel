package idv.hotel.finalproject.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.LoginDao;
import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.service.LoginService;
@Transactional
@Service
public class LoginServiceImpl implements LoginService {

	LoginDao loginDao;
	@Autowired
	private PasswordEncoder passwordEncoder;

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



	public ArrayList<ArrayList<String>> showAdmin(HttpServletRequest request,String search){
		ArrayList<ArrayList<String>> show = new ArrayList<>();
		List<LoginBean> mblb;
		if(search.equals(""))
			mblb = loginDao.findAll();
		else
			mblb = loginDao.findByAccountNameLike(search);
		for (LoginBean lb : mblb) {
			ArrayList<String> bean = new ArrayList<>();
			bean.add(lb.getAccountId().toString());
			bean.add(lb.getEmail());
			bean.add(lb.getAccountName());
			if(lb.getMember()==null) {
				for(int i=0;i<=4;i++) {
					bean.add("");
				}
				bean.add("/main/images/default2.jpg");
			}
			else {
				bean.add(lb.getMember().getUserName());
				if(lb.getMember().getAddress()==null)
					bean.add("");
				else
					bean.add(lb.getMember().getAddress());
				bean.add(lb.getMember().getGender());
				bean.add(lb.getMember().getPhone());
				bean.add(lb.getMember().getBirthDate().toString());
				if(lb.getMember().getPhotoPath().equals("")) {
					bean.add("/main/images/default2.jpg");
				}
				else {
					bean.add(request.getContextPath()+"/uploadDir/"+lb.getMember().getPhotoPath());
				}
			}

			show.add(bean);
		}
		return show;
	}

	@Override
	public void deleteLb(Integer deleteId) {
		loginDao.deleteById(deleteId);
	};





}
