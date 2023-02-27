package idv.hotel.finalproject.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.RoomBean;

public interface RoomDao extends JpaRepository<RoomBean, Integer> {

	@Query(value="from room where type = ?1")
	public List<RoomBean> findByType(String type);
}
