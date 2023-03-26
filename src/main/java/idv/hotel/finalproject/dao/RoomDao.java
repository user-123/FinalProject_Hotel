package idv.hotel.finalproject.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.RoomBean;

public interface RoomDao extends JpaRepository<RoomBean, Integer> {

	@Query(value = "from room where type = ?1")
	public List<RoomBean> findByType(String type);

	@Query(value = "from room where roomId = ?1")
	public RoomBean findByroomId(Integer roomId);

	@Query(value = "from room where name = ?1")
	public RoomBean findByname(String name);

	//@Query(value="select count(rb) from room rb")
	public long count();
}
