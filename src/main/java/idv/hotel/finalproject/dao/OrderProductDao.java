package idv.hotel.finalproject.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.OrderProductBean;

public interface OrderProductDao extends JpaRepository<OrderProductBean, Integer> {
	@Query(value="from OrderProductBean where loginOrder = ?1")
	public List<OrderProductBean> findByLoginBean(LoginBean lb);
	
	
}
