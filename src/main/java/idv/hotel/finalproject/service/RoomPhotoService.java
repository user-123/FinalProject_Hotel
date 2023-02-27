package idv.hotel.finalproject.service;

import org.springframework.stereotype.Service;

import idv.hotel.finalproject.model.RoomPhotoBean;
@Service
public interface RoomPhotoService {
	public RoomPhotoBean find(Integer oneId);
}
