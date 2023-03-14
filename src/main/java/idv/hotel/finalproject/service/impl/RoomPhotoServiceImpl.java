package idv.hotel.finalproject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.service.RoomPhotoService;
import idv.hotel.finalproject.dao.RoomPhotoDao;
import idv.hotel.finalproject.model.RoomPhotoBean;

@Service
public class RoomPhotoServiceImpl implements RoomPhotoService {

	@Autowired
	private RoomPhotoDao rPB;

	public RoomPhotoServiceImpl() {
	}

	@Override
	public void saveImg(RoomPhotoBean photoBean) {

		rPB.save(photoBean);
	}

	@Override
	public List<RoomPhotoBean> findByFk(Integer Id) {
		return rPB.findByFk(Id);
	}

}
