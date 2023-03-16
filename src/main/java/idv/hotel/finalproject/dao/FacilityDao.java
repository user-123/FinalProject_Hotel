package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import idv.hotel.finalproject.model.FacilityBean;

public interface FacilityDao extends JpaRepository<FacilityBean, Integer> {

}
