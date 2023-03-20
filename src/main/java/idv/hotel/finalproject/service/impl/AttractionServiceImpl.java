package idv.hotel.finalproject.service.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	public AttractionBean updateDataById(AttractionBean aBean) {
		//boolean result=false;
		AttractionBean aBeanReturn = aDao.save(aBean);
		//if(aBeanReturn != null) {
		//	result=true;
		//}
		return aBeanReturn;
	}

	@Override
	@Transactional
	public boolean deleteDataById(Integer id) {
		boolean result=false;
		aDao.deleteByAttractionId(id);
		result=true;
		return result;
	}
	@Override
	public boolean outputPhotoFile(MultipartFile photoFile, String photoFilename, HttpServletRequest hsRequest) throws IOException {
		boolean result = false;
		byte[] photoFileBytes = photoFile.getBytes();
		//InputStream photoFileInputStream = photoFile.getInputStream();
		String uploadPath = "/attractionPhoto";
		String uploadRealPath = hsRequest.getServletContext().getRealPath(uploadPath);
		//System.out.println(uploadRealPath);
		File uploadDir = new File(uploadRealPath);
		if(!uploadDir.isDirectory()) {
			uploadDir.mkdirs();
		}
		Path photoOutputPath = Paths.get(uploadRealPath, photoFilename);
		//System.out.println(photoOutputPath);
		if(!photoFileBytes.toString().isEmpty()) {
			Path outputPathResult = Files.write(photoOutputPath, photoFileBytes);
			System.out.println(outputPathResult);
			if(!outputPathResult.toString().isEmpty()) {
				result = true;
			}
		}
		/*
		BufferedOutputStream photoBos = new BufferedOutputStream(new FileOutputStream(new File(photoFilename)));
		photoBos.write(photoFileBytes);
		photoBos.flush();
		photoBos.close();
		*/
		return result;
	}
	@Override
	public String outputPhotoPath(@RequestParam MultipartFile photoFile, HttpServletRequest hsRequest) throws IOException {
		String photoFilename = null;
		if(!photoFile.getOriginalFilename().isEmpty()) {
			Timestamp ts = new Timestamp(System.currentTimeMillis());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String tsString = sdf.format(ts);
			String originalFilename = photoFile.getOriginalFilename();
			String filenameExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
			//String filenameExtension = photoFile.getOriginalFilename().substring(photoFile.getOriginalFilename().lastIndexOf("."));
			String fileType = filenameExtension;
			//System.out.println(fileType);
			photoFilename = tsString + fileType;
		}
		if(!outputPhotoFile(photoFile, photoFilename, hsRequest)) {
			photoFilename = "";
		}
		return photoFilename;
	}
}
