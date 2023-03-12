package idv.hotel.finalproject.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.service.RoomService;
import idv.hotel.finalproject.dao.RoomDao;
import idv.hotel.finalproject.model.RoomBean;

@Service
public class RoomServiceImpl implements RoomService {
	@Autowired
	private RoomDao rDAO;

	public List<RoomBean> findAll() {
		List<RoomBean> room = rDAO.findAll();
		return room;
	}

	public RoomBean find(Integer Id) {
		Optional<RoomBean> roomBean = rDAO.findById(Id);
		return roomBean.get();
	}

	@Override
	public List<RoomBean> findType(String type) {
		List<RoomBean> roomType = rDAO.findByType(type);
		return roomType;
	}

	@Override
	public RoomBean create(RoomBean roomBean) {
		return rDAO.save(roomBean);
	}

	@Override
	public void delete(Integer Id) {
		rDAO.deleteById(Id);
	}

	@Override
	public RoomBean ReferenceById(Integer Id) {
		RoomBean bean = rDAO.getReferenceById(Id);
		return bean;
	}

	@Override
	public RoomBean findByroomId(Integer roomId) {
		RoomBean bean = rDAO.findByroomId(roomId);
		return bean;
	}

	@Override
	public RoomBean findByname(String name) {
		RoomBean bean = rDAO.findByname(name);
		return bean;
	}
}
