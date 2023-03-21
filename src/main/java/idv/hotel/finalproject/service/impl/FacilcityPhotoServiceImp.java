package idv.hotel.finalproject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.dao.FacilityPhotoDao;
import idv.hotel.finalproject.model.FacilityPhotoBean;
import idv.hotel.finalproject.service.FacilityPhotoService;

@Service
public class FacilcityPhotoServiceImp implements FacilityPhotoService {

	@Autowired
	FacilityPhotoDao fPDao;

	@Override
	public void saveImg(FacilityPhotoBean photoBean) {
		fPDao.save(photoBean);
	}

	@Override
	public List<FacilityPhotoBean> findByFk(Integer Id) {
		return fPDao.findByFk(Id);
	}

}
