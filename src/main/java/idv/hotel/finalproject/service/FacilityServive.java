package idv.hotel.finalproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import idv.hotel.finalproject.model.FacilityBean;

@Service
public interface FacilityServive {

	public List<FacilityBean> findAll();
}
