package idv.hotel.finalproject.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.RoomPhotoBean;

public interface RoomPhotoDao extends JpaRepository<RoomPhotoBean, Integer> {

	@Query(value = "from roomPhoto rp where rp.roomBean.id = ?1")
	public List<RoomPhotoBean> findByFk(Integer Id);
}
