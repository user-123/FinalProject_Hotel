package idv.hotel.finalproject.service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.dao.HomeDao;
import idv.hotel.finalproject.model.HomeBean;
import idv.hotel.finalproject.service.HomeService;
@Service
public class HomeServiceImp implements HomeService {

	@Autowired
	private HomeDao hDao;

	@Override
	public HomeBean find(Integer Id) {
		Optional<HomeBean> homeBean = hDao.findById(Id);
		return homeBean.get();
	}

	@Override
	public HomeBean create(HomeBean homeBean) {
		return hDao.save(homeBean);
	}

}
