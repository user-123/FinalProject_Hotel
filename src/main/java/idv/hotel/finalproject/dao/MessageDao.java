package idv.hotel.finalproject.dao;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.model.MessageBean;
import idv.hotel.finalproject.model.OrderListBean;

public interface MessageDao extends JpaRepository<OrderListBean, Integer> {
	//**************後台**************
	@Transactional
	@Modifying
	@Query(value = "delete"
			+ "  FROM [dbo].[messages]"
			+ "  where id =?1",nativeQuery=true)
	public void deleteById(Integer id);
	
	@Query(value = "SELECT *"
			+ "  FROM [dbo].[messages]"
			+ "  where id =?1",nativeQuery=true)
	public Object[] findMessageById(Integer id);
	//**************前台**************	
	@Query(value = "SELECT ROUND(AVG(stars), 3) "
			+ "  FROM [dbo].[messages]",nativeQuery=true)
	public BigDecimal AverageStar();
	
	public void save(MessageBean mb);
	//**************前後台**************
	@Query(value = "SELECT *"
			+ "  FROM [dbo].[messages]"
			+ "  order by id desc",nativeQuery=true)
	public List<Object[]> findAllText();	
}
