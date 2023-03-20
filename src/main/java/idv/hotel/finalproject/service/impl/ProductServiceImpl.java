package idv.hotel.finalproject.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.dao.ProductDao;
import idv.hotel.finalproject.model.CategoryBean;
import idv.hotel.finalproject.model.ProductBean;
import idv.hotel.finalproject.service.ProductService;
@Transactional
@Service
public class ProductServiceImpl implements ProductService{
	ProductDao productDao;

	@Autowired
	public ProductServiceImpl(ProductDao productDao) {
		super();
		this.productDao = productDao;
	}

	@Override
	public void addItem(ProductBean pb,HttpSession session,HttpServletRequest request, HttpServletResponse response,@RequestParam("uploadedFile") MultipartFile uploadedFile,Integer pId) throws IOException, ServletException{
		String timeFile = new Timestamp(System.currentTimeMillis()).toString().replace(":", "");
		String filenamesql;
		Part part = request.getPart("uploadedFile");
		if(uploadedFile.isEmpty()) {
			if(pId!=0) {
				filenamesql=productDao.findById(pId).get().getPhoto();
			}
			else
				filenamesql="";
		}
		else 
			filenamesql=timeFile+part.getSubmittedFileName();
		pb.setPhoto(filenamesql);
		if(pId!=0)
			pb.setProductId(pId);
		productDao.save(pb);
		if(part == null  || part.getSize() == 0 ) {
		}
		else {
			String uploadProduct = "/uploadProduct";
			String uploadDirRealPath = request.getServletContext().getRealPath(uploadProduct);
		        File _uploadProduct = new File( uploadDirRealPath );	        
		        if(!_uploadProduct.isDirectory())
		        	_uploadProduct.mkdirs();	
					
	        	Path outputPath = Paths.get(uploadDirRealPath, filenamesql);
	        	Files.write(outputPath, uploadedFile.getBytes());	        	

		}
		
	}
	
	
	
	@Override
	public void deletePb(Integer deleteId) {
		ProductBean pb = productDao.findById(deleteId).get();
	    CategoryBean category = pb.getCategory();
	    category.getProducts().remove(pb);
	    productDao.deleteById(deleteId);
	}

	@Override
	public ProductBean findByProductId(Integer productId) {
		return productDao.findById(productId).get();
	}
	
	
	
	@Override
	public List<ProductBean> updateStatus(String productIdArr,String quantArr) {
		String[] idArr = productIdArr.split("#");
		String[] statusArr = quantArr.split("#");
		ArrayList<ProductBean> pblist = new ArrayList<>();
		for (int i=0;i<idArr.length;i++) {
			Integer productId = Integer.valueOf(idArr[i]);
			Integer quant = Integer.valueOf(statusArr[i]);
			Integer newStatus = productDao.findById(productId).get().getStatus()-quant;
			ProductBean pb = productDao.findById(productId).get();
			pb.setStatus(newStatus);
			productDao.save(pb);
			pblist.add(pb);
		}
		
		return pblist;
	}
	
	
	
	
	
	
	
	
	

}
