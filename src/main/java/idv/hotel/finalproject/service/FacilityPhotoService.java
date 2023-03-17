package idv.hotel.finalproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import idv.hotel.finalproject.model.FacilityPhotoBean;
import idv.hotel.finalproject.model.RoomPhotoBean;

@Service
public interface FacilityPhotoService {

	public void saveImg(FacilityPhotoBean photoBean);
	
	public List<FacilityPhotoBean> findByFk(Integer Id);
}
