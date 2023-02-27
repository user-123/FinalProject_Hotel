package idv.hotel.finalproject.service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.service.RoomPhotoService;
import idv.hotel.finalproject.dao.RoomPhotoDao;
import idv.hotel.finalproject.model.RoomPhotoBean;

@Service
public class RoomPhotoServiceImpl implements RoomPhotoService {

	@Autowired
	private RoomPhotoDao rPB;

	public RoomPhotoServiceImpl() {}

	@Override
	public RoomPhotoBean find(Integer oneId) {
		Optional<RoomPhotoBean> rPBOptional = rPB.findById(oneId);
		return rPBOptional.get();
	}

}
