package idv.hotel.finalproject.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.model.AttractionBean;

@Service
public interface AttractionService {
	//精確搜尋
	public List<AttractionBean> findDataAll();
	public AttractionBean findDataById(Integer id);
	public List<AttractionBean> findDataByNum(Integer Num);
	public List<AttractionBean> findDataByName(String name);
	public List<AttractionBean> findDataByCategory(String category);
	public List<AttractionBean> findDataByAddress(String address);
	public List<AttractionBean> findDataByDistance(Float distance);
	public List<AttractionBean> findDataByIntroduction(String introduction);
	//模糊搜尋
	public List<AttractionBean> findDataByNameLike(String name);
	public List<AttractionBean> findDataByCategoryLike(String category);
	public List<AttractionBean> findDataByAddressLike(String address);
	public List<AttractionBean> findDataByDistanceBetween(Float distance);
	public List<AttractionBean> findDataByIntroductionLike(String introduction);
	//儲存資料
	public AttractionBean saveData(AttractionBean aBean);
	public List<AttractionBean> saveDataByNum(Integer Num);
	//更新資料
	public AttractionBean updateDataById(AttractionBean aBean);
	//刪除資料
	public boolean deleteDataById(Integer id);
	//照片處理
	public boolean outputPhotoFile(MultipartFile photoFile, String photoFilename, HttpServletRequest hsRequest) throws IOException;
	public String outputPhotoPath(MultipartFile photoFile, HttpServletRequest hsRequest) throws IOException;
	//商業邏輯


}
