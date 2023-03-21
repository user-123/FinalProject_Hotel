package idv.hotel.finalproject.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.dao.FacilityDao;
import idv.hotel.finalproject.model.FacilityBean;
import idv.hotel.finalproject.service.FacilityServive;

@Service
public class FacilityServiceImp implements FacilityServive {

	@Autowired
	private FacilityDao fDao;

	@Override
	public List<FacilityBean> findAll() {
		List<FacilityBean> facilityBeans = fDao.findAll();
		return facilityBeans;
	}

	@Override
	public FacilityBean findByname(String name) {
		FacilityBean facilityBean = fDao.findByname(name);
		return facilityBean;
	}

	@Override
	public FacilityBean create(FacilityBean facilityBean) {
		FacilityBean bean = fDao.save(facilityBean);
		return bean;
	}

	@Override
	public FacilityBean find(Integer Id) {
		Optional<FacilityBean> optional = fDao.findById(Id);
		return optional.get();
	}

	@Override
	public void delete(Integer Id) {
		fDao.deleteById(Id);
	}

}
