package idv.hotel.finalproject.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.ProductBean;

public interface ProductDao extends JpaRepository<ProductBean, Integer> {
	@Query(value = "SELECT * FROM Product WHERE FK_category = ?1", nativeQuery = true)
	public Page<ProductBean> findByCategory(Integer categoryId, Pageable pageable);
	
	@Query(value="select count(*) from Product p where p.FK_category = ?1",nativeQuery=true)
    public long countByCategory(Integer categoryId);
	
//	@Modifying
//	@Query(value="UPDATE product SET status = ?1 WHERE productId = ?2", nativeQuery=true)
//	public void updateStatus(Integer status, Integer productId);
	
	
	
	
}
