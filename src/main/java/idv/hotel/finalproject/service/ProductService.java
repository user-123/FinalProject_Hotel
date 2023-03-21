package idv.hotel.finalproject.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.model.ProductBean;

public interface ProductService {
	void addItem(ProductBean pb,HttpSession session,HttpServletRequest request, HttpServletResponse response,@RequestParam("uploadedFile") MultipartFile uploadedFile,Integer pId) throws IOException, ServletException;
	void deletePb(Integer deleteId);
	ProductBean findByProductId(Integer productId);
	List<ProductBean> updateStatus(String productIdArr,String quantArr);
}
