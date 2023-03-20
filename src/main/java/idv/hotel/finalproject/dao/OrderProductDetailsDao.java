package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import idv.hotel.finalproject.model.OrderProductDetailsBean;

public interface OrderProductDetailsDao extends JpaRepository<OrderProductDetailsBean, Integer> {
	
}
