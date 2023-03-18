package idv.hotel.finalproject.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.service.AttractionService;
import idv.hotel.finalproject.dao.AttractionDao;
import idv.hotel.finalproject.model.AttractionBean;

@Service
public class AttractionServiceImpl implements AttractionService {
	@Autowired
	private AttractionDao aDao;



	@Override
	public List<AttractionBean> findDataAll() {
		List<AttractionBean> aBeanList = aDao.findAll();
		return aBeanList;
	}

	@Override
	public AttractionBean findDataById(Integer id) {
		/*
		Optional<AttractionBean> aBeanList = aDao.findById(id);
		if(aBeanList.isEmpty()) {return null;}
		return aBeanList.get();
		AttractionBean aBean = aBeanList.orElse(null);
		*/
		AttractionBean aBean = aDao.findByAttractionId(id);
		return aBean;
	}

	@Override
	public List<AttractionBean> findDataByNum(Integer Num) {
		// TODO 自動產生的方法 Stub
		return null;
	}

	@Override
	public List<AttractionBean> findDataByName(String name) {
		// TODO 自動產生的方法 Stub
		return null;
	}

	@Override
	public List<AttractionBean> findDataByCategory(String category) {
		List<AttractionBean> aBeanList = aDao.findByAttractionCategory(category);
		return aBeanList;
	}

	@Override
	public List<AttractionBean> findDataByAddress(String address) {
		// TODO 自動產生的方法 Stub
		return null;
	}

	@Override
	public List<AttractionBean> findDataByDistance(Float attractionDistance) {
		// TODO 自動產生的方法 Stub
		return null;
	}

	@Override
	public List<AttractionBean> findDataByIntroduction(String attractionIntroduction) {
		// TODO 自動產生的方法 Stub
		return null;
	}

	@Override
	public List<AttractionBean> findDataByNameLike(String name) {
		List<AttractionBean> aBeanList = aDao.findByAttractionNameContaining(name);
		return aBeanList;
	}

	@Override
	public List<AttractionBean> findDataByCategoryLike(String category) {
		List<AttractionBean> aBeanList = aDao.findByAttractionCategoryContaining(category);
		return aBeanList;
	}

	@Override
	public List<AttractionBean> findDataByAddressLike(String address) {
		List<AttractionBean> aBeanList = aDao.findByAttractionAddressContaining(address);
		return aBeanList;
	}

	@Override
	public List<AttractionBean> findDataByDistanceBetween(Float distance) {
		//List<AttractionBean> aBeanList = aDao.findByAttractionDistanceBetWeen(distance);
		//return aBeanList;
		return null;
	}

	@Override
	public List<AttractionBean> findDataByIntroductionLike(String introduction) {
		List<AttractionBean> aBeanList = aDao.findByAttractionAddressContaining(introduction);
		return aBeanList;
	}

	@Override
	public AttractionBean saveData(AttractionBean aBean) {
		AttractionBean result = aDao.save(aBean);
		return result;
	}

	@Override
	public List<AttractionBean> saveDataByNum(Integer Num) {
		// TODO 自動產生的方法 Stub
		return null;
	}

	@Override
	@Transactional
	public boolean updateDataById(AttractionBean aBean) {
		boolean result=false;
		AttractionBean aBeanReturn = aDao.save(aBean);
		if(aBeanReturn != null) {
			result=true;
		}
		return result;
	}

	@Override
	@Transactional
	public boolean deleteDataById(Integer id) {
		boolean result=false;
		aDao.deleteByAttractionId(id);
		result=true;
		return result;
	}
}
