package idv.hotel.finalproject.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.FacilityPhotoBean;

public interface FacilityPhotoDao extends JpaRepository<FacilityPhotoBean, Integer> {

	@Query(value = "from facilityPhoto rp where rp.facilityBean.id = ?1")
	public List<FacilityPhotoBean> findByFk(Integer Id);
}
