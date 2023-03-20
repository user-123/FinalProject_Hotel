package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.UserVerifyBean;

public interface UserVerifyDao extends JpaRepository<UserVerifyBean, Integer> {
	@Query(value="from UserVerifyBean where email = ?1 and token = ?2")
	public UserVerifyBean findByEmailAndToken(String email,String token);
	
	@Query(value="from UserVerifyBean where email = ?1 and used =?2")
	public UserVerifyBean findByEmail(String email,Boolean tf);
}
