package idv.hotel.finalproject.dao;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.MemberBean;
import idv.hotel.finalproject.model.MessageBean;

public interface MessageDao extends JpaRepository<MessageBean, Integer> {
	// **************後台**************
	@Transactional
	@Modifying
	@Query(value = "delete" + "  FROM [dbo].[messages]" + "  where id =?1", nativeQuery = true)
	public void deleteById(Integer id);

	// **************前台**************
	@Query(value = "SELECT ROUND(AVG(stars), 3) " + "  FROM [dbo].[messages]", nativeQuery = true)
	public BigDecimal AverageStar();

	@Query(value = " SELECT *" + "  FROM [HotelDB].[dbo].[messages] order by id desc", nativeQuery = true)
	public List<MessageBean> findAll();
	
	@Query(value=" SELECT *" + "  FROM [HotelDB].[dbo].[messages] where FK_Logininfo_Id = ?1", nativeQuery = true)
	public List<MessageBean> findByLoginId(Integer id);
	
	
}
