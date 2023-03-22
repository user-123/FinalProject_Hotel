package idv.hotel.finalproject.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.LoginBean;

public interface LoginDao extends JpaRepository<LoginBean, Integer> {
	@Query(value="from LoginBean where email = ?1")
	public LoginBean findByEmail(String email);


	@Query(value="from LoginBean where email = ?1 and password = ?2 ")
	public LoginBean findByEmailAndPassword(String email,String password);


	@Query(value="from LoginBean where accountName like %?1% ")
	public List<LoginBean> findByAccountNameLike(String accountName);


	@Query(value="SELECT lb.accountId FROM login_info lb WHERE lb.email = ?1",nativeQuery=true)
	public Integer findIdByEmail(String email);

}
