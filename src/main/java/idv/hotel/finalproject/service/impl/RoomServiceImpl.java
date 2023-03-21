package idv.hotel.finalproject.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.dao.RoomDao;
import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.service.RoomService;

@Service
public class RoomServiceImpl implements RoomService {
	@Autowired
	private RoomDao rDao;

	public List<RoomBean> findAll(){
		List<RoomBean> room =rDao.findAll();
		return room;
	}

	public RoomBean find(Integer Id) {
		Optional<RoomBean> roomBean = rDao.findById(Id);
		return roomBean.get();
	}

	@Override
	public List<RoomBean> findType(String type) {
		List<RoomBean> roomType = rDao.findByType(type);
		return roomType;
	}

	@Override
	public RoomBean create(RoomBean roomBean) {
		return rDao.save(roomBean);

	}

	@Override
	public void delete(Integer Id) {
		rDao.deleteById(Id);
	}

	@Override
	public RoomBean ReferenceById(Integer Id) {
		RoomBean bean = rDao.getReferenceById(Id);
		return bean;
	}

	@Override
	public RoomBean findByroomId(Integer roomId) {
		RoomBean bean = rDao.findByroomId(roomId);
		return bean;
	}

	@Override
	public RoomBean findByname(String name) {
		RoomBean bean = rDao.findByname(name);
		return bean;
	}
}
