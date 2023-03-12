package idv.hotel.finalproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import idv.hotel.finalproject.model.RoomBean;

@Service
public interface RoomService {

	public List<RoomBean> findAll();

	public RoomBean find(Integer Id);

	public List<RoomBean> findType(String type);

	public RoomBean create(RoomBean roomBean);

	public void delete(Integer Id);

	public RoomBean ReferenceById(Integer Id);

	public RoomBean findByroomId(Integer roomId);

	public RoomBean findByname(String name);
}
