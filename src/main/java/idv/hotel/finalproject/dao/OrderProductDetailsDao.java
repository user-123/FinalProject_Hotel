package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.OrderProductDetailsBean;

public interface OrderProductDetailsDao extends JpaRepository<OrderProductDetailsBean, Integer> {
	@Modifying
	@Query(value="DELETE FROM OrderProductDetails WHERE fk_details_product = ?1",nativeQuery=true)
	public void deleteOrderProductDetailsBean(Integer id);
}
