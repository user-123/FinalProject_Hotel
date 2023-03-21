package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.FacilityBean;

public interface FacilityDao extends JpaRepository<FacilityBean, Integer> {

	@Query(value = "from facility where name = ?1")
	public FacilityBean findByname(String name);
}
