package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import idv.hotel.finalproject.model.RoomPhotoBean;

public interface RoomPhotoDao extends JpaRepository<RoomPhotoBean, Integer> {

}
