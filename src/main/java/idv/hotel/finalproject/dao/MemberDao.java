package idv.hotel.finalproject.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.MemberBean;


public interface MemberDao extends JpaRepository<MemberBean, Integer> {
	@Query(value="from MemberBean where accountId = ?1")
	public MemberBean findByAccountId(LoginBean accountId);
}
