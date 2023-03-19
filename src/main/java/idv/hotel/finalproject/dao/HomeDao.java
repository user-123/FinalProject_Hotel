package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import idv.hotel.finalproject.model.HomeBean;

public interface HomeDao extends JpaRepository< HomeBean, Integer> {
	
	

}
