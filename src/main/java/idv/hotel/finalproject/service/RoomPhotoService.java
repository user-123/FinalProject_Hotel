package idv.hotel.finalproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import idv.hotel.finalproject.model.RoomPhotoBean;

@Service
public interface RoomPhotoService {

	public void saveImg(RoomPhotoBean photoBean);

	public List<RoomPhotoBean> findByFk(Integer Id);
		
	
}
