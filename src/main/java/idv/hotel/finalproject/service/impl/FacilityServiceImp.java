package idv.hotel.finalproject.service.impl;

import java.util.List;

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

}
