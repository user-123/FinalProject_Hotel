package idv.hotel.finalproject.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.ShoppingCarBean;

public interface ShoppingCarDao extends JpaRepository<ShoppingCarBean, Integer> {
	@Query(value="SELECT * FROM ShoppingCar sb WHERE sb.shoppingCarAccountId = ?1",nativeQuery=true)
	public List<ShoppingCarBean> findByShoppingCarAccountId(Integer id);
}
