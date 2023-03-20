package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import idv.hotel.finalproject.model.CategoryBean;

public interface CategoryDao extends JpaRepository<CategoryBean, Integer> {
	
}
