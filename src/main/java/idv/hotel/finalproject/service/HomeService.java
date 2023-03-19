package idv.hotel.finalproject.service;

import org.springframework.stereotype.Service;

import idv.hotel.finalproject.model.HomeBean;
@Service
public interface HomeService {
	
	public HomeBean find(Integer Id);
	
	public HomeBean create(HomeBean homeBean);
}
